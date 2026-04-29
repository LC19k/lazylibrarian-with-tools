# 🛠️ Troubleshooting Guide  
This document covers common issues encountered in the LazyLibrarian + Calibre + Kobo workflow and how to fix them.

---

# ❗ Common Issues & Fixes

## 1. KEPUBs not generating  
**Cause:** kepubify not detected  
**Fix:**  
- Run `which kepubify` inside the container  
- Ensure the symlink exists: `/usr/bin/kepubify`  

---

## 2. Series metadata missing on Kobo  
**Cause:** KoboTouchExtended not configured  
**Fix:**  
Enable in Calibre:  
[✔] Set series information
[✔] Set series index
[✔] Upload covers
[✔] Generate thumbnails


---

## 3. Covers missing or blurry  
**Cause:** Thumbnails not generated  
**Fix:**  
- Enable “Generate thumbnails” in KTE  
- Resend the book  
- Or rebuild `.kobo/images/`  

---

## 4. Calibre‑Web sync fails  
**Cause:** HTTPS misconfiguration  
**Fix:**  
- Ensure valid SSL cert  
- Ensure `/kobo/` endpoint accessible  

---

## 5. Reading positions not syncing  
**Cause:** NickelDBus not installed  
**Fix:**  
- Install NickelDBus  
- Add NickelMenu entries  

---

## 6. Kobo Store purchases not syncing  
**Cause:** Calibre‑Web replaced sync endpoint  
**Fix:**  
Use hybrid sync:  
- Keep Kobo Cloud endpoint  
- Add Calibre‑Web sync via NickelMenu  

---

## 7. USB sync not importing annotations  
**Cause:** Device database corrupted  
**Fix:**  
- Backup `KoboReader.sqlite`  
- Delete it  
- Reconnect Kobo  
- Resend books  

---

# 🧪 Diagnostic Commands

### Check kepubify  
```which kepubify```

### Check Calibre version  
```ebook-convert --version```

### Check ffmpeg  
```ffmpeg -version```

---

# ✔ Summary

Most issues come from:

- Missing KTE settings  
- Missing NickelDBus  
- Incorrect sync endpoint  
- Corrupted Kobo database  

This guide resolves all common cases.
