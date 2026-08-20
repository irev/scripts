# Gitea Local (Hyper-V Lab)

Setup minimal untuk menjalankan Gitea di Ubuntu Server pada VM Hyper-V.

## Prasyarat

- Ubuntu Server 24.04 LTS
- Docker Engine aktif
- Docker Compose v2
- Port `3000` untuk Web UI
- Port `2222` untuk Git SSH

Cek:

```bash
docker version
docker compose version
```

## Install

```bash
sudo mkdir -p /opt/gitea
cd /opt/gitea

sudo curl -L \
  https://raw.githubusercontent.com/irev/scripts/refs/heads/main/compose.yaml \
  -o compose.yaml

sudo docker compose pull
sudo docker compose up -d
sudo docker compose ps
```

## Akses

Cari IP VM:

```bash
ip addr
```

Buka dari host Windows:

```text
http://<IP-VM>:3000
```

Untuk setup awal lab pilih `SQLite3`.

Konfigurasi server yang relevan:

```text
SSH Server Port : 2222
Gitea Base URL  : http://<IP-VM>:3000/
```

## Operasional

Status:

```bash
cd /opt/gitea
docker compose ps
```

Log:

```bash
docker logs --tail 100 gitea
```

Restart:

```bash
docker compose restart
```

Update image Gitea:

```bash
cd /opt/gitea
docker compose pull
docker compose up -d
```

Stop:

```bash
docker compose down
```

Data Gitea disimpan persisten di:

```text
/opt/gitea/data
```

## Catatan lab

- IP DHCP boleh dipakai untuk pengujian awal, tetapi gunakan static IP atau DHCP reservation sebelum dipakai sebagai server tetap.
- Jangan hapus `/opt/gitea/data` ketika melakukan update container.
- Hyper-V checkpoint bukan pengganti backup data Gitea.
- PostgreSQL, HTTPS/reverse proxy, dan runner CI sebaiknya ditambahkan setelah fungsi Git/PR dasar sudah tervalidasi.
