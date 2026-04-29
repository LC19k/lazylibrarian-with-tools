# 📚 Kobo Integration Overview  
This repository includes a fully automated, Kobo‑optimized ebook workflow built on:

- LazyLibrarian  
- Calibre (headless)  
- kepubify  
- Calibre‑Web  
- KoboTouchExtended  
- Optional: NickelDBus  
- Optional: KOReader  

This document provides a **high‑level overview** of all Kobo‑related features, how they fit together, and links to detailed guides for each component.

---

# 🚀 What This System Provides

## ✔ Automatic KEPUB Generation  
All EPUBs processed by LazyLibrarian are automatically converted to **KEPUB** using `kepubify`.  
KEPUBs provide:

- Real page numbers  
- Faster page turns  
- Better typography  
- Kobo‑native reading stats  
- Better series handling  
- Better cover handling  

This is enabled by default in the Dockerfile.

---

## ✔ Perfect Series Metadata  
Using Calibre + KoboTouchExtended, this system ensures:

- Series name  
- Series index  
- Correct sorting  
- Correct metadata blocks  
- Correct KEPUB metadata injection  

Kobo devices do **not** read standard EPUB series metadata.  
This system fixes that.

---

## ✔ High‑Quality Cover Thumbnails  
KoboTouchExtended generates `.kobo/images/*.jpg` thumbnails so your library view looks clean and consistent.

---

## ✔ Calibre‑Web Kobo Sync (Optional)  
Allows your Kobo device to sync books **over Wi‑Fi** directly from Calibre‑Web instead of Kobo’s cloud.

Supports:

- Book downloads  
- Metadata sync  
- Shelves/collections  
- Reading position sync (with NickelDBus)  

Does **not** support Kobo Store purchases.

---

## ✔ Kobo USB Auto‑Import (Optional)  
When you plug in a Kobo via USB:

- Reading positions import  
- Annotations import  
- Metadata updates  
- Cover updates  
- Series metadata updates  
- New books sent automatically  

This is the most complete sync method.

---

## ✔ NickelDBus Integration (Optional)  
NickelDBus exposes Kobo’s internal APIs over DBus, enabling:

- Reading stats sync  
- Annotation sync  
- Position sync  
- Shelf sync  
- Integration with Calibre‑Web  
- Integration with Calibre  

This keeps you inside Kobo’s **native** reading app (Nickel).

---

## ✔ KOReader Support (Optional)  
KOReader is a third‑party reading app offering:

- OPDS sync (Calibre‑Web, Komga, Kavita)  
- Cross‑device sync  
- Better PDF support  
- Better EPUB rendering  
- Custom CSS/themes  

Most power users run **both**:

- Nickel (with NickelDBus) for fiction  
- KOReader for technical books & OPDS sync  

---

# 🗂 Documentation Index

Each feature has its own dedicated guide.

## 🔧 Core Tools  
- **[kepubify.md](kepubify.md)**  
  How kepubify works, how LazyLibrarian uses it, and how to disable it if you’re not a Kobo user.

---

## 📡 Sync & Automation  
- **[kobo-sync-calibre-web.md](kobo-sync-calibre-web.md)**  
  Enable Calibre‑Web as a Wi‑Fi sync endpoint for Kobo devices.

- **[kobo-usb-import.md](kobo-usb-import.md)**  
  Configure Calibre to auto‑import reading positions, annotations, and metadata when a Kobo is connected via USB.

- **[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)**  
  Use Kobo Cloud for purchased books + Calibre‑Web for sideloaded books.

---

## 🖼 Metadata & Presentation  
- **[kobo-series-metadata.md](kobo-series-metadata.md)**  
  Fix series metadata so Kobo displays series name + index correctly.

- **[kobo-thumbnails.md](kobo-thumbnails.md)**  
  Enable high‑quality cover thumbnails on Kobo devices.

---

## 🧠 Advanced Integrations  
- **[kobo-nickeldbus.md](kobo-nickeldbus.md)**  
  Install and configure NickelDBus for reading stats sync, annotation sync, and deeper Kobo integration.

- **[kobo-koreader.md](kobo-koreader.md)**  
  Install KOReader, enable OPDS sync, and integrate with Calibre‑Web.

---

# 🧭 Recommended Setup for Most Kobo Households

If you want the **best possible Kobo experience**, enable:

### ✔ Automatic KEPUB generation  
### ✔ Series metadata fixes  
### ✔ Cover thumbnail generation  
### ✔ USB auto‑import  
### ✔ NickelDBus  
### ✔ (Optional) KOReader for technical books  

This gives you:

- Perfect metadata  
- Perfect covers  
- Kobo‑native reading stats  
- Fast Wi‑Fi sync  
- Full USB sync  
- Optional OPDS sync  
- Optional cross‑device sync  

---

# 📝 Notes for Non‑Kobo Users

If you do **not** use Kobo devices:

- Comment out the `kepubify` section in the Dockerfile  
- Ignore the Kobo‑specific docs  
- The image still works perfectly for:
  - EPUB  
  - MOBI  
  - PDF  
  - Audiobooks  
  - Standard Calibre workflows  

---

# 📬 Questions or Contributions

Pull requests and issues are welcome.  
This system is designed to be modular — enable only the features you need.

