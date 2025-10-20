#!/bin/bash

echo "🚀 Kaisglobal.com - GoDaddy VPS Kurulum Scripti"
echo "================================================"

# 1. Sistem güncellemesi
echo "📦 Sistem güncelleniyor..."
sudo apt update && sudo apt upgrade -y

# 2. Python 3.10 kurulumu
echo "🐍 Python kurulumu..."
sudo apt install -y python3.10 python3.10-venv python3-pip

# 3. Node.js ve yarn kurulumu
echo "📦 Node.js ve Yarn kurulumu..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn

# 4. MongoDB kurulumu
echo "🍃 MongoDB kurulumu..."
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# 5. Nginx kurulumu
echo "🌐 Nginx kurulumu..."
sudo apt install -y nginx

# 6. Proje klasörü oluştur
echo "📁 Proje klasörü hazırlanıyor..."
mkdir -p /var/www/kaisglobal
cd /var/www/kaisglobal

echo ""
echo "✅ Temel kurulum tamamlandı!"
echo ""
echo "📋 Şimdi yapmanız gerekenler:"
echo "1. Proje dosyalarını /var/www/kaisglobal klasörüne yükleyin"
echo "2. setup_app.sh scriptini çalıştırın"
