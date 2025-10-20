# Vercel + Railway Deployment Rehberi

## Hazırlık Tamamlandı! ✅

Projeniz Vercel (frontend) ve Railway (backend) için hazırlandı.

## 📋 Adım Adım Talimatlar:

### 1️⃣ GitHub'a Yükleyin (5 dakika)

1. GitHub'a gidin: https://github.com
2. Yeni repository oluşturun: "kaisglobal-website"
3. Bu komutu terminalden çalıştırın veya GitHub Desktop kullanın

### 2️⃣ Backend Deployment (Railway) - 10 dakika

1. **Railway'e gidin:** https://railway.app
2. **GitHub ile giriş yapın**
3. **"New Project"** tıklayın
4. **"Deploy from GitHub repo"** seçin
5. **kaisglobal-website** repo'sunu seçin
6. **Add MongoDB** servisini ekleyin
7. **Environment Variables** ekleyin:
   ```
   MONGO_URL=${{MongoDB.MONGO_URL}}
   DB_NAME=kaisglobal_db
   CORS_ORIGINS=*
   PORT=8001
   ```
8. **Deploy** tıklayın
9. **Backend URL'nizi kopyalayın** (örn: https://kaisglobal-backend.up.railway.app)

### 3️⃣ Frontend Deployment (Vercel) - 5 dakika

1. **Vercel'e gidin:** https://vercel.com
2. **GitHub ile giriş yapın**
3. **"New Project"** tıklayın
4. **kaisglobal-website** repo'sunu seçin
5. **Environment Variables** ekleyin:
   ```
   REACT_APP_BACKEND_URL=https://kaisglobal-backend.up.railway.app
   ```
6. **Deploy** tıklayın

### 4️⃣ Domain Bağlama (kaisglobal.com) - 5 dakika

1. **Vercel Dashboard'da:**
   - Projenize tıklayın
   - **Settings** → **Domains** gidin
   - **"Add"** tıklayın
   - **kaisglobal.com** yazın
   - Size DNS ayarlarını gösterecek

2. **GoDaddy'de DNS Ayarları:**
   - GoDaddy → **My Products** → **kaisglobal.com** → **DNS**
   - Aşağıdaki kayıtları ekleyin:
   
   ```
   Type: A
   Name: @
   Value: 76.76.21.21
   TTL: 600
   
   Type: CNAME
   Name: www
   Value: cname.vercel-dns.com
   TTL: 600
   ```

3. **Vercel'de Verify** tıklayın
4. 5-10 dakika bekleyin

## ✅ Tamamlandı!

kaisglobal.com artık sitenize yönlendirilecek!

## 🆘 Yardım Gerekirse:

- Railway Discord: https://discord.gg/railway
- Vercel Discord: https://discord.gg/vercel
- Bana tekrar yazın!
