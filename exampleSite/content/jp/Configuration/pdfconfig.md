---
title: pdf configファイルの作成
weight: 20
---

本テーマではvivliostyleで利用される構成ファイル/カバーページ（目次）/奥付を生成するために、以下の3つのconfigファイルを利用しています。

* _pdfconfig.md
* _pdfcover.md
* _pdfcolophon.md

サイト内のPDF生成したいレベルのディレクトリにこの3ファイルを配置することで、PDF化するための構成ファイルを生成できます（サイトルート以外も可）。

## _pdfconfig.md

`_pdfconfig.md`はvivliostyleの.js configファイルのテンプレートです。以下のように記述します。

```md
---
type: "vivlio_config"
url: "example.js" # <name>.js
_build: { list: false }

title   : "Hugo-theme-vivliocli ガイド" # Documents Title
output : "Hugo-theme-vivliocli ガイド.pdf" # Output file
pagesize: "A4" # PDF Page size
toc: true
colophon: true
---
```

### type

テンプレートタイプです。必ず`vivlio_config`とします。

### url

configファイルの名称（URL）。`<name>.js`形式で記述します。`<name>`は任意の名前です。PDF構成ファイル3つで同一の名前を使います。

### _build

このファイルをリストページから除外するために必要な記述です。必ずこのまま記載します。

### title

ドキュメントタイトルです。vivliostyle.config.jsのtitle項目になります

### output

出力ファイル名です。

### pagesize

ページサイズです。vivliostyle.config.jsのpagesize項目になります。A4/A5など。

### toc

目次とPDFしおりを生成するかどうか。trueで生成します。この項目の設定は`_pdfcover.md`と一致させておく必要があります。

### colophon

奥付を生成するかどうか。trueで生成します。trueの場合に後述の_pdfcolophon.mdが必要になります。この項目の設定は`_pdfcover.md`と一致させておく必要があります。


## _pdfcover.md

表紙のhtml生成のためのテンプレートです。表紙には目次も含みます。また、「はじめに」など、目次前に文章を記載する場合はこのファイルに記述します。

```md
---
type: "vivlio_cover"
url: "example.cover.html"               # <name>.cover.html
_build: { list: false }

title: "Hugo-theme-vivliocli ガイド"    # Documents Cover Title
subtitle: "Hugoサイトを美しくPDF出力"   # Documents Cover Subtitle
doc_number: "Ver.0.1.0"                 # Document number
author: "mochimo"                       # Document author
company: "Company name"                 # Document company name
toc: true                               # true: output Table of Contents & PDF Bookmarks
colophon: true                          # true: include colophon (need to make _pdfcolophon.md)
---

# はじめに

(ここに目次前に表示したい文章を記述)
```

### type

テンプレートタイプです。必ず`vivlio_cover`とします。

### url

coverファイルの名称（URL）。`<name>.cover.html`形式で記述します。`<name>`は任意の名前です。PDF構成ファイル3つで同一の名前を使います。

### _build

このファイルをリストページから除外するために必要な記述です。必ずこのまま記載します。

### title

ドキュメント表紙のタイトルです。必須です。

### subtitle

ドキュメント表紙のサブタイトルです。省略可能です。

### doc_number/author/companyname

文書/バージョン番号, 筆者, 社名 の記載を想定しているドキュメント表紙のフィールドです。

### toc

目次とPDFしおりを生成するかどうか。trueで生成します。

### colophon

奥付を生成するかどうか。trueで生成します。trueの場合に後述の_pdfcolophon.mdが必要になります。

## _pdfcolophon.md

奥付生成のためのテンプレートです。このファイルは_pdfcover.mdのフロントマターで`colophon: true`の場合に必要になります。下記のように記述します。

```md
---
type: "vivlio_colophon"
url: "example.colophon.html"  # <name>.colophon.html
_build: { list: false }
title: "奥付" # Documents colophon Title
---

## 奥付のタイトル

(奥付の本文)

<div role="doc-colophon">

## 本のタイトル

xxxx年x月x日　初版発行

| | |
| -- | --  |
|著者| 著者名 |
|発行者| 発行者名 |
|印刷・製本| 印刷社名 |

© コピーライト記述

</div>
```

### type

テンプレートタイプです。必ず`vivlio_colophon`とします。

### url

coverファイルの名称（URL）。`<name>.colophon.html`形式で記述します。`<name>`は任意の名前です。PDF構成ファイル3つで同一の名前を使います。

### _build

このファイルをリストページから除外するために必要な記述です。必ずこのまま記載します。

### title

奥付のタイトルです。本文には表示されません。ヘッダーにタイトルを表示している場合、このタイトルが表示されます。

### 本文

奥付ページの本文欄です。通常のファイルと同様です。

### `<div role="doc-colophon">`タグ内

本タグ内は下揃えで描画されます。本のタイトル及び出版情報の表を記述することを想定しています。