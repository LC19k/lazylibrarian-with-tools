# 📡 Kobo Sync via Calibre‑Web  
This document explains how to enable **Kobo Sync** in Calibre‑Web, how to configure your Kobo device to use it, and how this affects Kobo Store purchases. It also covers hybrid sync options for households that want both Kobo Store and Calibre‑Web functionality.

---

# 🚀 What Is Kobo Sync in Calibre‑Web?

Calibre‑Web includes a feature that allows Kobo e‑readers to:

- Sync books **over Wi‑Fi**  
- Download KEPUBs directly from Calibre‑Web  
- Sync metadata (title, author, series, covers)  
- Sync shelves/collections  
- Sync reading positions (with NickelDBus)  

This effectively turns Calibre‑Web into a **private Kobo cloud**.

Your Kobo will treat Calibre‑Web as if it were Kobo’s own servers.

---

# ⚠️ What Kobo Sync Does *Not* Do

When you enable Calibre‑Web Kobo Sync:

### ❌ You cannot:
- Sync Kobo Store purchases automatically  
- Sync Kobo Plus books  
- Sync Kobo Store annotations  
- Use Kobo’s built‑in cloud backup  

### ✔ You can still:
- Buy books on the Kobo Store  
- Download them manually  
- Import them into Calibre  
- Sync them to your Kobo via Calibre‑Web or USB  

This is the standard workflow for power users.

---

# 🧩 How Kobo Sync Works Internally

Kobo devices normally sync to:
<https://storeapi.kobo.com/>

Calibre‑Web replaces this with:
<https://your-calibre-web-domain/kobo/>

Your Kobo then:

- Authenticates using a Calibre‑Web “Kobo user”  
- Requests book lists  
- Downloads KEPUBs  
- Updates reading positions (with NickelDBus)  
- Updates shelves  

This is a **full replacement** for Kobo’s cloud sync.

---

# 🛠 How to Enable Kobo Sync in Calibre‑Web

### 1. Open Calibre‑Web → Admin → Configuration  
Go to:
```Admin → Configuration → External Services```

### 2. Enable Kobo Sync  
Toggle:
[✔] Enable Kobo Sync

### 3. Create a Kobo Sync User  
Go to:
```Admin → Users → Add User```

Create a user with:

- A unique username (e.g., `kobo-sync`)
- A strong password
- “Kobo Sync” permissions enabled

### 4. Note your Calibre‑Web URL  
You will need:
<https://your-domain.com>
or
<http://your-ip:8083>

---

# 📱 How to Configure Your Kobo Device

You must edit the Kobo configuration file:
```.kobo/Kobo/Kobo eReader.conf```

### 1. Connect your Kobo via USB  
Open the `.kobo/Kobo/` directory.

### 2. Open `Kobo eReader.conf`  
Find the section:
```[General]```

### 3. Add or modify these lines:
```
[OneStoreServices]
Url=https://your-calibre-web-domain/kobo/
```

### 4. Eject the device  
Your Kobo will now sync from Calibre‑Web.

---

# 🔄 How Sync Works After Configuration

When you tap **Sync** on your Kobo:

- It contacts Calibre‑Web  
- Authenticates using the Kobo Sync user  
- Downloads new KEPUBs  
- Updates metadata  
- Updates shelves  
- (With NickelDBus) syncs reading positions  

This is a **full Wi‑Fi sync** workflow.

---

# 🛒 What About Kobo Store Purchases?

This is the most common question.

### ✔ You can still buy books on the Kobo Store  
### ❌ They will not auto‑sync to your device  
### ✔ You can download them manually  
### ✔ You can import them into Calibre  
### ✔ You can sync them via Calibre‑Web or USB  

This is the standard workflow for advanced Kobo users.

---

# 🔀 Hybrid Sync: Kobo Cloud + Calibre‑Web

Some households want:

- Kobo Store purchases to sync automatically  
- Calibre‑Web to sync sideloaded books  

This is possible using a **hybrid configuration**, documented here:
**[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)**

Hybrid sync allows:

### ✔ Kobo Store → Kobo Cloud → Device  
### ✔ Calibre‑Web → Kobo Sync → Device  

This is the best of both worlds, but requires:

- NickelMenu  
- A patched sync endpoint  
- Optional NickelDBus  

---

# 🧪 Verifying Kobo Sync Works

On your Kobo:

1. Tap **Sync**  
2. You should see:  
```Syncing with server…```
3. New books from Calibre‑Web should appear  
4. Shelves should update  
5. Covers should appear correctly  
6. (With NickelDBus) reading positions should sync  

---

# 🧠 Recommended Setup for Your Household

Given your environment:

- LazyLibrarian  
- Calibre  
- Calibre‑Web  
- kepubify  
- Multiple Kobo devices  

The recommended setup is:

### ✔ Automatic KEPUB generation  
### ✔ Calibre‑Web Kobo Sync  
### ✔ USB auto‑import  
### ✔ Series metadata fixes  
### ✔ Cover thumbnail generation  
### ✔ NickelDBus  
### ✔ (Optional) KOReader for technical books  

This gives you:

- Perfect metadata  
- Perfect covers  
- Fast Wi‑Fi sync  
- Full USB sync  
- Kobo‑native reading stats  
- Optional OPDS sync  

---

# 📦 Related Documentation

- **[overview.md](overview.md)** — High‑level summary of all Kobo features  
- **[kepubify.md](kepubify.md)** — Automatic KEPUB generation  
- **[kobo-usb-import.md](kobo-usb-import.md)** — USB sync for reading stats + annotations  
- **[kobo-series-metadata.md](kobo-series-metadata.md)** — Ensuring series metadata works correctly  
- **[kobo-thumbnails.md](kobo-thumbnails.md)** — High‑quality cover thumbnails  
- **[kobo-nickeldbus.md](kobo-nickeldbus.md)** — Native Kobo reading stats sync  
- **[kobo-koreader.md](kobo-koreader.md)** — Optional advanced reader  
- **[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)** — Kobo Store + Calibre‑Web hybrid sync
