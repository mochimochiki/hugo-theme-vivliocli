---
pdfname : 
  default: 'Guide'
doctitle:
  default: 'Hugo-theme-vivliocli Guide'
subtitle:
  default: 'Hugoサイトを<br>美しくPDF出力'
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
pagestyle: 'book' # book / simple
cover: true # whether to output the cover page or not.
toc: true # whether to output toc or not. (if cover: false, always toc is not output)
colophon: true # whether to output colophon page or not.
outputs:
- vivlio_cover
- vivlio_config
---

{{< include introduction_jp.md >}}