# 🔀 Hybrid Kobo Cloud + Calibre‑Web Sync  
This document explains how to configure a **hybrid sync setup** that allows your Kobo device to:

- Continue syncing **Kobo Store purchases** normally  
- Sync **sideloaded books** via Calibre‑Web  
- Avoid breaking Kobo Plus, Store sync, or firmware updates  
- Use NickelMenu to switch between sync endpoints  
- Use NickelDBus to sync reading positions over Wi‑Fi  

This setup gives you the best of both worlds.

---

# 🚀 Why Hybrid Sync Exists

Kobo devices normally sync to:
<https://storeapi.kobo.com/>

Calibre‑Web Kobo Sync replaces this with:
```https://your-calibre-web-domain/kobo/```

But replacing the endpoint entirely means:

### ❌ Kobo Store purchases no longer auto‑sync  
### ❌ Kobo Plus stops working  
### ❌ Kobo Store annotations stop syncing  
### ❌ Kobo Cloud backup stops working  

Hybrid sync solves this by allowing **both** endpoints to coexist.

---

# 🧩 How Hybrid Sync Works

Hybrid sync uses:

- **NickelMenu** to switch between sync endpoints  
- **NickelDBus** to sync reading positions  
- **Calibre‑Web** for sideloaded books  
- **Kobo Cloud** for purchased books  

You choose which sync endpoint to use **per sync event**.

### Example workflow:

1. Tap **Sync (Kobo Cloud)** → Kobo Store purchases download  
2. Tap **Sync (Calibre‑Web)** → Sideloaded books sync  
3. Reading positions sync via NickelDBus  
4. USB sync still works normally  

This gives you full flexibility.

---

# 🛠 Requirements

Hybrid sync requires:

- NickelMenu  
- NickelDBus (optional but recommended)  
- Calibre‑Web with Kobo Sync enabled  
- A working HTTPS domain for Calibre‑Web  
- A Kobo device running modern firmware  

---

# 🛠 Step 1 — Install NickelMenu

Follow the official instructions:

https://github.com/pgaskin/NickelMenu

NickelMenu allows you to add custom menu entries to the Kobo UI.

---

# 🛠 Step 2 — Add Dual Sync Menu Entries

Edit:
```.kobo/NickelMenu/config```

Add the following entries:

### ✔ Sync with Kobo Cloud (default)
```menu_item :main :Sync (Kobo Cloud) :nickel_misc :sync```

This triggers the **normal Kobo Store sync**.

### ✔ Sync with Calibre‑Web

Replace `your-domain.com` with your actual domain:

```menu_item :main :Sync (Calibre‑Web) :cmd_spawn :quiet :dbus-send --system --type=method_call --dest=com.kobo.nickel /com/kobo/nickel com.kobo.nickel.syncWithUrl string:"https://your-domain.com/kobo/"```

This triggers a **Calibre‑Web sync** without replacing the default endpoint.

---

# 🛠 Step 3 — (Optional) Add NickelDBus Sync Enhancements

Add:
```
menu_item :main :Sync Reading Position :cmd_spawn :nickeldbusctl sync
menu_item :main :Sync Shelves :cmd_spawn :nickeldbusctl shelves sync
menu_item :main :Sync Metadata :cmd_spawn :nickeldbusctl metadata sync
```

These commands:

- Sync reading positions  
- Sync shelves  
- Sync metadata  
- Sync annotations  

All over Wi‑Fi.

---

# 🔄 How Hybrid Sync Behaves

| Action | Kobo Cloud | Calibre‑Web |
|--------|------------|-------------|
| Sync purchased books | ✔ | ❌ |
| Sync sideloaded books | ❌ | ✔ |
| Sync metadata | ✔ | ✔ |
| Sync covers | ✔ | ✔ |
| Sync shelves | ✔ | ✔ |
| Sync reading positions | ❌ | ✔ (with NickelDBus) |
| Sync annotations | ❌ | ✔ (with NickelDBus) |
| Kobo Plus | ✔ | ❌ |
| Firmware updates | ✔ | ❌ |

### Summary  
- Kobo Cloud handles **purchased content**  
- Calibre‑Web handles **sideloaded content**  
- NickelDBus handles **reading positions + annotations**  

---

# 🧪 Verifying Hybrid Sync Works

### 1. Test Kobo Cloud sync  
Tap:
```Sync (Kobo Cloud)```

You should see:
```Syncing with Kobo…```

### 2. Test Calibre‑Web sync  
Tap:
```Sync (Calibre‑Web)```

You should see:
```Syncing with server…```

### 3. Test reading position sync  
Open a book → read a few pages → tap:
```Sync Reading Position```

Check Calibre‑Web → book details → reading position should update.

---

# 🧭 Should Your Household Use Hybrid Sync?

Given your setup:

- Multiple Kobo devices  
- LazyLibrarian  
- Calibre  
- Calibre‑Web  
- kepubify  
- NickelDBus  
- Desire to keep Kobo Store purchases working  

### ✔ Yes — hybrid sync is ideal for your family.

It gives you:

### ✔ Kobo Store purchases sync normally  
### ✔ Kobo Plus continues working  
### ✔ Sideloaded books sync via Calibre‑Web  
### ✔ Reading positions sync via NickelDBus  
### ✔ USB sync still works  
### ✔ No loss of Kobo features  

This is the **best possible Kobo experience**.

---

# 📦 Related Documentation

- **[overview.md](overview.md)** — High‑level summary of all Kobo features  
- **[kepubify.md](kepubify.md)** — Automatic KEPUB generation  
- **[kobo-sync-calibre-web.md](kobo-sync-calibre-web.md)** — Wi‑Fi sync via Calibre‑Web  
- **[kobo-usb-import.md](kobo-usb-import.md)** — USB sync for reading stats + annotations  
- **[kobo-series-metadata.md](kobo-series-metadata.md)** — Ensuring series metadata works correctly  
- **[kobo-thumbnails.md](kobo-thumbnails.md)** — High‑quality cover thumbnails  
- **[kobo-nickeldbus.md](kobo-nickeldbus.md)** — Native Kobo reading stats sync  
- **[kobo-koreader.md](kobo-koreader.md)** — Optional advanced reader
