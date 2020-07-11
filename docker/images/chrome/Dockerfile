ARG base_image
FROM $base_image

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    google-chrome-stable \
    && apt-get purge --auto-remove -y curl gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome

USER chrome

EXPOSE 9222

ENTRYPOINT ["google-chrome-stable"]

CMD ["--headless", "--disable-gpu", "--no-sandbox", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222", "--enable-automation", "--disable-background-networking", "--no-default-browser-check", "--no-first-run", "--disable-popup-blocking", "--disable-default-apps", "--allow-insecure-localhost", "--disable-translate", "--disable-extensions", "--enable-features=Metal", "--window-size=1920,1080"]
