output "public_dns_ansible" {
  value = aws_instance.ansible.public_dns
}

output "public_ip_ansible" {
  value = aws_instance.ansible.public_ip
}

output "public_dns_webserver" {
  value = aws_instance.webserver.public_dns
}

output "public_ip_webserver" {
  value = aws_instance.webserver.public_ip
}

output "public_dns_monitoring" {
  value = aws_instance.monitoring.public_dns
}

output "public_ip_monitoring" {
  value = aws_instance.monitoring.public_ip
}

output "public_dns_jenkins" {
  value = aws_instance.jenkins.public_dns
}

output "public_ip_jenkins" {
  value = aws_instance.jenkins.public_ip
}
