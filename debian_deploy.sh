#!/usr/bin/env bash

set -euo pipefail

# Atualiza pacotes e instala dependências
apt-get update -y
apt-get upgrade -y
apt-get install -y git docker.io docker-compose cron lsof

# Garante que os serviços necessários estão rodando
for service in docker cron; do
    systemctl start $service
    systemctl enable $service
done

# Verifica se o cron job já existe, senão adiciona
(crontab -l 2>/dev/null | grep -v "aws_deploy.sh"; echo "*/5 * * * * /root/DeepBlue-Prototype/aws_deploy.sh") | crontab -

# Mata processos que usam a porta 8080 (se não forem docker)
for porta in 8080; do
  lsof -ti:$porta | xargs -r kill -9
done

cd /root

# Verifica se o projeto já existe
if [ -d "DeepBlue-Prototype" ]; then
    cd ./DeepBlue-Prototype
    git reset --hard HEAD
    git pull https://github.com/max-leal/DeepBlue-Prototype main
else
    git clone https://github.com/max-leal/DeepBlue-Prototype.git
    cd ./DeepBlue-Prototype
fi

# Re-build do docker-compose
docker-compose up --build -d
