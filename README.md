# n8n Hosting Şablonları (Render.com İçin Özel)

Bu depo, n8n'i **Render.com** üzerinde en sağlıklı şekilde çalıştırmak için optimize edilmiştir.

## 🚀 Render.com Kurulum Adımları

Render üzerinde n8n'i ayağa kaldırmak için şu adımları takip edin:

### 1. Blueprint Kullanımı (Tavsiye Edilen)
1. Render dashboard'da **"New +"** butonuna tıklayın ve **"Blueprint"** seçeneğini seçin.
2. Bu depoyu bağlayın.
3. Render, `render.yaml` dosyasını otomatik olarak okuyacak; sizin yerinize Veritabanı (Postgres), Disk ve n8n servisini kuracaktır.

---

## 💾 Veri Saklama ve GitHub Yedekleme

n8n üzerinde yaptığınız çalışmaların kaybolmaması için iki yöntem bir arada sunulmuştur:

### 1. Kalıcı Disk (Render Disk)
`render.yaml` içinde tanımlanan **10GB'lık kalıcı disk**, n8n ayarlarınızın ve yerel verilerinizin servis kapansa bile silinmesini engeller.

### 2. GitHub Otomatik Yedekleme (5 Dakikada Bir)
Sistem, her 5 dakikada bir tüm iş akışlarınızı otomatik olarak belirlediğiniz bir GitHub deposuna yedekler. Bunu aktif etmek için Render panelindeki **Environment Variables** (Ortam Değişkenleri) kısmına şunları ekleyin:

- `GITHUB_REPO_URL`: Yedeklerin yükleneceği GitHub depo linki (örn: `https://github.com/kullanici/n8n-backup.git`).
- `GITHUB_TOKEN`: GitHub Personal Access Token (Yazma yetkisi olan 'Classic' veya 'Fine-grained' token).
- `GITHUB_EMAIL`: GitHub hesabınıza bağlı e-posta adresiniz.

**Önemli:** Yedekleme deposunu önceden GitHub üzerinde oluşturmuş olmanız gerekmektedir.

## 🛠️ Özellikler
- **Alpine Linux:** Daha hızlı ve hafif Docker imajı.
- **Otomatik İzin Düzenleme:** Disk izinleri her açılışta kontrol edilir.
- **Hazır İş Akışları:** AI destekli örnek iş akışları ilk kurulumda otomatik olarak n8n içine aktarılır.

---
**Güvenlik:** GitHub yedeklemesi, güvenlik nedeniyle şifreleri ve kimlik bilgilerini (credentials) yedeklemez; sadece iş akışı şemalarını yedekler.
