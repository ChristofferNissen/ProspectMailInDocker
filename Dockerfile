FROM debian:latest
LABEL author=stifstof
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -qy \
    curl \
    ca-certificates \
    sudo \
    libxkbfile1 \
    curl \
    fonts-noto-color-emoji \
    libsecret-1-0 \
    pulseaudio \
    gnupg2 \
    gvfs-bin \
    libglib2.0-bin \
    trash-cli \
    kde-cli-tools \
    libatspi2.0-0 \
    xdg-utils \
    libxtst6 \
    libxss1 \
    libnss3 \ 
    libnotify4 \ 
    git \
    libayatana-appindicator3-1 \
    libgtk-3-0 \
    libpci-dev \
    firefox-esr \
    wget \
    libgl1 \
    mesa-utils \
    libgl1-mesa-glx \
    rpm \
    binutils

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn
RUN npm install --global \
    electron \
    electron-settings \
    electron-builder

COPY docker-scripts/install-from-git.sh /
RUN ./install-from-git.sh

COPY docker-scripts/xdg-open /usr/local/bin/
COPY host-scripts/ /var/cache/app/
COPY docker-scripts/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

RUN apt-get install -y dbus

# Cleanup
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /prospect-mail

ENTRYPOINT ["/sbin/entrypoint.sh"]
