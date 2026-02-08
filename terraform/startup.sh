#!/bin/bash
set -e

#Log para debug
exec > /var/log/startup.log 2>&1


#Atualizar Pacotes
apt-get update -y
apt-get install -y unzip curl ca-certificates

#Instalar Docker
curl -fsSL https://get.docker.com | bash

#Iniciar Serviço Docker
systemctl start docker
systemctl enable docker

#Instalar K3s
curl -sfL https://get.k3s.io | sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
