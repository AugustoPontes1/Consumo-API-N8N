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
