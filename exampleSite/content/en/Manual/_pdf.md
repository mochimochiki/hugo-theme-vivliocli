---
pdfname : 'UserGuide' # PDF name. Be unique within the site
doctitle: 'Hugo-theme-vivliocli' # document title
subtitle: 'User Guide' # Sub title
#doc_number: 'doc-number' # document number
header: 'April 26, 2023'
#header2: 'header2'
#footer-left: 'left'
footer-center: 'v0.17.0'
#footer-right: 'right'
author: 'mochimo'
#company: 'Company'
#logo: 'img/logo.png'
pagesize: 'letter' # pdf size : letter / A5 / A4 / A3 / letter landscape / A4  landscape / A3 landscape
book: true # true: book style / false: simple style
marks: false # true: use marks style
cover: true # true: output pdf cover page
toc: true # true: output table of contents
sectionNumberLevel: 2 # Output level of section number
colophon: true # Whether to output the colophon page: If true, _pdfcolophon.md is required.
outputs: # Config output for VivlioCLI: Basically no editing.
- vivlio_cover
- vivlio_config
---
