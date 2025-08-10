#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install docker.io -y 
usermod -aG docker $USER 
sudo systemctl start docker
sudo systemctl enable docker

git clone "https://github.com/keshav-raj-gautam/3-tier-app-azure-deployment"
docker build -t wanderlust-backend ./backend
docker run -d --name frontend -p 80:8080 wanderlust-frontend