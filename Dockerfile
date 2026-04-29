###############################################
# Stage 1 — Build minimal ffmpeg
###############################################
FROM debian:stable-slim AS ffmpeg-builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        yasm \
        pkg-config \
        wget \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN wget https://ffmpeg.org/releases/ffmpeg-6.1.1.tar.gz && \
    tar -xzf ffmpeg-6.1.1.tar.gz && \
    cd ffmpeg-6.1.1 && \
    ./configure \
        --disable-everything \
        --enable-small \
        --enable-protocol=file \
        --enable-demuxer=mp3 \
        --enable-demuxer=wav \
        --enable-demuxer=ogg \
        --enable-demuxer=flac \
        --enable-muxer=mp3 \
        --enable-muxer=wav \
        --enable-muxer=ogg \
        --enable-muxer=flac \
        --enable-decoder=mp3 \
        --enable-decoder=pcm_s16le \
        --enable-decoder=vorbis \
        --disable-debug \
        --disable-doc \
        && make -j$(nproc) && make install


###############################################
# Stage 2 — Build Calibre CLI tools (headless)
###############################################
FROM debian:stable-slim AS calibre-builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/calibre.txz \
        https://download.calibre-ebook.com/9.7.0/calibre-9.7.0-x86_64.txz && \
    mkdir -p /opt/calibre && \
    tar -xJf /tmp/calibre.txz -C /opt/calibre --strip-components=1 && \
    rm /tmp/calibre.txz

# Remove GUI components to reduce image size
RUN rm -rf \
    /opt/calibre/lib/python3.*/site-packages/calibre/gui \
    /opt/calibre/resources/viewer \
    /opt/calibre/resources/fonts \
    /opt/calibre/resources/images \
    /opt/calibre/resources/qtwebengine* \
    /opt/calibre/lib/libQt* \
    /opt/calibre/lib/libxcb* \
    /opt/calibre/lib/libX* \
    /opt/calibre/lib/libGL* \
    /opt/calibre/lib/libEGL* \
    /opt/calibre/lib/libOpenGL*


###############################################
# Stage 3 — Build kepubify (standalone)
###############################################
FROM alpine:latest AS kepubify-builder

RUN apk add --no-cache wget && \
    wget -O /kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /kepubify


###############################################
# Stage 4 — Final LazyLibrarian image
###############################################
FROM lscr.io/linuxserver/lazylibrarian:latest

# Install runtime dependencies for Calibre CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        libxml2 \
        libxslt1.1 \
        libjpeg-turbo8 \
        libpng16-16 \
        libfreetype6 \
        libharfbuzz0b \
        libfontconfig1 \
        unrar \
        && rm -rf /var/lib/apt/lists/*

# Copy Calibre CLI tools
COPY --from=calibre-builder /opt/calibre /opt/calibre

# Copy minimal ffmpeg
COPY --from=ffmpeg-builder /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg

# Copy kepubify from builder stage
COPY --from=kepubify-builder /kepubify /usr/local/bin/kepubify
RUN ln -s /usr/local/bin/kepubify /usr/bin/kepubify

# Symlink Calibre tools
RUN ln -s /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -s /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -s /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -s /opt/calibre/ebook-polish /usr/bin/ebook-polish

RUN rm -rf /tmp/* /var/tmp/*
