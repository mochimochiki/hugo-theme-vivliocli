---
title: "_pdf.md"
weight: 50
---

In this theme, the following config files are used to generate the configuration file / cover page (table of contents) / colophon used in vivliostyle:

* _pdf.md
* _pdfcolophon.md

By placing these two files in the directory where you want to generate the PDF on your site, you can generate the configuration file for PDF generation (not just in the site root).

## _pdf.md

`_pdf.md` is the config file and cover page template for vivliostyle. It should be described as follows:

```toml
---
pdfname:
  default: "pdf file name" # PDF name: must be unique within the site
  # editionA: "editionA file name"
doctitle:
  default: "Cover title" # Title: PDF cover title
  # editionA: "editionA cover title"
subtitle:
  default: "Cover subtitle" # Subtitle: PDF cover subtitle
  # editionA: "editionA cover subtitle"
doc_number:
  default: "Document number" # Document number: PDF cover document number
  # editionA: "editionA document number"
header: '2023/4/7' # Header 1: First line of PDF cover header on the upper right
header2: 'header2' # Header 2: Second line of PDF cover header on the upper right
footer-left: 'left' # Left footer: PDF cover left bottom footer
footer-center: 'v0.16.1' # Center footer: PDF cover center footer
footer-right: 'right' # Right footer: PDF cover right bottom footer
author: 'mochimo' # Author: PDF cover author name
company: 'Company' # Company name: PDF cover company name
logo: 'img/logo.png' # Logo: PDF cover upper left logo
pagesize: 'A5' # PDF size: letter / A5 / A4 / A3 / letter landscape / A4 landscape / A3 landscape
book: true # true: book style false: simple style
marks: false # true: style that outputs crop marks
cover: true # Whether or not to output the cover
toc: true # Whether or not to output the table of contents
sectionNumberLevel: 2 # Output level of chapter/section numbers
colophon: false # Whether or not to output the colophon: _colophon.md is required if true.
outputs: # Config output for VivlioCLI: Basically do not edit.
- vivlio_cover
- vivlio_config
---

# Introduction

(Description of what to display before the table of contents goes here)
```

Settings specified as `default` or `editionA` in list format can be set for each edition by specifying the edition name specified in `showIfs` in `config.toml`.

### pdfname

PDF file name. Required. Make sure it is a unique name that does not conflict within `/content/<language>`.

### doctitle

The title of the cover. Required. Can be switched for each edition.

### subtitle

Subtitle displayed on the cover. Can be switched for each edition.

### doc_number

The document number displayed on the cover. Can be switched for each edition.

### Other

Other items cannot be switched for each edition. Refer to the comments in `_pdf.md` for explanations of each item.

## _pdfcolophon.md

This is the template for colophon generation. This file is necessary when `colophon:true` is specified in the front matter of `_pdf.md`.

```toml
---
title: "Colophon"
outputs:
- vivlio_colophon
---

## Title of Colophon

(Text for the colophon)

<div role="doc-colophon">

## Title of Book

First edition published on xxxx-xx-xx

| | |
| -- | --  |
|Author| Author's name |
|Publisher| Publisher's name |
|Printing and Binding| Printing company's name |

© Copyright Description

</div>
```

### title

The title of the colophon, which is not displayed in the body text. If the header displays a title, this title will be used. This field is required.

### outputs

This is a necessary description for generating a colophon file. Do not change it. This field is required.

### Body Text

The body text of the colophon page, which is the same as a regular file.

### `<div role="doc-colophon">` Tag

The content inside this tag is displayed justified to the bottom. It is intended to describe the book's title and publication information in a table format.