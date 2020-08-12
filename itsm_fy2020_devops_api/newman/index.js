'use strict';

const axios = require('axios');
const fs = require('fs');
const commandLineArgs = require('command-line-args');
require('dotenv').config();

const execFile = require('child_process').execFile;

const optionDefinitions = [
  // テスト先の環境名
  {
    name: 'env',
    alias: 'e',
    type: String
  },
  // CodeBuildからの実行か否か
  {
    name: 'codebuild',
    alias: 'c',
    type: Boolean,
    defaultValue: false
  }
];
const options = commandLineArgs(optionDefinitions);

if (require.main === module) {
  main({ argv: process.argv })
}

// postmanテストを実行し、結果をGitHubIssueに投稿する
async function main() {
    const name = options.env;
    const codebuild = options.codebuild;

    let nmCol = '';
    let nmEnv = '';
    if(name == 'local') {
        nmCol = './collection/voucher_manual_testing.service.postman_collection.json';
        nmEnv = './environment/API_00-localhost-54251.postman_environment.json';
    }
    else if(name == 'team-dev') {
        nmCol = './collection/voucher_manual_testing.service.postman_collection.json';
        nmEnv = './environment/API_10-teamdevelop-webapi.ebook-voucher.be.postman_environment.json';
    }
    else if (name == 'team-pr') {
        nmCol = './collection/voucher_manual_testing.service.postman_collection.json';
        nmEnv = './environment/API_12-teampr-webapi.ebook-voucher.be.postman_environment.json';
    }
    else if (name == 'team-master') {
        nmCol = './collection/voucher_manual_testing.service.postman_collection.json';
        nmEnv = './environment/API_11-teammaster-webapi.ebook-voucher.be.postman_environment.json';
    }
    else if (name == 'jp-dev') {
        nmCol = './collection/voucher_manual_testing.service.postman_collection.json';
        nmEnv = './environment/API_96-dev-webapi.ebookjapan.jp.postman_environment.json';
    }
    else if (name == 'jp-stg') {
        nmCol = './collection/voucher_manual_testing.service.postman_collection.json';
        nmEnv = './environment/API_97-stg-webapi.ebookjapan.jp.postman_environment.json';
    }
    else if (name == 'jp-prev') {
        nmCol = './collection/voucher_manual_testing.service_readonly.postman_collection.json';
        const orgEnv = './environment/API_98-prev-webapi.ebookjapan.jp.postman_environment.json';
        if (codebuild){
            nmEnv = CreateTmpEnvironment(orgEnv, process.env.uuid, process.env.non_login_uuid, process.env.external_id);
        } 
        else
        {
            nmEnv = CreateTmpEnvironment(orgEnv, process.env.prev_uuid, process.env.prev_non_login_uuid, process.env.prev_external_id);
        }
    }
    else {
        console.error('環境名を指定してください。[ local | team-dev ]');
        process.exit(1);
    }

    // コマンドの実行（標準出力を取得したいのでAPIではなくコマンド形式で呼ぶ）
    execFile('npm', ['run', 'newman', '--', 'run', nmCol, '-e', nmEnv, '-r', 'cli,json', '--reporter-json-export', 'report.json'], (err, stdout, stderr) => {
        if (err) {
            console.error(err); 
        }
        if (stderr){
            console.error(stderr);
        }
        console.log(stdout);
        return;
    });

}

// 指定したenvファイルのidを書き換えた一時ファイルを作成する
function CreateTmpEnvironment(orgEnv, uuid, non_login_uuid, external_id){
    const orgEnvJson = require(orgEnv);

    if (!uuid || !non_login_uuid || !external_id){
        console.error('環境ファイルを書き換えるためのIDが指定されていません。');
        process.exit(21);
    }

    const result = {
        id: orgEnvJson.id,
        name: orgEnvJson.name + "_tmp",
        values: orgEnvJson.values
            .map((a) => {
                if (a.key == 'uuid'){
                    return {
                        "key": a.key,
                        "value": uuid,
                        "type": a.type,
                        "enabled": a.enable
                    }
                } else {
                    return a;
                }
            })
            .map((a) => {
                if (a.key == 'non_login_uuid'){
                    return {
                        "key": a.key,
                        "value": non_login_uuid,
                        "type": a.type,
                        "enabled": a.enable
                    }
                } else {
                    return a;
                }
            })
            .map((a) => {
                if (a.key == 'external-id'){
                    return {
                        "key": a.key,
                        "value": external_id,
                        "type": a.type,
                        "enabled": a.enable
                    }
                } else {
                    return a;
                }
            })
    };
    
    const newFileName = 'tmp_postman_env.json';
    fs.writeFileSync(newFileName, JSON.stringify(result, null, '  '));
    return newFileName;
}
