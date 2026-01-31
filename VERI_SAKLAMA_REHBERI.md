# n8n Veri Saklama ve Yedekleme Rehberi

n8n üzerinde yaptığınız çalışmaların (iş akışları, bağlantılar, ayarlar) kaybolmaması için sistem iki katmanlı koruma kullanır:

## 1. Kalıcı Veritabanı ve Disk (Render Üzerinde)
Yaptığınız her şey anlık olarak Render üzerindeki **PostgreSQL Veritabanı** ve **Persistent Disk** (Kalıcı Disk) üzerine kaydedilir.
- **İş Akışları ve Geçmiş:** PostgreSQL veritabanında saklanır. `render.yaml` dosyasında bu otomatik olarak tanımlanmıştır.
- **Dosyalar ve Ayarlar:** `/home/node/.n8n` klasörüne bağlı olan 10GB'lık diskte saklanır. Servis yeniden başlasa bile bu veriler silinmez.

## 2. GitHub Üzerine Otomatik Yedekleme (Ekstra Güvenlik)
Bu projede kurulu olan `backup.sh` betiği, her 5 dakikada bir iş akışlarınızı otomatik olarak GitHub deponuza yedekler. Bunun çalışması için Render panelinde şu ortam değişkenlerini (Environment Variables) tanımlamanız gerekir:

- `GITHUB_REPO_URL`: Yedeklerin yükleneceği GitHub depo linki (örn: `https://github.com/kullanici/n8n-yedek`).
- `GITHUB_TOKEN`: GitHub Personal Access Token (Yazma yetkisi olan bir token).
- `GITHUB_EMAIL`: GitHub e-posta adresiniz.

---

### Verilerin Silinmemesi İçin Dikkat Edilmesi Gerekenler:
1. **Blueprint Kullanın:** Kurulumu `render.yaml` (Blueprint) üzerinden yaptıysanız, Render sizin için otomatik olarak disk ve veritabanı oluşturmuştur. Bu durumda verileriniz güvendedir.
2. **Manuel Kurulum Yaptıysanız:** Eğer Blueprint kullanmadıysanız, Render panelinden manuel olarak bir **"Disk"** eklemeli ve `Mount Path` kısmına `/home/node/.n8n` yazmalısınız. Ayrıca bir **"PostgreSQL"** veritabanı oluşturup bağlantı bilgilerini eklemelisiniz.

**Özetle:** Şu anki mevcut yapılandırma (Blueprint/render.yaml), verilerinizi kaydetmek üzere tasarlanmıştır. Tek yapmanız gereken kurulumu bu dosyalarla (ve tercihen Blueprint ile) tamamlamaktır.
