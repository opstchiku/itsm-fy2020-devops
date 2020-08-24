variable "key_name" {
    description = "Name to be used on keypair"
    default     = "my_aws_key"
}

variable "ansible_instance_name" {
    description = "ansible instance name"
    default     = "ansible"
}

variable "webserver_instance_name" {
    description = "webserver instance name"
    default     = "webserver"
}

variable "prometheus_instance_name" {
    description = "prometheus instance name"
    default     = "prometheus"
}

variable "jenkins_instance_name" {
    description = "jenkins instance name"
    default     = "jenkins"
}

variable "public_key" {
    description = "Path to public key"
    default     = "./id_rsa.pub"
}

variable "private_key" {
    description = "Path to private key"
    default     = "./id_rsa"
}
