# Consumo API com N8N

## Projeto de consumo de API para obter, dividir os campos e salvar o json
no banco de dados usando n8n

## Tecnologias Utilizadas
- Python
- Docker, Docker-Compose
- Javascript
- N8N

- Código Python
```python
import requests
import json

# Buscar dados da API
response = requests.get("https://jsonplaceholder.typicode.com/posts")
data = response.json()

first_item = data[0]

output = {
    "title": first_item["title"],
    "body": first_item["body"]
}

print(json.dumps(output))
```

- Código do Dockerfile

```
FROM n8nio/n8n:latest

# usar root para instalar dependências
USER root

# instalar python3 e pip + dependências para compilação
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    python3-dev \
    libffi-dev \
    openssl-dev \
    musl-dev

# criar virtual environment
RUN python3 -m venv /opt/venv

# ativar venv e instalar pacotes Python que você precisa
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir requests

USER node
```

- Código Docker-Compose

```
services:
  n8n:
    build: .
    image: n8n-python-custom
    container_name: n8n-python
    ports:
      - "5678:5678"
    volumes:
      - ./n8n_data:/home/node/.n8n
      - ./py_scripts:/home/node/py_scripts
    environment:
      - GENERIC_TIMEZONE=America/Sao_Paulo
      - TZ=America/Sao_Paulo
    restart: unless-stopped
``` 

-Código em Javascript(n8n function)

```javascript
// Recebendo o stdout do node anterior
const raw = items[0].json.stdout;

// Parseando para JSON
const data = JSON.parse(raw);

// Retornando no formato que o Insert Row espera
return [
  {
    json: {
      title: data.title,
      body: data.body
    }
  }
];
```

- Workflow do N8N

<img width="1215" height="449" alt="image" src="https://github.com/user-attachments/assets/ad32baa0-8b48-476c-9143-f5926f9b6e23" />
