# ------------------------------------------------------------
# LazyLibrarian + Calibre CLI + kepubify (+ optional full Calibre)
# Base: LinuxServer.io LazyLibrarian (Ubuntu Jammy)
# ------------------------------------------------------------
FROM lscr.io/linuxserver/lazylibrarian:latest

# Optional build-time toggles
ARG ENABLE_FULL_CALIBRE=0
ARG ENABLE_KOBO_PLUGIN=0

# For reproducibility, you can also pin these via build args
ARG KEPUBIFY_VERSION=latest

# Environment (inherits PUID/PGID/TZ from LSIO)
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Core tools: Calibre CLI (distro) + kepubify
# ------------------------------------------------------------
RUN \
  echo "**** install Calibre CLI + deps ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
      calibre \
      wget \
      ca-certificates \
      xz-utils \
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
      libx11-xcb1 && \
  rm -rf /var/lib/apt/lists/* && \
  \
  echo "**** install kepubify ****" && \
  mkdir -p /opt/tools && \
  if [ "${KEPUBIFY_VERSION}" = "latest" ]; then \
      wget -O /opt/tools/kepubify \
        https://github.com/pgaskin/kepubify/releases/latest/download/kepubify-linux-64bit ; \
  else \
      wget -O /opt/tools/kepubify \
        https://github.com/pgaskin/kepubify/releases/download/${KEPUBIFY_VERSION}/kepubify-linux-64bit ; \
  fi && \
  chmod +x /opt/tools/kepubify && \
  ln -sf /opt/tools/kepubify /usr/local/bin/kepubify

# ------------------------------------------------------------
# OPTIONAL: full Calibre (official binary installer)
# Heavy, but gives you GUI + full feature set if you ever need it.
# ------------------------------------------------------------
RUN \
  if [ "${ENABLE_FULL_CALIBRE}" = "1" ]; then \
    echo "**** installing full Calibre (official installer) ****" && \
    wget -O /tmp/calibre-installer.sh https://download.calibre-ebook.com/linux-installer.sh && \
    chmod +x /tmp/calibre-installer.sh && \
    /tmp/calibre-installer.sh && \
    rm -f /tmp/calibre-installer.sh ; \
  else \
    echo "**** skipping full Calibre install (ENABLE_FULL_CALIBRE=0) ****" ; \
  fi

# ------------------------------------------------------------
# OPTIONAL: KoboTouchExtended plugin scaffold
# (Actual plugin zip + config is usually managed manually or via a script)
# ------------------------------------------------------------
RUN \
  if [ "${ENABLE_KOBO_PLUGIN}" = "1" ]; then \
    echo "**** preparing KoboTouchExtended plugin directory ****" && \
    mkdir -p /config/calibre-plugins/KoboTouchExtended ; \
    echo "Place KoboTouchExtended.zip into /config/calibre-plugins/KoboTouchExtended manually or via script." ; \
  else \
    echo "**** skipping KoboTouchExtended setup (ENABLE_KOBO_PLUGIN=0) ****" ; \
  fi

# ------------------------------------------------------------
# PATH + small niceties
# ------------------------------------------------------------
ENV PATH="/opt/tools:${PATH}"

# LSIO entrypoint / s6 overlay remain intact
