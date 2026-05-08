#######################################################################
# FINAL DOCKERFILE — LazyLibrarian + Calibre + ffmpeg + kepubify
# Base: LSIO LazyLibrarian (Python 3.10, stable)
#######################################################################

FROM lscr.io/linuxserver/lazylibrarian:latest

############################
# Install Calibre (official installer)
############################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        python3 \
        python3-setuptools \
        python3-lxml \
        python3-openssl \
        libegl1 \
        libopengl0 \
        libxcb-cursor0 \
        libxkbcommon0 \
        libxkbcommon-x11-0 \
        libxcb-xkb1 \
        libxcb-render0 \
        libxcb-shape0 \
        libxcb-xfixes0 \
        libgl1 \
        libglx0 \
        libglvnd0 \
        libwayland-client0 \
        libwayland-cursor0 \
        libwayland-egl1 \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/installer.sh https://download.calibre-ebook.com/linux-installer.sh && \
    chmod +x /tmp/installer.sh && \
    /tmp/installer.sh install_dir=/opt/calibre && \
    rm /tmp/installer.sh

# Add Calibre CLI tools to PATH
RUN ln -s /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -s /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -s /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -s /opt/calibre/ebook-polish /usr/bin/ebook-polish

############################
# Install kepubify
############################
RUN wget -O /usr/local/bin/kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /usr/local/bin/kepubify && \
    ln -s /usr/local/bin/kepubify /usr/bin/kepubify

############################
# Install ffmpeg
############################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        && rm -rf /var/lib/apt/lists/*

############################
# Environment
############################
ENV PYTHONUNBUFFERED=1
ENV LAZYLIBRARIAN_HOME="/app/lazylibrarian"
ENV LD_LIBRARY_PATH="/opt/calibre:${LD_LIBRARY_PATH}"

############################
# Expose LazyLibrarian port
############################
EXPOSE 5299

############################
# Cleanup
############################
RUN rm -rf /tmp/* /var/tmp/*
