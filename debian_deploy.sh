#!/usr/bin/env bash
set -euo pipefail

# Atualiza pacotes e instala dependências
apt-get update -y
apt-get upgrade -y
apt-get install -y git docker.io cron lsof

# Instala docker-compose manualmente (mais garantido que apt)
if ! command -v docker-compose &>/dev/null; then
  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

# Garante que os serviços necessários estão rodando
for service in docker cron; do
    systemctl start $service
    systemctl enable $service
done

# Adiciona cron job para deploy automático a cada 5min
(crontab -l 2>/dev/null | grep -v "debian_deploy.sh"; echo "*/5 * * * * /root/DeepBlue-Prototype/debian_deploy.sh") | crontab -

# Mata processos na porta 8080 (exceto docker)
lsof -ti:8080 | xargs -r kill -9

cd /root

# Atualiza ou clona projeto
if [ -d "DeepBlue-Prototype" ]; then
    cd ./DeepBlue-Prototype
    git reset --hard HEAD
    git pull https://github.com/max-leal/DeepBlue-Prototype main
else
    git clone https://github.com/max-leal/DeepBlue-Prototype.git
    cd ./DeepBlue-Prototype
fi

# Reinicia containers
docker-compose down
docker-compose up --build -d
