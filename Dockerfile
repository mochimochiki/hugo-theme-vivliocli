# hugo-theme-vivliocli: exampleSite ビルド + Vivliostyle PDF 生成用イメージ
#
# 方針(ハンドオフ準拠):
#   - Debian ベース(Vivliostyle CLI 公式 Dockerfile の依存に寄せる)
#   - Hugo extended は gh-pages.yml と同じ v0.163.1
#   - PDF/フォント依存: chromium, ghostscript, poppler-utils, Noto CJK, fontconfig
#   - Chromium は apt 版を使用し Playwright/Vivliostyle 双方を /usr/bin/chromium に向ける
FROM debian:bookworm-slim

ARG HUGO_VERSION=0.163.1
ARG TARGETARCH=amd64

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    # Playwright/Puppeteer のブラウザ自動DLを抑止し、apt の chromium を使う
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 \
    PUPPETEER_SKIP_DOWNLOAD=1 \
    CHROMIUM_PATH=/usr/bin/chromium

# 1. システム依存 + Node.js(NodeSource LTS) + Chromium / PDF / フォント
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ca-certificates curl gnupg git \
      chromium \
      ghostscript poppler-utils \
      fontconfig fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji; \
    mkdir -p /etc/apt/keyrings; \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends nodejs; \
    rm -rf /var/lib/apt/lists/*

# 2. Hugo extended (gh-pages.yml と同一バージョン)
RUN set -eux; \
    curl -fsSL -o /tmp/hugo.deb \
      "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.deb"; \
    apt-get install -y --no-install-recommends /tmp/hugo.deb; \
    rm -f /tmp/hugo.deb; \
    hugo version

# 3. fontconfig エイリアス(Yu Gothic / Consolas 等 -> Noto CJK)
COPY docker/fonts.conf /etc/fonts/conf.d/99-vivliocli-cjk.conf
RUN fc-cache -f

# テーマ解決のため、リポジトリは「hugo-theme-vivliocli」という名前のディレクトリに置く。
# hugo.toml の themesdir="../.." + theme="hugo-theme-vivliocli" は、exampleSite から 2 階層上を
# テーマ root とし、その下の hugo-theme-vivliocli をテーマとして解決する。よって
#   exampleSite(/work/hugo-theme-vivliocli/exampleSite) の ../.. = /work
#   theme = /work/hugo-theme-vivliocli = リポジトリ自身
# となるように WORKDIR を配置する。(GitHub Actions の二重ネスト checkout と同じ仕組み)
WORKDIR /work/hugo-theme-vivliocli

# 自己完結イメージ(CI 用)。docker compose ではこの上に bind mount で上書きする。
COPY . .

# 既定では exampleSite の PDF をビルドする
ENTRYPOINT ["bash", "exampleSite/CI/linux/build_pdf.sh"]
CMD []
