#######################################################################
# FINAL DOCKERFILE — LazyLibrarian + Calibre + ffmpeg + kepubify
# Base: LSIO LazyLibrarian (Python 3.10, stable)
#######################################################################

FROM lscr.io/linuxserver/lazylibrarian:latest

############################
# Install Calibre (self-contained binary tarball)
############################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

# Download and extract Calibre (NO strip-components)
RUN wget -O /tmp/calibre.txz https://download.calibre-ebook.com/9.7.0/calibre-9.7.0-x86_64.txz && \
    mkdir -p /opt/calibre && \
    tar -xJf /tmp/calibre.txz -C /opt/calibre && \
    rm /tmp/calibre.txz

# Add Calibre CLI tools to PATH
RUN ln -sf /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -sf /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -sf /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -sf /opt/calibre/ebook-polish /usr/bin/ebook-polish

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
