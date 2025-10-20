#!/bin/bash

echo "🚀 Kaisglobal App Kurulum"
echo "========================="

APP_DIR="/var/www/kaisglobal"
DOMAIN="kaisglobal.com"

# Backend kurulumu
echo "🔧 Backend kurulumu..."
cd $APP_DIR/backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# .env dosyası oluştur
cat > .env << EOF
MONGO_URL=mongodb://localhost:27017
DB_NAME=kaisglobal_db
CORS_ORIGINS=*
EOF

# Frontend build
echo "⚛️  Frontend build..."
cd $APP_DIR/frontend
yarn install
REACT_APP_BACKEND_URL=https://$DOMAIN yarn build

# Systemd servisleri oluştur
echo "⚙️  Backend servis oluşturuluyor..."
sudo tee /etc/systemd/system/kaisglobal-backend.service > /dev/null << EOF
[Unit]
Description=Kaisglobal Backend API
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=$APP_DIR/backend
Environment="PATH=$APP_DIR/backend/venv/bin"
ExecStart=$APP_DIR/backend/venv/bin/uvicorn server:app --host 0.0.0.0 --port 8001
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Nginx yapılandırması
echo "🌐 Nginx yapılandırılıyor..."
sudo tee /etc/nginx/sites-available/$DOMAIN > /dev/null << EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    # Frontend
    location / {
        root $APP_DIR/frontend/build;
        try_files \$uri \$uri/ /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:8001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Nginx aktif et
sudo ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Servisleri başlat
echo "🚀 Servisler başlatılıyor..."
sudo systemctl daemon-reload
sudo systemctl start kaisglobal-backend
sudo systemctl enable kaisglobal-backend

echo ""
echo "✅ Kurulum tamamlandı!"
echo ""
echo "📋 Son adımlar:"
echo "1. GoDaddy DNS ayarları:"
echo "   Type: A"
echo "   Name: @"
echo "   Value: $(curl -s ifconfig.me)"
echo "   TTL: 600"
echo ""
echo "2. SSL sertifikası için (isteğe bağlı):"
echo "   sudo apt install certbot python3-certbot-nginx -y"
echo "   sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN"
echo ""
echo "🎉 Site hazır: http://$DOMAIN"
