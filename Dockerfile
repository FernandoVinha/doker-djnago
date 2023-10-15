# Use a imagem oficial do Python
FROM python:3.9

# Define o diretório de trabalho
WORKDIR /app

# Define variáveis de ambiente
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Instala as dependências do projeto
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copia os arquivos do projeto
COPY . /app/
