# Use Debian Bookworm as the base image
FROM debian:bookworm

# Set non-interactive frontend for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /scripts

# Download the install.sh and run.sh scripts
RUN curl -LO https://gitea.30-seven.cc/Wesley/BotW.Multiplayer.Server.Docker/releases/download/scripts/install.sh \
    && curl -LO https://gitea.30-seven.cc/Wesley/BotW.Multiplayer.Server.Docker/releases/download/scripts/run.sh \
    && chmod +x install.sh run.sh

# Download .NET
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt update -y \
    && apt install -y dotnet-runtime-6.0

# Expose port 5050
EXPOSE 5050

# Run install.sh and then run.sh
CMD ["bash", "-c", "./install.sh && ./run.sh"]
