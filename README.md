# hugo-theme-vivliocli

hugo-theme-vivliocli is a Hugo theme for converting websites to PDF using [Vivliostyle-cli](https://github.com/vivliostyle/vivliostyle-cli).

[![github pages](https://github.com/mochimochiki/hugo-theme-vivliocli/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/mochimochiki/hugo-theme-vivliocli/actions/workflows/gh-pages.yml)

## Usage

see the [Hugo theme for Vivliostyle-cli Guide (JP)](https://mochimochiki.github.io/hugo-theme-vivliocli/jp/).

## Docker

```bash
# build image
docker build -t hugo-theme-vivliocli .

# run
docker run -v <path to repository>:/hugo-theme-vivliocli --init --rm --cap-add=SYS_ADMIN hugo-theme-vivliocli pdf
```
