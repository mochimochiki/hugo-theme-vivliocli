---
title: "Getting Started"
weight: 10
tags: ["tutorial"]
---

## Target Environment

This guide is for Windows.

## Installation

### Installing Hugo

Install [Hugo](https://gohugo.io/) by following the instructions on the [official website](https://gohugo.io/installation/windows/). After installing, confirm that the version of Hugo is displayed with the following command:

```bat
hugo version
:: Hugo Static Site Generator vx.xx.x ...
```

### Installing Node.js and Vivliostyle

Install the LTS version of [Node.js](https://nodejs.org/en/). After installing, confirm the versions of Node.js and npm are displayed with the following command:

```bat
node -v
:: vX.X.X
:: note: vivliostyle-cli is not working in Node v14.0.0

npm -v
:: X.X.X
```

Next, install [vivliostyle-cli](https://github.com/vivliostyle/vivliostyle-cli) with npm. After installing, confirm the version of Vivliostyle with the following command:

```bat
npm install -g @vivliostyle/cli
vivliostyle -v
:: cli: X.X.X
:: core: X.X.X
```

### Creating a Site and Installing a Theme

Create a new site with Hugo. In this example, the site name is `myPDF`.

```bat
hugo new site myPDF
cd myPDF
```

Download and extract the latest `Source code (zip)` from the [releases page](https://github.com/mochimochiki/hugo-theme-vivliocli/releases), and place it in `/themes/hugo-theme-vivliocli`.

{{% note %}}
If using Git, it is possible to install it as a submodule.

```bat
git init
git submodule add https://github.com/mochimochiki/hugo-theme-vivliocli themes/hugo-theme-vivliocli
```
{{% /note %}}

### Copying Files from exampleSite

The theme includes an exampleSite that can be used as a template. Copy the necessary files from the exampleSite. Also, delete the default `config.toml`.

```bat
xcopy /s themes\hugo-theme-vivliocli\exampleSite\config config\
xcopy /s themes\hugo-theme-vivliocli\exampleSite\CI CI\
del config.toml
```

## Creating the First Site

### Editing config.toml

Open `/config/default.toml` and comment out or delete the following line:

```toml
themesdir = "../.."
```

Also, edit `baseURL` and `title`.

```toml
baseURL = ""
title = "My PDF Site"
```

### Creating a Cover

Create `ja/firstpdf` and `en/firstpdf` directories under `content`.

```bat
mkdir content\ja\firstpdf
mkdir content\en\firstpdf
```

Next, create a `_pdf.md` file under `ja/firstpdf` and edit it as follows. Save it in UTF-8 format. This file will be the cover/preface/table of contents of the PDF. The directory where `_pdf.md` is located will be the unit of PDF output.

```bash
---
pdfname: 'firstpdf'
doctitle: 'My first pdf'
subtitle: 'subtitle'
header: '2023/1/1'
author: 'auther'
pagesize: 'letter'
book: true
cover: true
toc: true
sectionNumberLevel: 2
colophon: false
outputs:
- vivlio_cover
- vivlio_config
---
```

{{% note %}}
For details, please refer to [_pdf.md](./pdfconfig.html).
{{% /note %}}

### Creating articles

Next, create articles. Create `_index.md` in `/content/en/firstpdf` and edit it as follows:

```md
---
title: "firstpdf"
weight: 10
---

`_index.md` will become the section page on the site and will not be included in the PDF.
```

Also, create `first.md` and `second.md` in `/content/en/firstpdf` and edit and save them as follows:

```md
---
title: "First article"
weight: 10
---

## First article

Hello. This is the first article.
```

```md
---
title: "Next article"
weight: 20
---

## Next article

Hello. This is the next article.
```

Confirm that the created articles are displayed by selecting `English` from the `Languages` menu in the Hugo preview displayed with the following command. When you edit and save an article, LiveReload takes effect and the preview is updated.

```bat
hugo server --config config\default.toml
```

### Building

Exit the Hugo preview with `Ctrl+C` and run the following command to build the Hugo site:

```bat
cd CI\windows
build_pdf.bat
```

> If an error is output, check if the PDF is still open. Overwriting the PDF will fail if it is still open.

The result is `/public_default/en/firstPDF.pdf`. Let's check it.

### Customizing section numbers

The output level of chapter numbers such as `1.1` can be customized in `_pdf.md`. Open `_pdf.md` and change the following section:

```bash
sectionNumberLevel: 2 # -> change to 1
```

In addition, the top-level output format and delimiter can be set in `/config/default.toml`.

```bash
  [languages.en.params]
    sectionDelimiter = "."
    sectionTopFormat = "Chapter %s" # -> change to "Lesson %s"
```

> For other config parameters, please refer to the [config.toml](./config.html) and the [Hugo documentation](https://gohugo.io/getting-started/configuration/), among others.

Check the following in `/public_default/en/firstpdf.pdf`:

* With `sectionNumberLevel = 1`, only the top-level section number is displayed
* At the same time, only the top-level is displayed in the table of contents of the PDF
* By specifying `sectionTopFormat` as "Lesson %s", it is displayed as "Lesson 1" instead of "Chapter 1"

## NextStep

* Check the Markdown and Shortcodes that can be used in the manuscript
  * [Markdown and Shortcodes](./MarkdownShowcase.html)
* Customize the cover and colophon of the PDF
  * [config.toml](./config.html)
  * [_pdf.md](./pdfconfig.html)
* Create multiple editions
  * [Editions](./edition.html)