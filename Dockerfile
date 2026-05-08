#######################################################################
# Dockerfile: LazyLibrarian + kepubify + minimal ffmpeg
#
# Calibre is NO LONGER built inside this image.
# Calibre CLI tools are mounted from the LSIO Calibre container.
#######################################################################

#######################################################################
# Stage 1 — Build minimal ffmpeg
#######################################################################
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


#######################################################################
# Stage 2 — Build kepubify
#######################################################################
FROM alpine:latest AS kepubify-builder

RUN apk add --no-cache wget && \
    wget -O /kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /kepubify


#######################################################################
# Stage 3 — Final LazyLibrarian image
#######################################################################
FROM lscr.io/linuxserver/lazylibrarian:latest

# Copy minimal ffmpeg
COPY --from=ffmpeg-builder /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg

# Copy kepubify
COPY --from=kepubify-builder /kepubify /usr/local/bin/kepubify
RUN ln -s /usr/local/bin/kepubify /usr/bin/kepubify

# Cleanup
RUN rm -rf /tmp/* /var/tmp/*
