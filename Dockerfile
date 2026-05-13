#######################################################################
# LazyLibrarian + Calibre (self-contained .txz) + ffmpeg + kepubify
# Base: LSIO LazyLibrarian (Ubuntu Jammy)
#######################################################################

FROM lscr.io/linuxserver/lazylibrarian:latest

ARG ENABLE_KOBO_PLUGIN=0
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    LAZYLIBRARIAN_HOME="/app/lazylibrarian"

############################
# Install dependencies for Calibre + tools
############################
RUN echo "**** install base deps ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates \
        ffmpeg \
        && rm -rf /var/lib/apt/lists/*

############################
# Install Calibre (self-contained tarball)
############################
RUN echo "**** install Calibre (self-contained .txz) ****" && \
    wget -O /tmp/calibre.txz https://download.calibre-ebook.com/9.7.0/calibre-9.7.0-x86_64.txz && \
    mkdir -p /opt/calibre && \
    tar -xJf /tmp/calibre.txz -C /opt/calibre && \
    rm /tmp/calibre.txz && \
    ln -sf /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -sf /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -sf /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -sf /opt/calibre/ebook-polish /usr/bin/ebook-polish

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
