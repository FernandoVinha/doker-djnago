# 1. Baixar o script wait-for-it.sh e dar permissão de execução
wget -O wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
chmod +x wait-for-it.sh

# 2. Construir e inicializar os contêineres Docker em background
docker-compose up --build -d

# 3. Executar migrações do Django (opcional)
docker-compose run web python manage.py migrate

# 4. Mensagem final
echo "Docker containers estão rodando em background. Acesse a aplicação no browser em http://localhost:8000/"