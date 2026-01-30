# n8n Hosting Şablonları (Render.com İçin Özel)

Bu depo, n8n'i **Render.com** üzerinde en sağlıklı şekilde çalıştırmak için optimize edilmiştir. Mevcut projenizdeki "siyah ekran" veya "derleme hatası" (npm build error) sorunlarını çözmek için aşağıdaki adımları izleyin.

## 🚀 Render.com Kurulum Adımları (Kesin Çözüm)

Render üzerindeki hataları gidermek ve n8n'i ayağa kaldırmak için şu adımları takip edin:

### 1. Dosyaları Hazırlayın
Eğer kendi deponuzda (örn: `yapay-zekal-denemesi-n8n-tarz-`) eski Vite/React dosyaları varsa, n8n'in çalışması için o dosyaları silip yerine bu depodaki şu dosyaları koymalısınız:
- `Dockerfile` (Ana dizinde olmalı)
- `render.yaml` (Ana dizinde olmalı)
- `backup.sh` ve `entrypoint.sh`
- `initial-workflows/` (Örnek iş akışları klasörü)

### 2. Render Blueprint Kullanımı
Hatalı manuel ayarlar yerine Render'ın **Blueprint** özelliğini kullanmanızı şiddetle öneririm:
1. Render dashboard'da **"New +"** butonuna tıklayın ve **"Blueprint"** seçeneğini seçin.
2. Bu depoyu (veya dosyaları kopyaladığınız kendi deponuzu) bağlayın.
3. Render, `render.yaml` dosyasını otomatik olarak okuyacak; sizin yerinize bir Veritabanı (Postgres), bir Disk ve n8n servisini doğru ayarlarla kuracaktır.

### 3. Manuel Düzenleme (Blueprint Kullanmak İstemezseniz)
Mevcut Web Servisinizi düzeltmek istiyorsanız:
- **Environment:** `Docker` olarak değiştirin.
- **Build Command:** Bu alanı **tamamen boş** bırakın.
- **Start Command:** Bu alanı **tamamen boş** bırakın.
- **Database:** Render üzerinden bir PostgreSQL veritabanı oluşturun ve n8n'in ortam değişkenlerine (Host, User, Password) bağlayın.

## 🛠️ Özellikler
- **Otomatik Yedekleme:** `backup.sh` sayesinde iş akışlarınız belirlediğiniz bir GitHub reposuna otomatik olarak yedeklenir.
- **Hazır İş Akışları:** `initial-workflows/` içindeki AI destekli örnekleri n8n kurulur kurulmaz kullanmaya başlayabilirsiniz.
- **Veritabanı Desteği:** SQLite yerine daha performanslı olan PostgreSQL kullanacak şekilde ayarlanmıştır.

---
**Not:** Kurulum bittikten sonra n8n arayüzüne ilk girişte kullanıcı hesabınızı oluşturmayı unutmayın. `N8N_ENCRYPTION_KEY` değişkeni Render tarafından sizin için otomatik üretilecektir.
