# 🔌 Kobo USB Auto‑Import  
This document explains how **Kobo USB auto‑import** works, how to enable it in Calibre, and why it remains essential even if you use Calibre‑Web Wi‑Fi sync.

USB auto‑import is the most complete and reliable way to sync:

- Reading positions  
- Annotations  
- Highlights  
- Bookmarks  
- Shelves  
- Metadata  
- Covers  

Wi‑Fi sync is convenient, but USB sync is **more complete**.

---

# 🚀 What USB Auto‑Import Does

When you plug a Kobo device into your computer, Calibre automatically:

### ✔ Reads the device database  
Located at:
```.kobo/KoboReader.sqlite```

This contains:

- Reading positions  
- Bookmarks  
- Highlights  
- Annotations  
- Shelves  
- Book lists  

### ✔ Imports reading progress into Calibre  
Calibre updates its internal metadata with:

- Last read position  
- Percent read  
- Time read  
- Date last opened  

### ✔ Imports annotations (highlights + notes)  
These are stored in Calibre’s annotations database.

### ✔ Updates metadata on the device  
Calibre writes:

- Series name  
- Series index  
- Corrected metadata  
- Updated covers  
- Updated thumbnails  

### ✔ Sends new books  
Any new books in your Calibre library are automatically sent to the device.

### ✔ Removes deleted books  
If a book was removed from Calibre, it can be removed from the device.

---

# 🧠 Why USB Sync Is Still Essential (Even With Wi‑Fi Sync)

Calibre‑Web Wi‑Fi sync is great for:

- Downloading books  
- Updating metadata  
- Updating shelves  

But it **cannot** sync:

- Reading positions  
- Highlights  
- Notes  
- Annotations  
- Bookmarks  
- Time read  
- Page counts  
- Kobo’s internal reading stats  

These are stored **only** in the device’s SQLite database and require USB access.

### ✔ USB sync = full fidelity  
### ✔ Wi‑Fi sync = convenience  

Most Kobo power users use **both**.

---

# 🛠 How to Enable USB Auto‑Import in Calibre

### 1. Open Calibre  
Go to:
```Preferences → Import/Export → Sending books to devices```

### 2. Enable automatic device detection  
Ensure:

[✔] Detect devices automatically

### 3. Enable automatic metadata management  
Under:

```Preferences → Metadata Management```

Set:

```Automatic management```

### 4. Enable KoboTouchExtended driver  
Go to:

```Preferences → Plugins → Device Interface → KoboTouchExtended```

Click:

```Customize plugin```

Enable:

[✔] Upload covers
[✔] Set series information
[✔] Set series index
[✔] Generate thumbnails
[✔] Use KEPUB format

### 5. Restart Calibre  
This ensures the driver loads correctly.

---

# 🔄 How USB Sync Interacts With Calibre‑Web Sync

| Feature | Wi‑Fi Sync | USB Sync |
|--------|------------|----------|
| Download books | ✔ | ✔ |
| Update metadata | ✔ | ✔ |
| Update covers | ✔ | ✔ |
| Update shelves | ✔ | ✔ |
| Reading positions | ❌ | ✔ |
| Highlights | ❌ | ✔ |
| Notes | ❌ | ✔ |
| Annotations | ❌ | ✔ |
| Time read | ❌ | ✔ |
| Page counts | ❌ | ✔ |
| Kobo stats | ❌ | ✔ |

### Summary  
- Wi‑Fi sync is **fast and convenient**  
- USB sync is **complete and authoritative**  

Your household should use **both**.

---

# 🧪 Verifying USB Auto‑Import Works

After plugging in your Kobo:

1. Calibre should show a new device icon  
2. A popup may appear:  
```Reading information from device…```
3. Books should appear under the “Device” tab  
4. Reading progress should update in Calibre  
5. Annotations should appear in:  
```View → Annotations Browser```

---

# 🧭 Recommended Settings for Your Household

Given your setup:

- LazyLibrarian  
- Calibre  
- Calibre‑Web  
- kepubify  
- Multiple Kobo devices  

You should enable:

### ✔ Automatic KEPUB generation  
### ✔ Calibre‑Web Wi‑Fi sync  
### ✔ USB auto‑import  
### ✔ Series metadata fixes  
### ✔ Cover thumbnail generation  
### ✔ NickelDBus (optional but recommended)  

This gives you:

- Perfect metadata  
- Perfect covers  
- Fast Wi‑Fi sync  
- Full USB sync  
- Kobo‑native reading stats  
- Annotation sync  
- Shelf sync  

---

# 📦 Related Documentation

- **[overview.md](overview.md)** — High‑level summary of all Kobo features  
- **[kepubify.md](kepubify.md)** — Automatic KEPUB generation  
- **[kobo-sync-calibre-web.md](kobo-sync-calibre-web.md)** — Wi‑Fi sync via Calibre‑Web  
- **[kobo-series-metadata.md](kobo-series-metadata.md)** — Ensuring series metadata works correctly  
- **[kobo-thumbnails.md](kobo-thumbnails.md)** — High‑quality cover thumbnails  
- **[kobo-nickeldbus.md](kobo-nickeldbus.md)** — Native Kobo reading stats sync  
- **[kobo-koreader.md](kobo-koreader.md)** — Optional advanced reader  
- **[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)** — Kobo Store + Calibre‑Web hybrid sync
