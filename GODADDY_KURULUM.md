# 🚀 GoDaddy VPS'e Kaisglobal.com Kurulum Rehberi

## 📦 Hazırlık
✅ `kaisglobal-deploy.zip` dosyası hazırlandı

---

## 1️⃣ ZIP Dosyasını İndirin (Emergent'ten)

Bu zip dosyasını bilgisayarınıza indirin:
```
/app/kaisglobal-deploy.zip
```

---

## 2️⃣ GoDaddy VPS'e Bağlanın

### Yöntem A: SSH Terminal ile (Önerilen)
```bash
ssh root@VPS_IP_ADRESİNİZ
# Şifre: (GoDaddy'den aldığınız)
```

### Yöntem B: GoDaddy cPanel File Manager
1. GoDaddy → My Products → VPS
2. "Manage" → "File Manager"

---

## 3️⃣ Dosyaları Yükleyin

### SSH ile:
```bash
# Bilgisayarınızdan (yeni terminal):
scp kaisglobal-deploy.zip root@VPS_IP:/root/

# VPS'de:
cd /root
unzip kaisglobal-deploy.zip
```

### File Manager ile:
1. ZIP'i File Manager'dan Upload edin
2. Sağ tık → Extract

---

## 4️⃣ Kurulum Scriptlerini Çalıştırın

### Adım 1: Temel kurulum
```bash
chmod +x godaddy_install.sh
sudo ./godaddy_install.sh
```
⏳ 5-10 dakika sürer

### Adım 2: Dosyaları taşı
```bash
sudo cp -r backend frontend /var/www/kaisglobal/
sudo cp setup_app.sh /var/www/kaisglobal/
cd /var/www/kaisglobal
```

### Adım 3: App kurulumu
```bash
chmod +x setup_app.sh
sudo ./setup_app.sh
```
⏳ 5-10 dakika sürer

---

## 5️⃣ DNS Ayarları (GoDaddy)

1. **GoDaddy → My Products → kaisglobal.com → DNS**

2. **A kaydı ekleyin:**
```
Type: A
Name: @
Value: [VPS IP ADRESİNİZ]
TTL: 600
```

3. **CNAME kaydı ekleyin:**
```
Type: CNAME
Name: www
Value: kaisglobal.com
TTL: 600
```

---

## 6️⃣ SSL Sertifikası (İsteğe Bağlı - Önerilen)

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d kaisglobal.com -d www.kaisglobal.com
```

Email adresinizi girin ve kurulum tamamdır!

---

## ✅ Tamamlandı!

🌐 Siteniz hazır: **https://kaisglobal.com**

---

## 🔧 Sorun Giderme

### Site açılmıyor?
```bash
# Servisleri kontrol et
sudo systemctl status kaisglobal-backend
sudo systemctl status nginx
sudo systemctl status mongod

# Logları incele
sudo journalctl -u kaisglobal-backend -f
sudo tail -f /var/log/nginx/error.log
```

### Backend çalışmıyor?
```bash
cd /var/www/kaisglobal/backend
source venv/bin/activate
uvicorn server:app --host 0.0.0.0 --port 8001
```

### Frontend build hatası?
```bash
cd /var/www/kaisglobal/frontend
yarn install
REACT_APP_BACKEND_URL=https://kaisglobal.com yarn build
```

---

## 📞 Yardım

Sorun yaşarsanız:
1. Hata mesajını kopyalayın
2. Bana gönderin
3. Birlikte çözeriz!

---

## 💰 Maliyet

- GoDaddy VPS: ~$20-30/ay
- Domain: Zaten aldınız ✅
- Her şey dahil, başka ücret yok
