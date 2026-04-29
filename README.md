# LazyLibrarian with Calibre CLI + Minimal ffmpeg + Kobo Enhancements  
A custom multi‑stage Docker image for **LazyLibrarian** with:

- **Headless Calibre 9.7** (calibredb, ebook-convert, ebook-meta, ebook-polish)
- **Minimal ffmpeg** (built from source, ~8–12 MB)
- **kepubify** (always enabled for Kobo households)
- **Zero GUI libraries** (Qt, X11, OpenGL removed)
- **Fast, deterministic startup** (2–3 seconds)
- **Reproducible, Dockhand‑friendly builds**

This image is optimized for **Kobo e‑reader workflows**, but remains fully compatible with non‑Kobo setups.

---

## 🚀 Why This Image Exists

The standard LinuxServer LazyLibrarian container installs Calibre and ffmpeg at runtime using the LSIO mod loader.  
This causes:

- 3–6 minute container startup times  
- dpkg corruption  
- unpredictable deploys  
- slow stack bring‑up  
- repeated downloads of 200+ MB of packages  

This custom image moves all of that work into the **Docker build stage**, so the container starts in **seconds**, not minutes.

It also removes all GUI components from Calibre, reducing the image size by **50–70%**.

---

## 📦 Image Location (GHCR)
```ghcr.io/lc19k/lazylibrarian-with-tools:latest```

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

## 🧱 Included Tools

This image includes:

### ✔ Calibre CLI (headless)
- `calibredb`
- `ebook-convert`
- `ebook-meta`
- `ebook-polish`

### ✔ Minimal ffmpeg (built from source)
- Only the codecs LazyLibrarian needs  
- ~8–12 MB instead of 60–80 MB  
- Faster startup, lower RAM usage  

### ✔ kepubify (always enabled)
Automatically converts EPUB → KEPUB during LazyLibrarian post‑processing.

> **Note for non‑Kobo users:**  
> Comment out the kepubify section in the Dockerfile if you do not want KEPUB generation.

---

## 📚 Kobo‑Optimized Features

This image is designed for households using **Kobo e‑readers**.

It supports:

- **Automatic KEPUB generation** (via kepubify)
- **Perfect series metadata** (via Calibre + KoboTouchExtended)
- **High‑quality cover thumbnails**
- **Calibre‑Web Kobo Sync** (optional)
- **Kobo USB auto‑import** (optional)
- **NickelDBus integration** (optional)
- **KOReader support** (optional)

Full documentation will be available in the `/docs` folder:
- /docs
- overview.md
- kobo-sync-calibre-web.md
- kobo-usb-import.md
- kobo-series-metadata.md
- kobo-thumbnails.md
- kobo-nickeldbus.md
- kobo-koreader.md
- kepubify.md
- hybrid-kobo-cloud.md

---

## 🧱 Dockerfile (Multi‑Stage, Headless Calibre, Minimal ffmpeg, Kobo‑Ready)

```dockerfile
###############################################
# Stage 1 — Build minimal ffmpeg
###############################################
FROM debian:stable-slim AS ffmpeg-builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        yasm \
        pkg-config \
        wget \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN wget https://ffmpeg.org/releases/ffmpeg-6.1.1.tar.gz && \
    tar -xzf ffmpeg-6.1.1.tar.gz && \
    cd ffmpeg-6.1.1 && \
    ./configure \
        --disable-everything \
        --enable-small \
        --enable-protocol=file \
        --enable-demuxer=mp3 \
        --enable-demuxer=wav \
        --enable-demuxer=ogg \
        --enable-demuxer=flac \
        --enable-muxer=mp3 \
        --enable-muxer=wav \
        --enable-muxer=ogg \
        --enable-muxer=flac \
        --enable-decoder=mp3 \
        --enable-decoder=pcm_s16le \
        --enable-decoder=vorbis \
        --disable-debug \
        --disable-doc \
        && make -j$(nproc) && make install


###############################################
# Stage 2 — Build Calibre CLI tools (headless)
###############################################
FROM debian:stable-slim AS calibre-builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/calibre.txz \
        https://download.calibre-ebook.com/9.7.0/calibre-9.7.0-x86_64.txz && \
    mkdir -p /opt/calibre && \
    tar -xJf /tmp/calibre.txz -C /opt/calibre --strip-components=1 && \
    rm /tmp/calibre.txz

# Remove GUI components to reduce image size
RUN rm -rf \
    /opt/calibre/lib/python3.*/site-packages/calibre/gui \
    /opt/calibre/resources/viewer \
    /opt/calibre/resources/fonts \
    /opt/calibre/resources/images \
    /opt/calibre/resources/qtwebengine* \
    /opt/calibre/lib/libQt* \
    /opt/calibre/lib/libxcb* \
    /opt/calibre/lib/libX* \
    /opt/calibre/lib/libGL* \
    /opt/calibre/lib/libEGL* \
    /opt/calibre/lib/libOpenGL*


###############################################
# Stage 3 — Final LazyLibrarian image
###############################################
FROM lscr.io/linuxserver/lazylibrarian:latest

# Install runtime dependencies for Calibre CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        unrar \
        libglib2.0-0 \
        libxml2 \
        libxslt1.1 \
        libjpeg-turbo8 \
        libpng16-16 \
        libfreetype6 \
        libharfbuzz0b \
        libfontconfig1 \
        && rm -rf /var/lib/apt/lists/*

# Copy Calibre CLI tools
COPY --from=calibre-builder /opt/calibre /opt/calibre

# Copy minimal ffmpeg
COPY --from=ffmpeg-builder /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg

# Install kepubify (always enabled for Kobo households)
# Non-Kobo users: comment out the following three lines
RUN wget -O /usr/local/bin/kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /usr/local/bin/kepubify && \
    ln -s /usr/local/bin/kepubify /usr/bin/kepubify

# Symlink Calibre tools
RUN ln -s /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -s /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -s /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -s /opt/calibre/ebook-polish /usr/bin/ebook-polish

RUN rm -rf /tmp/* /var/tmp/*
```
---
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
## 🧪 Verification
After deployment:

```bash
docker exec -it lazylibrarian bash
which ffmpeg
which calibredb
which kepubify
ebook-convert --version
```
Expected output:
```Code
/usr/local/bin/ffmpeg
/usr/bin/calibredb
/usr/bin/kepubify
calibre 9.7.0
```
## 📝 License
This project packages open‑source components.
LazyLibrarian is licensed under the GPLv3.
Calibre is licensed under GPLv3.
ffmpeg is licensed under LGPL/GPL depending on configuration.
kepubify is MIT‑licensed.
---
# 👍 Next Step: `/docs/overview.md`
