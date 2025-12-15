#!/bin/bash
set -e

#Log para debug
exec > /var/log/startup.log 2>&1


#Atualizar Pacotes
apt-get update -y
apt-get install -y unzip curl ca-certificates

#Instalar AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

#Instalar Docker
curl -fsSL https://get.docker.com | bash

#Iniciar Serviço Docker
systemctl start docker
systemctl enable docker

sleep 10

echo "Login no ECR"
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 903913341413.dkr.ecr.us-east-2.amazonaws.com/obs-api:latest

echo "Pull da imagem"
docker pull 903913341413.dkr.ecr.us-east-2.amazonaws.com/obs-api:latest

echo "Subindo container"
docker run -d --restart always -p 3000:3000 --name obs-api 903913341413.dkr.ecr.us-east-2.amazonaws.com/obs-api:latest
