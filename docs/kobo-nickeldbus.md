# 🔄 NickelDBus (Kobo Native Sync Enhancements)  
NickelDBus is an advanced integration layer for Kobo e‑readers that exposes Kobo’s internal **Nickel** APIs over DBus. This enables deep synchronization features that are not available through standard Calibre‑Web or USB workflows.

This document explains:

- What NickelDBus is  
- What it enables  
- How to install it  
- How to integrate it with Calibre and Calibre‑Web  
- How it interacts with Wi‑Fi and USB sync  
- Whether your household should use it  
- How to verify it’s working  

---

# 🚀 What Is NickelDBus?

NickelDBus is a lightweight service that runs on Kobo devices and exposes internal Kobo functionality over DBus.  
It allows external tools (Calibre, Calibre‑Web, scripts) to:

- Read and write reading positions  
- Read and write annotations  
- Read and write bookmarks  
- Read and write shelves  
- Trigger sync events  
- Query device metadata  
- Update book metadata  
- Update reading stats  

This effectively gives you **programmatic control** over Kobo’s native reading app (Nickel).

---

# 📊 What NickelDBus Enables

NickelDBus unlocks features that neither Calibre‑Web nor USB sync can do alone.

## ✔ Reading Position Sync (Wi‑Fi)
Calibre‑Web can sync reading positions **if NickelDBus is installed**.

Without NickelDBus:

- Kobo → Calibre: ❌  
- Calibre → Kobo: ❌  

With NickelDBus:

- Kobo → Calibre: ✔  
- Calibre → Kobo: ✔  

## ✔ Annotation Sync
NickelDBus exposes:

- Highlights  
- Notes  
- Bookmarks  

These can be synced to Calibre or exported.

## ✔ Shelf Sync
NickelDBus allows:

- Creating shelves  
- Updating shelves  
- Assigning books to shelves  
- Syncing shelves over Wi‑Fi  

## ✔ Metadata Sync
NickelDBus can update:

- Title  
- Author  
- Series  
- Series index  
- Covers  
- Reading stats  

## ✔ Triggering Sync Events
You can trigger:

- Metadata refresh  
- Cover refresh  
- Library rebuild  
- Sync with Calibre‑Web  

---

# 🧠 Why NickelDBus Matters (Even With USB Sync)

USB sync is still essential for:

- Full annotation import  
- Full reading stats import  
- Full metadata updates  

But NickelDBus adds:

### ✔ Wi‑Fi reading position sync  
### ✔ Wi‑Fi annotation sync  
### ✔ Wi‑Fi shelf sync  
### ✔ Wi‑Fi metadata sync  
### ✔ Wi‑Fi cover sync  

This means:

- You don’t need to plug in your Kobo every time  
- Calibre‑Web becomes a true cloud sync provider  
- Your reading progress stays up‑to‑date across devices  

---

# 🛠 How to Install NickelDBus

NickelDBus requires:

- A Kobo device  
- NickelMenu installed  
- A simple configuration file  

### 1. Install NickelMenu  
Follow the official instructions:

https://github.com/pgaskin/NickelMenu

NickelMenu allows you to run custom commands from the Kobo UI.

### 2. Download NickelDBus  
Get the latest release:

https://github.com/pgaskin/nickeldbus

Download:
```nickeldbus.kobo```

### 3. Copy to Kobo  
Place the file in:

```.kobo/```

### 4. Eject the device  
Kobo will install NickelDBus automatically.

### 5. Add NickelMenu entries  
Create or edit:

```.kobo/NickelMenu/config```

Add:

```
menu_item :main :Restart NickelDBus :cmd_spawn :nickeldbusctl restart
menu_item :main :NickelDBus Status :cmd_spawn :nickeldbusctl status
```

### 6. Reboot the device  
NickelDBus will now be active.

---

# 🔗 Integrating NickelDBus with Calibre‑Web

Calibre‑Web automatically detects NickelDBus if:

- Kobo Sync is enabled  
- The device reports NickelDBus availability  

This enables:

- Reading position sync  
- Annotation sync  
- Shelf sync  
- Metadata sync  

No additional configuration is required.

---

# 🔗 Integrating NickelDBus with Calibre

Calibre can use NickelDBus to:

- Update metadata  
- Update covers  
- Update series info  
- Sync reading positions  
- Sync annotations  

This happens automatically when:

- The device is connected via USB  
- The KoboTouchExtended driver is active  

---

# 🔄 How NickelDBus Interacts with Wi‑Fi and USB Sync

| Feature | Wi‑Fi Sync | USB Sync | NickelDBus |
|--------|------------|----------|------------|
| Download books | ✔ | ✔ | — |
| Update metadata | ✔ | ✔ | ✔ |
| Update covers | ✔ | ✔ | ✔ |
| Update shelves | ✔ | ✔ | ✔ |
| Reading positions | ❌ | ✔ | ✔ |
| Highlights | ❌ | ✔ | ✔ |
| Notes | ❌ | ✔ | ✔ |
| Annotations | ❌ | ✔ | ✔ |
| Time read | ❌ | ✔ | ✔ |
| Page counts | ❌ | ✔ | ✔ |
| Kobo stats | ❌ | ✔ | ✔ |

### Summary  
- Wi‑Fi sync is convenient  
- USB sync is complete  
- NickelDBus makes Wi‑Fi sync **almost as complete as USB sync**  

---

# 🧪 Verifying NickelDBus Is Working

On your Kobo:

1. Tap the **NickelMenu** icon  
2. Tap:

```NickelDBus Status```

You should see:

```nickeldbus: running```

In Calibre‑Web:

- Reading positions should update  
- Shelves should sync  
- Metadata should sync  

---

# 🧭 Should Your Household Use NickelDBus?

Given your setup:

- Multiple Kobo devices  
- LazyLibrarian  
- Calibre  
- Calibre‑Web  
- kepubify  
- USB auto‑import  
- Desire for reading stats sync  

### ✔ Yes — NickelDBus is recommended.

It gives you:

- Wi‑Fi reading position sync  
- Wi‑Fi annotation sync  
- Wi‑Fi shelf sync  
- Wi‑Fi metadata sync  
- Faster updates  
- Less reliance on USB  

USB sync is still useful, but NickelDBus makes daily use smoother.

---

# 📦 Related Documentation

- **[overview.md](overview.md)** — High‑level summary of all Kobo features  
- **[kepubify.md](kepubify.md)** — Automatic KEPUB generation  
- **[kobo-sync-calibre-web.md](kobo-sync-calibre-web.md)** — Wi‑Fi sync via Calibre‑Web  
- **[kobo-usb-import.md](kobo-usb-import.md)** — USB sync for reading stats + annotations  
- **[kobo-series-metadata.md](kobo-series-metadata.md)** — Ensuring series metadata works correctly  
- **[kobo-thumbnails.md](kobo-thumbnails.md)** — High‑quality cover thumbnails  
- **[kobo-koreader.md](kobo-koreader.md)** — Optional advanced reader  
- **[hybrid-kobo-cloud.md](hybrid-kobo-cloud.md)** — Kobo Store + Calibre‑Web hybrid sync
