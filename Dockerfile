#######################################################################
# LazyLibrarian + Calibre (official installer) + ffmpeg + kepubify
# Base: LSIO LazyLibrarian (Ubuntu Jammy)
#######################################################################

FROM lscr.io/linuxserver/lazylibrarian:latest

# Optional: scaffold for KoboTouchExtended plugin
ARG ENABLE_KOBO_PLUGIN=0

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    LAZYLIBRARIAN_HOME="/app/lazylibrarian"

############################
# Install Calibre (official installer)
############################
RUN echo "**** install Calibre + deps ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates \
        libgl1 \
        libegl1 \
        libxrandr2 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxfixes3 \
        libxi6 \
        libxtst6 \
        libnss3 \
        libasound2 \
        libxkbcommon0 \
        libx11-xcb1 \
        && rm -rf /var/lib/apt/lists/* && \
    wget -O /tmp/calibre-installer.sh https://download.calibre-ebook.com/linux-installer.sh && \
    chmod +x /tmp/calibre-installer.sh && \
    /tmp/calibre-installer.sh && \
    rm -f /tmp/calibre-installer.sh

# Calibre installs into /opt/calibre by default; make sure CLI tools are on PATH
ENV PATH="/opt/calibre:${PATH}" \
    LD_LIBRARY_PATH="/opt/calibre:${LD_LIBRARY_PATH}"

############################
# Install kepubify
############################
RUN echo "**** install kepubify ****" && \
    wget -O /usr/local/bin/kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /usr/local/bin/kepubify && \
    ln -sf /usr/local/bin/kepubify /usr/bin/kepubify

############################
# Install ffmpeg (for audiobooks / media)
############################
RUN echo "**** install ffmpeg ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        && rm -rf /var/lib/apt/lists/*

############################
# OPTIONAL: KoboTouchExtended plugin scaffold
############################
RUN if [ "${ENABLE_KOBO_PLUGIN}" = "1" ]; then \
      echo "**** preparing KoboTouchExtended plugin directory ****" && \
      mkdir -p /config/calibre-plugins/KoboTouchExtended && \
      echo "Place KoboTouchExtended.zip into /config/calibre-plugins/KoboTouchExtended manually."; \
    else \
      echo "**** skipping KoboTouchExtended setup (ENABLE_KOBO_PLUGIN=0) ****"; \
    fi

############################
# Expose LazyLibrarian port
############################
EXPOSE 5299

############################
# Cleanup
############################
RUN rm -rf /tmp/* /var/tmp/*
