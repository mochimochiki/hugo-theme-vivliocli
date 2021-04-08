---
title: pdf configファイルの作成
weight: 20
---

本テーマではvivliostyleで利用される構成ファイル/カバーページ（目次）/奥付を生成するために、以下のconfigファイルを利用しています。

* _pdf.md
* _pdfcolophon.md

サイト内のPDF生成したいレベルのディレクトリにこの2ファイルを配置することで、PDF化するための構成ファイルを生成できます（サイトルート以外も可）。

## _pdf.md

`_pdf.md`はvivliostyleのconfigファイルと表紙のテンプレートです。以下のように記述します。

```toml
---
pdfname :
  default: "pdfファイル名"
  # editionA: "editionAファイル名"
doctitle:
  default: "表紙タイトル"
  # editionA: "editionA表紙タイトル"
subtitle:
  default: "表紙サブタイトル"
  # editionA: "editionA表紙サブタイトル"
doc_number:
  default: "文書番号"
  # editionA: "editionA文書番号"
author: "著者"
company: "会社"
pagesize: "A4"
colophon: true
outputs:
- vivlio_cover
- vivlio_config
---

# はじめに

(ここに目次前に表示したい文章を記述)
```

`default`や`editionA`とリスト表記している設定値はconfig.tomlの`showIfs`で指定したエディション名を指定することでそのエディション用に設定できます。

### pdfname

PDFファイル名です。必須です。`/content/<language>`以下では競合しないよう一意の名称となるようにします。

### doctitle

表紙のタイトルです。必須です。エディションごとに切替可能です。

### subtitle

表紙に表示するサブタイトルです。エディションごとに切替可能です。

### doc_number

表紙に表示する文書番号です。エディションごとに切替可能です。

### author

表紙に表示する著者です。

### company

表紙に表示する会社名です。

### pagesize

ページサイズです。必須です。vivliostyle.config.jsのpagesize項目になります。A4/A5など。

### colophon

奥付を生成するかどうか。trueで生成します。trueの場合に後述の_pdfcolophon.mdが必要になります。

### outputs

configファイルを生成するために必要な記述です。変更せずこのまま記載します。必須です。

## _pdfcolophon.md

奥付生成のためのテンプレートです。このファイルは`_pdf.md`のフロントマターで`colophon: true`の場合に必要になります。下記のように記述します。

```toml
---
title: "奥付"
outputs:
- vivlio_colophon
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

### title

奥付のタイトルです。本文には表示されません。ヘッダーにタイトルを表示している場合、このタイトルが表示されます。必須です。

### outputs

奥付用ファイルを生成するために必要な記述です。変更せずこのまま記載します。必須です。


### 本文

奥付ページの本文欄です。通常のファイルと同様です。

### `<div role="doc-colophon">`タグ内

本タグ内は下揃えで描画されます。本のタイトル及び出版情報の表を記述することを想定しています。
