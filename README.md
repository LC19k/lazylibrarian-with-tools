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

