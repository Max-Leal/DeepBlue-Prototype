#!/usr/bin/env bash

set -euo pipefail

yum update -y
yum install -y git docker cronie lsof

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# make sure every necessary service is running
for service in docker crond; do
    systemctl start $service
    systemctl enable $service
done

#Verifies if this file is already in crontab, if it's not then it adds
(crontab -l 2>/dev/null | grep -v "aws_deploy.sh"; echo "*/5 * * * * /root/DeepBlue-Prototype/aws_deploy.sh") | crontab -

#Uses lsof to look for any process (that is not a docker) that is using one of the doors, then kills it
for porta in 8080; do
  lsof -ti:$porta | xargs -r kill -9
done

cd /root

#Verifying if the project already exists in the directory
if [ -d "DeepBlue-Prototype" ]; then
      #if it exists, it just pull all the possible new files
    	cd ./DeepBlue-Prototype
    	git reset --hard HEAD
    	git pull https://github.com/max-leal/DeepBlue-Prototype main
else
      #if it doesn't exist, it clones the project
    	git clone https://github.com/max-leal/DeepBlue-Prototype.git
    	cd ./DeepBlue-Prototype
fi

#Re-builds the docker-compose to secure it doesn't forget anything
docker-compose up --build -d

# USER DATA
# #!/usr/bin/env bash
# yum update -y && yum install -y git
# git clone https://github.com/Max-Leal/DeepBlue-Prototype.git /root
# chmod +x /root/DeepBlue-Prototype/aws_deploy.sh
# /root/DeepBlue-Prototype/aws_deploy.sh