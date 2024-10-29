#!/bin/bash

init_packages() {
    # Install necessary packages
    sudo apt-get update
    sudo apt-get install -y curl wget gnupg lsb-release software-properties-common git zip unzip
}

install_docker() {
    # Add Docker's official GPG key:
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update

    # Install docker
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add docker group and add existing user to the group
    sudo groupadd docker
    sudo usermod -aG docker $USER
}

install_kubectl() {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

install_helm() {
    wget https://get.helm.sh/helm-v3.16.2-linux-amd64.tar.gz
    tar -xvzf helm-v3.16.2-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/helm
    rm helm-v3.16.2-linux-amd64.tar.gz
}

install_java() {
    sudo apt install -y openjdk-17-jre-headless
}

install_maven() {
    sudo apt-get update
    sudo apt-get install -y maven
}

_main() {
    init_packages
    install_docker
    install_java
    install_maven
    install_kubectl
    install_helm
}

_main
