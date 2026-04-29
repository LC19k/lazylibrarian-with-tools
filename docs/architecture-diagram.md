# 🏗️ Architecture Diagram  
This document provides a high‑level architecture diagram of the **LazyLibrarian + Calibre + Calibre‑Web + Kobo** ecosystem.

---

# 📐 System Overview (Text Diagram)
```mermaid
---
config:
  layout: elk
---
flowchart TD
    LazyLibrarian["<h3>LazyLibrarian</h3>Downloads books<br/>Post-processing<br/>Calls kepubify"]
    Calibre["<h3>Calibre</h3>Library management<br/>Metadata<br/>Series info<br/>USB sync<br/>KoboTouchExtended"]
    CalibreWeb["<h3>Calibre-Web</h3>OPDS server<br/>Kobo Sync endpoint<br/>Web UI"]
    Kobo["<h3>Kobo</h3>Nickel native reader<br/>NickelDBus optional<br/>KOReader optional<br/>Wi-Fi sync<br/>USB sync"]
    
    LazyLibrarian --> Calibre
    Calibre --> CalibreWeb
    CalibreWeb --> Kobo
    
    classDef lazyStyle stroke:#818cf8,fill:#eef2ff,color:#1e1b4b
    classDef calibreStyle stroke:#2dd4bf,fill:#f0fdfa,color:#1e1b4b
    classDef webStyle stroke:#a78bfa,fill:#f5f3ff,color:#1e1b4b
    classDef deviceStyle stroke:#fb923c,fill:#fff7ed,color:#1e1b4b
    
    class LazyLibrarian lazyStyle
    class Calibre calibreStyle
    class CalibreWeb webStyle
    class Kobo deviceStyle
```
---

# 🔄 Data Flow Summary

### 1. LazyLibrarian → Calibre  
- Books downloaded  
- EPUB → KEPUB conversion  
- Metadata applied  

### 2. Calibre → Calibre‑Web  
- Library exposed via OPDS  
- Kobo Sync endpoint enabled  

### 3. Calibre‑Web → Kobo (Wi‑Fi)  
- Book downloads  
- Metadata sync  
- Shelf sync  
- Reading position sync (with NickelDBus)  

### 4. Calibre ↔ Kobo (USB)  
- Full metadata sync  
- Annotation sync  
- Reading stats sync  
- Thumbnail generation  

---

# 🧠 Optional Components

### NickelDBus  
Adds reading position + annotation sync over Wi‑Fi.

### KOReader  
Adds OPDS browsing + advanced PDF support.

---

# ✔ Summary

This architecture provides:

- Deterministic builds  
- Automatic KEPUB generation  
- Perfect metadata  
- Perfect covers  
- Wi‑Fi + USB sync  
- Optional advanced features
