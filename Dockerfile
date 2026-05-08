#######################################################################
# FINAL DOCKERFILE — LazyLibrarian + Calibre + ffmpeg + kepubify
# Base: LSIO Calibre (includes full Calibre runtime + Qt6 + OpenGL)
#######################################################################

FROM lscr.io/linuxserver/calibre:latest

############################
# Install LazyLibrarian
############################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        python3 \
        python3-pip \
        python3-lxml \
        python3-openssl \
        python3-setuptools \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

# Install LazyLibrarian from GitHub
RUN git clone https://github.com/lazylibrarian/LazyLibrarian.git /app/lazylibrarian

############################
# Install kepubify
############################
RUN wget -O /usr/local/bin/kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit && \
    chmod +x /usr/local/bin/kepubify && \
    ln -s /usr/local/bin/kepubify /usr/bin/kepubify

############################
# Install minimal ffmpeg
############################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        && rm -rf /var/lib/apt/lists/*

############################
# Calibre CLI already exists:
#   /usr/bin/calibredb
#   /usr/bin/ebook-convert
#   /usr/bin/ebook-meta
#   /usr/bin/ebook-polish
############################

############################
# Configure LazyLibrarian service
############################
ENV LAZYLIBRARIAN_HOME="/app/lazylibrarian"
ENV PYTHONUNBUFFERED=1

# Expose LazyLibrarian port
EXPOSE 5299

# s6 overlay already exists in LSIO base image
# Create service directory
RUN mkdir -p /etc/services.d/lazylibrarian

# s6 service run script
RUN printf '#!/usr/bin/with-contenv bash\nexec python3 /app/lazylibrarian/LazyLibrarian.py --nolaunch\n' \
    > /etc/services.d/lazylibrarian/run && \
    chmod +x /etc/services.d/lazylibrarian/run

# s6 finish script
RUN printf '#!/usr/bin/with-contenv bash\nexit 0\n' \
    > /etc/services.d/lazylibrarian/finish && \
    chmod +x /etc/services.d/lazylibrarian/finish

############################
# Cleanup
############################
RUN rm -rf /tmp/* /var/tmp/*
