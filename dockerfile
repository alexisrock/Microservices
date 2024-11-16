FROM jenkins/jenkins:lts

# Cambiar a usuario root para instalar
USER root

# Instalar las dependencias necesarias
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Instalar Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

# Instalar Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Agregar el usuario jenkins al grupo docker
RUN usermod -aG docker jenkins

# Verificaciones de instalación
RUN docker --version && \
    docker-compose --version

# Volver al usuario jenkins
USER jenkins