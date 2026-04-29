# 📖 KOReader (Optional Advanced Reader for Kobo)  
KOReader is an alternative reading application for Kobo devices. It is **not** a replacement for Nickel (Kobo’s built‑in reader), but rather a powerful companion app for users who want advanced features.

This document explains:

- What KOReader is  
- What it does better than Nickel  
- What it does worse  
- Whether your household actually needs it  
- How to install it  
- How to integrate it with Calibre‑Web (OPDS)  
- How to run KOReader alongside NickelDBus  

---

# 🚀 What Is KOReader?

KOReader is an open‑source reading application that runs on:

- Kobo  
- Kindle  
- Android  
- Linux  

It is designed for **power users**, especially those who read:

- PDFs  
- Technical books  
- Large EPUBs  
- Books with complex formatting  

KOReader is launched from NickelMenu and runs *alongside* the native Kobo software.

---

# ⭐ What KOReader Does Better Than Nickel

KOReader excels in areas where Kobo’s built‑in reader struggles.

## ✔ Superior PDF Support  
KOReader offers:

- Reflow  
- Margin cropping  
- Column detection  
- Zoom presets  
- Faster rendering  
- Better font scaling  

For technical books, KOReader is dramatically better.

## ✔ OPDS Support (Calibre‑Web, Komga, Kavita)  
KOReader can connect directly to:

- Calibre‑Web  
- Komga  
- Kavita  
- Any OPDS server  

This allows:

- Browsing your library  
- Downloading books  
- Syncing reading positions (KOReader‑to‑KOReader)  

## ✔ Cross‑Device Sync  
KOReader supports:

- Dropbox sync  
- WebDAV sync  
- Nextcloud sync  
- KOReader Sync Server  

This allows reading progress to sync across:

- Kobo  
- Android  
- Kindle  
- Linux  

## ✔ Customization  
KOReader offers:

- Custom CSS  
- Custom fonts  
- Themes  
- Advanced layout controls  
- Scripting  
- Plugins  

## ✔ Faster Rendering for Large EPUBs  
KOReader handles:

- Large EPUBs  
- Heavy images  
- Complex layouts  

Better than Nickel.

---

# ⚠️ What KOReader Does Worse Than Nickel

KOReader is powerful, but it is **not** a full replacement for Nickel.

## ❌ No Kobo Store Integration  
KOReader cannot:

- Download Kobo Store purchases  
- Sync Kobo Plus  
- Sync Kobo Store annotations  

## ❌ No Kobo Native Reading Stats  
KOReader has its own stats, but they do **not** integrate with:

- Kobo’s home screen  
- Kobo’s reading stats  
- Kobo’s achievements  

## ❌ No Kobo Home Screen Integration  
Books opened in KOReader do **not** appear in:

- “Recent”  
- “Currently Reading”  
- Kobo’s built‑in UI  

## ❌ No NickelDBus Integration  
KOReader does not use Nickel’s internal APIs.

## ❌ Not Ideal for Fiction  
For standard fiction reading, Nickel is:

- Simpler  
- Faster  
- More integrated  
- More polished  

---

# 🧠 Should Your Household Use KOReader?

Given your setup:

- LazyLibrarian  
- Calibre  
- Calibre‑Web  
- kepubify  
- NickelDBus  
- Multiple Kobo devices  

### ✔ KOReader is optional  
### ✔ KOReader is *not* required  
### ✔ KOReader is useful only for specific cases  

### KOReader **is worth it** if you read:

- PDFs  
- Technical books  
- Textbooks  
- Programming books  
- Scientific papers  
- Manga (sometimes)  
- Books with complex formatting  

### KOReader **is not needed** if you read:

- Fiction  
- Standard EPUBs  
- KEPUBs  
- Audiobooks (not supported)  

### For your family  
KOReader is a **nice‑to‑have**, not a must‑have.

Nickel + NickelDBus + kepubify already gives you:

- Perfect KEPUBs  
- Perfect metadata  
- Perfect covers  
- Wi‑Fi sync  
- USB sync  
- Reading stats  
- Shelves  
- Annotations  

KOReader adds value only for technical reading.

---

# 🛠 How to Install KOReader

### 1. Install NickelMenu  
Follow the official instructions:

https://github.com/pgaskin/NickelMenu

### 2. Download KOReader  
Get the latest Kobo build:

https://github.com/koreader/koreader/releases

Download:
```koreader-kobo-arm.tar.gz```

### 3. Extract to Kobo  
Unzip and copy the `koreader/` folder to:
```/mnt/onboard/.adds/```

### 4. Add NickelMenu entry  
Edit:
```.kobo/NickelMenu/config```

Add:
```menu_item :main :KOReader :cmd_spawn :quiet :/mnt/onboard/.adds/koreader/koreader.sh```

### 5. Reboot  
KOReader will now appear in NickelMenu.

---

# 🔗 Integrating KOReader with Calibre‑Web (OPDS)

KOReader supports OPDS catalogs.

### 1. In KOReader  
Go to:
```File Manager → OPDS Catalogs → Add Catalog```

### 2. Enter your Calibre‑Web OPDS URL  
Example:
```https://your-domain.com/opds```

### 3. Enter your Calibre‑Web credentials  
Use a normal Calibre‑Web user (not the Kobo Sync user).

### 4. Browse and download books  
KOReader will:

- Download EPUBs  
- Track reading progress  
- Sync progress across devices (if enabled)  

---

# 🔄 Running KOReader Alongside NickelDBus

KOReader and NickelDBus do **not** conflict.

### NickelDBus enhances Nickel  
### KOReader is a separate app  

You can:

- Read fiction in Nickel (with stats + sync)  
- Read technical books in KOReader  
- Switch between them via NickelMenu  

This is the setup most power users use.

---

# 🧪 Verifying KOReader Works

On your Kobo:

1. Tap the **NickelMenu** icon  
2. Tap **KOReader**  
3. KOReader should launch  
4. Open a book  
5. Test OPDS sync (optional)  
6. Test Dropbox/WebDAV sync (optional)  

---

# 📦 Related Documentation

- **[overview.md](overview.md)** — High‑level summary of all Kobo features  
- **[kepubify.md](kepubify.md)** — Automatic KEPUB generation  
- **[kobo-sync-calibre-web.md](kobo-sync-calibre-web.md)** — Wi‑Fi sync via Calibre‑Web  
- **[kobo-usb-import.md](kobo-usb-import.md)** — USB sync for reading stats + annotations  
- **[kobo-series-metadata.md](kobo-series-metadata.md)** — Ensuring series metadata works correctly  
- **[kobo-thumbnails.md](kobo-thumbnails.md)** — High‑quality cover thumbnails  
- **[kobo-nickeldbus.md](kobo-nickeldbus.md)** — Native Kobo reading stats sync  
- **[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)** — Kobo Store + Calibre‑Web hybrid sync
