#!/bin/bash

# Instalação do Docker
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    echo "Docker installed."
else
    echo "Docker is already installed."
fi

# Instalação do Docker Compose
DOCKER_COMPOSE_VERSION="1.29.2" # Substitua por qualquer versão desejada
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose not found. Installing version ${DOCKER_COMPOSE_VERSION}..."
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed."
else
    echo "Docker Compose is already installed."
fi

# Verificando a instalação do Docker Compose
docker-compose --version

# 1. Baixar o script wait-for-it.sh e dar permissão de execução
wget -O wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
chmod +x wait-for-it.sh

# 2. Construir e inicializar os contêineres Docker em background
docker-compose up --build -d

# 3. Executar migrações do Django (opcional)
docker-compose run web python manage.py migrate

# 4. Mensagem final
echo "Docker containers estão rodando em background. Acesse a aplicação no browser em http://localhost:8000/"
