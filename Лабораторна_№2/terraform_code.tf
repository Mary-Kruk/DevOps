# Визначаємо блок провайдера, щоб налаштувати провайдера AWS
provider "aws" {
  region = "us-west-2" }

# Створення VPC з двома підмережами
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example_subnet_1" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "example_subnet_2" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.2.0/24"
}

# Створення двох security groups
resource "aws_security_group" "example_sg_1" {
  name_prefix = "example_sg_1_"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "example_sg_2" {
  name_prefix = "example_sg_2_"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Створення двох екземплярів EC2

#На першому EC2 за допомогою user data та terraform remote-exec встановити Prometheus stack, Node-exporter та Cadvizor-exporter 
resource "aws_instance" "example_instance_1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet_1.id
  vpc_security_group_ids = [aws_security_group.example_sg_1.id]

  tags = {
    Name = "example-instance-1"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io

              # Запускаємо Prometheus
              sudo docker run -d --name prometheus -p 9090:9090 prom/prometheus:v2.22.0

              # Запускаємо Node Exporter
              sudo docker run -d --name node-exporter -p 9100:9100 quay.io/prometheus/node-exporter:v1.2.2

              # Запускаємо Cadvisor Exporter
              sudo docker run -d --name cadvisor-exporter -p 8080:8080 google/cadvisor:latest -prometheus_endpoint="/metrics"
              EOF
    
}
resource "null_resource" "install_prometheus" {
  depends_on = [aws_instance.example-instance-1]

  provisioner "remote-exec" {
    inline = [
      "sleep 60",  # очікування запуску екземпляра EC2 і Docker
      "curl localhost:9090",  # checking Prometheus
      "curl localhost:9100/metrics",  # checking Node-exporter
      "curl localhost:8080/metrics",  # checking Cadvizor-exporter
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.example-instance-1.public_ip
      private_key = file("example_key_pair.pem")  #SSH
    }
  }
}
#На другому EC2 за допомогою user data та terraform remote-exec встановити Nodeexporter та Cadvizor-exporter 
resource "aws_instance" "example_instance_2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet_2.id
  vpc_security_group_ids = [aws_security_group.example_sg_2.id]

  tags = {
    Name = "example-instance-2"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io

              # Запускаємо Node Exporter

              sudo docker run -d --name node-exporter -p 9100:9100 quay.io/prometheus/node-exporter:v1.2.2

              # Install Cadvisor Exporter
              sudo docker run -d --name cadvisor-exporter -p 8080:8080 google/cadvisor:latest -prometheus_endpoint="/metrics"
              EOF
 
  }
   resource "null_resource" "install_node_exporter" {
  depends_on = [aws_instance.example-instance-2]

  provisioner "remote-exec" {
    inline = [
      "sleep 60",  # очікування запуску екземпляра EC2 і Docker
      "curl localhost:9100/metrics",  # checking Node-exporter
      "curl localhost:8080/metrics",  # checking Cadvizor-exporter
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.example-instance-2.public_ip
      private_key = file("example_key_pair.pem")  # SSH
    }
  }
}



