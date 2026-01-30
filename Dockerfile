FROM n8nio/n8n:latest

USER root

# Alpine Linux için doğru komut (apk) budur, 
# ancak mutlaka USER root altında çalışmalıdır.
RUN apk add --no-cache git openssh-client

USER node
