# n8n Hosting Templates

This repository contains various deployment configurations for self-hosting [n8n](https://n8n.io/).

## Deployment Options

### 1. Docker Compose
- **With Postgres**: Standard setup with a PostgreSQL database.
- **With Postgres & Worker**: Scalable setup for high-concurrency environments.
- **Subfolder with SSL**: Configuration for running n8n on a subfolder (e.g., `example.com/n8n`) using Traefik.

### 2. Docker with Caddy
A simple setup using Caddy as a reverse proxy for automatic SSL.

### 3. Kubernetes
Kubernetes manifests for deploying n8n and PostgreSQL in a cluster.

### 4. Render
Configuration for deploying on [Render](https://render.com/), including an automated GitHub backup script.

## Setup Instructions

1. Choose your preferred deployment method.
2. Navigate to the corresponding directory.
3. Update the `.env` files with your own credentials and domain names.
4. Follow the instructions in the directory's `README.md`.

## Security Note
Always change the default passwords and secret keys before deploying to production.
