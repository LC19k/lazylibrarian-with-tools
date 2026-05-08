#######################################################################
# LazyLibrarian + Calibre + minimal ffmpeg + kepubify (single container)
#######################################################################

############################
# Stage 1 — ffmpeg (minimal)
############################
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
        && make -j"$(nproc)" && make install


############################
# Stage 2 — kepubify
############################
FROM alpine:latest AS kepubify-builder

RUN apk add --no-cache wget && \
    wget -O /kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /kepubify


############################
# Stage 3 — Calibre install
############################
FROM debian:stable-slim AS calibre-builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        xz-utils \
        ca-certificates \
        python3 \
        python3-setuptools \
        libglib2.0-0 \
        libx11-6 \
        libxcb1 \
        libxext6 \
        libxrender1 \
        libxi6 \
        libsm6 \
        libice6 \
        libegl1 \
        libopengl0 \
        && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/installer.sh https://download.calibre-ebook.com/linux-installer.sh && \
    chmod +x /tmp/installer.sh && \
    /tmp/installer.sh install_dir=/opt/calibre && \
    rm /tmp/installer.sh

# Optional: trim GUI bulk if you want, but keep core libs intact
# RUN rm -rf \
#     /opt/calibre/resources/viewer \
#     /opt/calibre/resources/fonts \
#     /opt/calibre/resources/images \
#     /opt/calibre/resources/qtwebengine*


############################
# Stage 4 — Final image
############################
FROM lscr.io/linuxserver/lazylibrarian:latest

# ffmpeg
COPY --from=ffmpeg-builder /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg

# kepubify
COPY --from=kepubify-builder /kepubify /usr/local/bin/kepubify
RUN ln -s /usr/local/bin/kepubify /usr/bin/kepubify

# Calibre
COPY --from=calibre-builder /opt/calibre /opt/calibre

# Calibre CLI in PATH
RUN ln -s /opt/calibre/calibredb /usr/bin/calibredb && \
    ln -s /opt/calibre/ebook-convert /usr/bin/ebook-convert && \
    ln -s /opt/calibre/ebook-meta /usr/bin/ebook-meta && \
    ln -s /opt/calibre/ebook-polish /usr/bin/ebook-polish

# Critical: Calibre libs live directly in /opt/calibre
ENV LD_LIBRARY_PATH="/opt/calibre:${LD_LIBRARY_PATH}"

RUN rm -rf /tmp/* /var/tmp/*
