FROM php:8.2-cli

# Install useful tools
RUN apt-get update && apt-get install -y \
    awscli \
    default-mysql-client \
    curl \
    iputils-ping \
    dnsutils \
    netcat-openbsd \
    telnet \
    unzip \
    less \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Simple test script
COPY test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh

# Default command (keep container running)
CMD ["sleep", "infinity"]
