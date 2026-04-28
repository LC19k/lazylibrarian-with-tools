# LazyLibrarian with Calibre + ffmpeg (Custom Image)

A custom Docker image for **LazyLibrarian** with **Calibre**, **ebook-convert**, **calibredb**, and **ffmpeg** baked directly into the image.

This image is designed for **fast, reproducible, Dockhand‑friendly deployments** with **zero runtime package installs**, **zero mod loader delays**, and **instant startup times**.

---

## 🚀 Why This Image Exists

The standard LinuxServer LazyLibrarian container installs Calibre and ffmpeg at runtime using the LSIO mod loader.  
This causes:

- 3–6 minute container startup times  
- dpkg corruption  
- unpredictable deploys  
- slow stack bring‑up  
- repeated downloads of 200+ MB of packages  

This custom image moves all of that work into the **Docker build stage**, so the container starts in **2–3 seconds**.

---

## 📦 Image Location (GHCR)

ghcr.io/lc19k/lazylibrarian-with-tools:latest

Code

### Versioned Tags

Every build publishes:
- `latest` — newest successful build  
- `YYYYMMDD` — daily snapshot  
- `sha-<commit>` — exact source revision  

Examples:

- ```ghcr.io/lc19k/lazylibrarian-with-tools:20260428```

- ```ghcr.io/lc19k/lazylibrarian-with-tools:sha-652b2d0d```

These tags make Dockhand deployments **deterministic** and **reproducible**.

---

## 🛠 Included Tools

This image includes:

- **Calibre** (calibredb, ebook-convert, ebook-meta)
- **ffmpeg** + ffprobe
- All required shared libraries:
  - Mesa
  - Vulkan
  - X11
  - ICU
  - XML
  - Sensors
  - GL drivers

Everything LazyLibrarian needs for ebook and audiobook processing is preinstalled.

---

## 🧱 Dockerfile

```dockerfile
FROM lscr.io/linuxserver/lazylibrarian:latest

RUN apt-get update && \
    apt-get install -y calibre ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```
This ensures Calibre + ffmpeg are installed once, at build time.

## 🔄 GitHub Actions Workflow
This repository includes a workflow that:
- Builds the image on every push to ```main```
- Publishes versioned tags (```latest```, ```YYYYMMDD```, ```sha-<commit>```)
- Rebuilds weekly to pick up upstream updates
  
Workflow file: ```.github/workflows/build.yml```

## 📘 Dockhand Deployment Example
```yaml
  lazylibrarian:
    image: ghcr.io/lc19k/lazylibrarian-with-tools:latest
    container_name: lazylibrarian
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - /opt/stacks/arr-books/config/lazylibrarian:/config
      - /mnt/user/data/media/libraries/calibre:/books
      - /mnt/user/data/media/downloads/books:/downloads
      - /mnt/user/data/media/libraries/audiobooks:/audiobooks
      - /mnt/user/data/media/libraries/ebooks:/ebooks
    restart: unless-stopped
```
This is fully compatible with Dockhand’s Git‑backed stack model.

## 🧪 Verification
After deployment:

```bash
docker exec -it lazylibrarian bash
which ffmpeg
which calibredb
ebook-convert --version
```
Expected output:
```Code
/usr/bin/ffmpeg
/usr/bin/calibredb
calibre 7.x.x or 8.x.x
```
## 📝 License
This project packages open-source components.
LazyLibrarian is licensed under the GPLv3.
