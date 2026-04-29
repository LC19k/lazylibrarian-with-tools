# 📘 kepubify Integration  
This document explains how **kepubify** is integrated into the custom LazyLibrarian image, how it enables automatic KEPUB generation for Kobo devices, and how to disable it if you are not using Kobo hardware.

---

# 🔍 What Is kepubify?

[kepubify](https://github.com/pgaskin/kepubify) is a fast, reliable EPUB → KEPUB converter designed specifically for **Kobo e‑readers**.

KEPUB files provide:

- Real page numbers  
- Faster page turns  
- Kobo-native reading stats  
- Better typography  
- Better series metadata  
- Better cover handling  

Kobo devices *can* read EPUBs, but KEPUBs offer a significantly better experience.

---

# ⚙️ How kepubify Works in This Image
The Dockerfile installs kepubify here: ```/usr/local/bin/kepubify```

And then creates a symlink: ```/usr/bin/kepubify```

LazyLibrarian checks for the presence of: ```/usr/bin/kepubify```

If it exists, LazyLibrarian automatically:

1. Detects kepubify  
2. Converts EPUB → KEPUB during post‑processing  
3. Places the resulting `.kepub.epub` file into the Calibre library  
4. Updates metadata accordingly  
5. Makes the KEPUB available to Calibre‑Web and Kobo devices  

There is **no UI toggle** in LazyLibrarian — detection is automatic.

---

# 🚀 Automatic KEPUB Generation

Once kepubify is installed and symlinked, LazyLibrarian will:

- Convert every EPUB it processes  
- Generate a matching KEPUB  
- Import the KEPUB into Calibre  
- Preserve the original EPUB (unless configured otherwise)  
- Make the KEPUB available for Kobo sync workflows  

This happens with **zero configuration**.

---

# 🧪 How to Verify kepubify Is Working

Inside the container:

```bash
docker exec -it lazylibrarian bash
which kepubify
```
Expected: ```/usr/bin/kepubify```
Then check LazyLibrarian’s post‑processing logs:

You should see entries like:
```
Converting EPUB to KEPUB using kepubify
Generated file: <book>.kepub.epub
Importing KEPUB into Calibre
```
And in your Calibre library:
```
<book>.epub
<book>.kepub.epub
```
## 🛑 Disabling kepubify (Non‑Kobo Users)
If you do not use Kobo devices, you can disable kepubify by commenting out these lines in the Dockerfile:
```
# Install kepubify (always enabled for Kobo households)
RUN wget -O /usr/local/bin/kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /usr/local/bin/kepubify && \
    ln -s /usr/local/bin/kepubify /usr/bin/kepubify
```
LazyLibrarian will then:
- Skip KEPUB generation
- Process EPUBs normally
- Behave like a standard Calibre + LazyLibrarian setup

## 🧠 Why This Matters for Kobo Users
|Kobo’s firmware treats KEPUBs as first‑class citizens:
|Feature	|EPUB	|KEPUB
|----------|:-----:|:--------:|
|Real page numbers	|❌	|✔
|Reading stats	|❌	|✔
|Faster page turns	|❌	|✔
|Better typography	|❌	|✔
|Better series metadata	|❌	|✔
|Better cover handling	|❌	|✔
If you own a Kobo, KEPUBs are the correct format.
---
# 📦 Related Documentation

- **[overview.md](overview.md)** — High‑level summary of all Kobo features  
- **[kobo-series-metadata.md](kobo-series-metadata.md)** — Ensuring series metadata works correctly  
- **[kobo-thumbnails.md](kobo-thumbnails.md)** — High‑quality cover thumbnails  
- **[kobo-sync-calibre-web.md](kobo-sync-calibre-web.md)** — Wi‑Fi sync via Calibre‑Web  
- **[kobo-usb-import.md](kobo-usb-import.md)** — USB sync for reading stats + annotations  
- **[kobo-nickeldbus.md](kobo-nickeldbus.md)** — Native Kobo reading stats sync  
- **[kobo-koreader.md](kobo-koreader.md)** — Optional advanced reader  
- **[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)** — Kobo Store + Calibre‑Web hybrid sync  

---
# ✔ Summary
- kepubify is installed and enabled by default
- LazyLibrarian auto‑detects it
- KEPUB generation requires no configuration
- Kobo users get a dramatically better reading experience
- Non‑Kobo users can disable it easily

This is the foundation of the Kobo‑optimized workflow in this repository.
