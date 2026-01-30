# 1. Aşama: Gerekli dosyaları hazırlayan geçici bir imaj
FROM alpine:latest AS builder
RUN apk add --no-cache git openssh-client

# 2. Aşama: Ana n8n imajı
FROM n8nio/n8n:latest

USER root

# Builder aşamasından git ve ssh dosyalarını kopyalıyoruz
COPY --from=builder /usr/bin/git /usr/bin/git
COPY --from=builder /usr/lib /usr/lib
COPY --from=builder /lib /lib
COPY --from=builder /etc/ssh /etc/ssh
COPY --from=builder /usr/bin/ssh* /usr/bin/

# n8n'in kendi kullanıcısına geri dönüyoruz
USER node
