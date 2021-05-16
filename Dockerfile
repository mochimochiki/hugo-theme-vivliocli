FROM node:16-slim
LABEL maintainer "mochimochiki"

# for puppeteer
RUN apt-get update \
  && apt-get install -y \
      wget \
      gnupg \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
      google-chrome-stable \
      fonts-ipafont-gothic \
      fonts-freefont-ttf \
      libxss1 \
  && rm -rf /var/lib/apt/lists/*

# hugo
ENV HUGO_VERSION='0.83.1'
ENV HUGO_NAME="hugo_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV HUGO_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/${HUGO_NAME}.tar.gz"
ENV HUGO_CHECKSUM_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt"
WORKDIR /hugo
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
      git \
      ca-certificates \
  && wget --quiet "${HUGO_URL}" \
  && wget --quiet "${HUGO_CHECKSUM_URL}" \
  && grep "${HUGO_NAME}.tar.gz" "./hugo_${HUGO_VERSION}_checksums.txt" | sha256sum -c - \
  && tar -zxvf "${HUGO_NAME}.tar.gz" \
  && mv ./hugo /usr/bin/hugo \
  && rm -rf /hugo \
  && rm -rf /var/lib/apt/lists/*

# vivliostyle
ENV VIVLIOSTYLE_VERSION='3.3.0'
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
      libasound2-dev \
      libgtk-3-0 \
      libnss3-dev \
      libx11-xcb-dev \
      libxss-dev \
      libxtst-dev \
      poppler-utils \
      ghostscript \
  && rm -rf /var/lib/apt/lists/*
RUN npm install -g @vivliostyle/cli@${VIVLIOSTYLE_VERSION}
RUN groupadd -r vivliouser \
  && useradd -r -g vivliouser -G audio,video vivliouser

COPY . /hugo-theme-vivliocli
WORKDIR /hugo-theme-vivliocli

RUN chown -R vivliouser:vivliouser /hugo-theme-vivliocli
USER vivliouser

ENTRYPOINT [ "/hugo-theme-vivliocli/exampleSite/build.sh" ]
