output "public_dns_webserver" {
  value = aws_instance.webserver.public_dns
}

output "public_ip_webserver" {
  value = aws_instance.webserver.public_ip
}

output "public_dns_prometheus" {
  value = aws_instance.prometheus.public_dns
}

output "public_ip_prometheus" {
  value = aws_instance.prometheus.public_ip
}

output "public_dns_jenkins" {
  value = aws_instance.jenkins.public_dns
}

output "public_ip_jenkins" {
  value = aws_instance.jenkins.public_ip
}
