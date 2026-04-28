FROM lscr.io/linuxserver/lazylibrarian:latest

# Install Calibre + ffmpeg + dependencies
RUN apt-get update && \
    apt-get install -y calibre ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
