# n8n Hosting Şablonları (Render İçin Optimize Edildi)

Bu depo, n8n'i farklı platformlarda barındırmak için gerekli yapılandırma dosyalarını içerir. **Render.com** üzerinde yaşanan kurulum hataları giderilmiştir.

## Render Kurulum Rehberi (Hızlı Çözüm)

Render üzerinde aldığınız "bash syntax error" veya "npm fund" hataları, Render'ın projeyi yanlışlıkla bir Node.js projesi olarak algılamasından kaynaklanmaktadır. Bunu düzeltmek için şu adımları izleyin:

### Seçenek 1: Blueprint Kullanımı (En Kolay Yol)
1. Render panelinde **"New +"** butonuna basın ve **"Blueprint"** seçeneğini seçin.
2. Bu GitHub deposunu bağlayın.
3. Render, projedeki `render.yaml` dosyasını okuyacak ve Veritabanı, Disk ve n8n servisini otomatik olarak (Docker kullanarak) kuracaktır.

### Seçenek 2: Manuel Kurulum (Mevcut Servisi Düzeltme)
Eğer mevcut bir Web Servisini düzenliyorsanız:
1. **Environment:** Mutlaka `Docker` olarak seçin.
2. **Build Command:** Bu alanı **tamamen boşaltın**. (Hata almanıza sebep olan şey buradaki yanlış komuttur).
3. **Start Command:** Bu alanı **tamamen boşaltın**.
4. **Environment Variables:** `render.yaml` içindeki gerekli değişkenleri (N8N_HOST, vb.) eklediğinizden emin olunuz.

## Diğer Dağıtım Seçenekleri

### 1. Docker Compose
- `docker-compose/withPostgres`: PostgreSQL ile standart kurulum.
- `docker-compose/withPostgresAndWorker`: Yüksek performanslı kurulum.
- `docker-compose/subfolderWithSSL`: Alt klasörde (örn: `site.com/n8n`) çalıştırma.

### 2. Kubernetes
`kubernetes/` klasörü altındaki manifest dosyalarını kullanabilirsiniz.

## Güvenlik Notu
Kurulumdan sonra varsayılan şifreleri ve `N8N_ENCRYPTION_KEY` değişkenini değiştirmeyi unutmayın. GitHub yedekleme özelliği (`backup.sh`), güvenlik nedeniyle kimlik bilgilerini (**credentials**) varsayılan olarak yedeklemez.
