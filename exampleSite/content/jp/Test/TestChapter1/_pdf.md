---
pdfname : 
  default: 'Test'
doctitle:
  default: 'Test'
subtitle:
  default: 'Test'
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
outputs:
- vivlio_cover
- vivlio_config
---

{{< include introduction_jp.md >}}