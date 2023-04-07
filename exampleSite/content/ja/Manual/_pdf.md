---
pdfname :
  default: 'Hugo_Theme_Vivliocli_Manual'
doctitle:
  default: 'Hugo-theme-vivliocli Manual'
subtitle:
  default: 'Hugoサイトを美しくPDF出力'
doc_number:
  default: 'doc-number'
header:
  default: 'header'
header2:
  default: 'header2'
footer-left:
  default: 'left'
footer-center:
  default: 'center'
footer-right:
  default: 'right'
author: 'auther'
company: 'Company'
logo: 'img/logo.png'
pagesize: 'A4' # A4 / A3 / A4 landscape / A3 landscape
book: true
cover: true # whether to output the cover page or not.
toc: true # whether to output toc or not. (if cover: false, always toc is not output)
sectionNumberLevel: 2 # override config.toml settings.
colophon: false # whether to output colophon page or not.
outputs:
- vivlio_cover
- vivlio_config
---

# はじめに

{{< include introduction_ja.md >}}