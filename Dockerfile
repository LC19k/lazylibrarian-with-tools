###############################################
# Stage 1 — Build Calibre CLI tools
###############################################
FROM debian:stable-slim AS calibre-builder

# Install only what is needed to extract Calibre
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download and extract Calibre 9.7
RUN wget -O /tmp/calibre.txz \
        https://download.calibre-ebook.com/9.7.0/calibre-9.7.0-x86_64.txz && \
    mkdir -p /opt/calibre && \
    tar -xJf /tmp/calibre.txz -C /opt/calibre --strip-components=1 && \
    rm /tmp/calibre.txz

# Remove GUI components to shrink size
RUN rm -rf \
    /opt/calibre/lib/python3.*/site-packages/calibre/gui \
    /opt/calibre/lib/python3.*/site-packages/calibre/ebooks/rtf2xml \
    /opt/calibre/lib/python3.*/site-packages/calibre/ebooks/pdf/render \
    /opt/calibre/resources/viewer \
    /opt/calibre/resources/fonts \
    /opt/calibre/resources/images \
    /opt/calibre/resources/qtwebengine \
    /opt/calibre/resources/qtwebengine_dictionaries \
    /opt/calibre/resources/qtwebengine_locales \
    /opt/calibre/resources/qtwebengine_resources \
    /opt/calibre/lib/libQt5* \
    /opt/calibre/lib/libQt6* \
    /opt/calibre/lib/libQtWebEngine* \
    /opt/calibre/lib/libQtWebKit* \
    /opt/calibre/lib/libxcb* \
    /opt/calibre/lib/libX* \
    /opt/calibre/lib/libGL* \
    /opt/calibre/lib/libEGL* \
    /opt/calibre/lib/libOpenGL*


###############################################
# Stage 2 — Final LazyLibrarian image
###############################################
FROM lscr.io/linuxserver/lazylibrarian:latest

# Install runtime dependencies for Calibre CLI tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        ffmpeg \
        unrar \
        libglib2.0-0 \
        libxml2 \
        libxslt1.1 \
        libjpeg62-turbo \
        libpng16-16 \
        libfreetype6 \
        libharfbuzz0b \
        libfontconfig1 \
        && rm -rf /var/lib/apt/lists/*

# Copy only the CLI tools from the builder stage
COPY --from=calibre-builder /opt/calibre /opt/calibre

# Symlink binaries into PATH
RUN ln -s /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -s /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -s /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -s /opt/calibre/ebook-polish /usr/bin/ebook-polish

# Cleanup
RUN rm -rf /tmp/* /var/tmp/*
