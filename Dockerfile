# Install dependencies for Calibre
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        libgl1 \
        libegl1 \
        libopengl0 \
        libxkbcommon0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-shape0 \
        libxcb-xfixes0 \
        libxcb-xinerama0 \
        libxcb-xinput0 \
        libxcb-xkb1 \
        libxkbcommon-x11-0 \
        python3 \
        python3-pip \
        ffmpeg \
        unrar \
        && rm -rf /var/lib/apt/lists/*

# Install Calibre 9.7
RUN wget -O /tmp/calibre-installer.sh \
        https://download.calibre-ebook.com/9.7.0/calibre-9.7.0-x86_64.txz && \
    mkdir -p /opt/calibre && \
    tar -xJf /tmp/calibre-installer.sh -C /opt/calibre --strip-components=1 && \
    ln -s /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -s /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -s /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -s /opt/calibre/ebook-polish /usr/bin/ebook-polish && \
    ln -s /opt/calibre/ebook-viewer /usr/bin/ebook-viewer && \
    rm /tmp/calibre-installer.sh

# Install kepubify (optional but recommended)
RUN wget -O /usr/local/bin/kepubify \
        https://github.com/pgaskin/kepubify/releases/download/v4.0.5/kepubify-linux-64bit && \
    chmod +x /usr/local/bin/kepubify

# Cleanup
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*
