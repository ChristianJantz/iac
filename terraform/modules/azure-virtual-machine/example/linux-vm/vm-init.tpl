#!/bin/bash
sudo apt-get update -y && sudo apt-get install -y \
apt-transport-https \
curl \
gnupg

# Docker GPG Schlüssel hinzufügen
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Docker Repository hinzufügen
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker installieren
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose

# Benutzer zur Docker-Gruppe hinzufügen
sudo usermod -aG docker $USER