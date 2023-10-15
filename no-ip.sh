#!/bin/bash

# Atualiza os pacotes do sistema
sudo apt-get update

# Instala os pacotes necessários para a compilação
sudo apt-get install -y build-essential

# Navega até o diretório /usr/local/src
cd /usr/local/src/

# Baixa e extrai o No-IP
sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
sudo tar xf noip-duc-linux.tar.gz
cd noip-2.1.9-1/

# Compila e instala o No-IP
sudo make install

# Configura o No-IP (esta etapa é manual e requer input do usuário)
echo "Por favor, configure suas credenciais No-IP e selecione os hosts para atualizar."
sudo noip2 -C

# Cria um serviço systemd para o No-IP
echo "[Unit]
Description=No-IP Dynamic DNS Update Client
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/bin/noip2

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/noip2.service

# Habilita e inicia o serviço No-IP
sudo systemctl enable noip2.service
sudo systemctl start noip2.service

# Informa ao usuário que o script foi concluído
echo "No-IP instalado e configurado com sucesso!"