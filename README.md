# hugo-theme-vivliocli

hugo-theme-vivliocli is a theme for building documentation sites that can output in PDF format. Any section created by this theme can be output as a typeset PDF using [Vivliostyle CLI](https://github.com/vivliostyle/vivliostyle-cli).Hugo sites built with this theme will output a config file for Vivliostyle CLI along with the normal output.

[![github pages](https://github.com/mochimochiki/hugo-theme-vivliocli/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/mochimochiki/hugo-theme-vivliocli/actions/workflows/gh-pages.yml)

## Features

* PDF output that can available for any section where `_pdf.md` is placed
  * Output PDF with table of contents
  * Output of cover page
  * Book style (with left and right pages) / Simple style (all pages identical) can be selected
  * Chapter numbers assigned throughout the web site section and PDF
  * The level of output chapter numbers customization
  * Top level chapter style customization
* `include` shortcode that can include rich csv with markdown in cells
  * Markdown and shortcodes written in cells will be rendered
  * Vertical `||` / horizontal `->` merging possible
  * Width specification of each column
* `ShowIf` / `HideIf` shortcode to allow multiple editions of PDF output with different details
  * Blocks and files can be written to output only in specific edition

## Prerequisites

* Install [Hugo](https://github.com/gohugoio/hugo) (v0.94.0 or later).
* Install [Vivliostyle CLI](https://github.com/vivliostyle/vivliostyle-cli) (v5.3.0 or later).

## Usage

```bash
hugo new site MySite
cd MySite
git init
git submodule add https://github.com/mochimochiki/hugo-theme-vivliocli themes/hugo-theme-vivliocli
```

see the [Hugo theme for Vivliostyle-cli Guide (JP)](https://mochimochiki.github.io/hugo-theme-vivliocli/jp/) for details.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](https://github.com/mochimochiki/hugo-theme-vivliocli/blob/main/LICENSE) file for details.
