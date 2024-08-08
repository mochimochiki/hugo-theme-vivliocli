---
title: _pdf.mdの設定
weight: 50
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
  default: "pdfファイル名" # PDF名称：サイト内で一意である必要があります
  # editionA: "editionAファイル名"
doctitle:
  default: "表紙タイトル" # タイトル：PDF表紙のタイトル
  # editionA: "editionA表紙タイトル"
subtitle:
  default: "表紙サブタイトル" # サブタイトル：PDF表紙のサブタイトル
  # editionA: "editionA表紙サブタイトル"
doc_number:
  default: "文書番号" # 文書番号：PDF表紙の文書番号
  # editionA: "editionA文書番号"
header: '2023/4/7' # ヘッダー1：PDF表紙右上ヘッダー1行目
header2: 'header2' # ヘッダー2：PDF表紙右上ヘッダー2行目
footer-left: 'left' # 左フッター：PDF表紙左下フッター
footer-center: 'v0.16.1' # 中央フッター：PDF表紙中央フッター
footer-right: 'right' # 右フッター：PDF表紙右下フッター
author: 'mochimo' # 著者：PDF表紙著者名
company: 'Company' # 社名：PDF表紙社名
logo: 'img/logo.png' # ロゴ：PDF表紙左上ロゴ
pagesize: 'A5' # PDFサイズ：A5 / A4 / A3 / A4 landscape / A3 landscape
book: true # true:書籍スタイル false:シンプルスタイル
marks: false # true:トンボを出力するスタイル
cover: true # 表紙を出力するか
toc: true # 目次を出力するか
sectionNumberLevel: 2 # 章節番号の出力レベル
colophon: false # 奥付を出力するか：trueの場合_colophon.mdが必要です。
outputs: # VivlioCLI用Config出力：基本的に編集しません。
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

### その他

その他の項目はエディションごとに切り替え不可です。各項目の解説は`_pdf.md`のコメントを参照してください。

## _pdfcolophon.md

奥付生成のためのテンプレートです。このファイルは`_pdf.md`のフロントマターで`colophon: true`の場合に必要になります。下記のように記述します。`_pdf.md`に記載したプロパティ情報を使う場合には、`PDFProperty`ショートコードが便利です。

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
|著者| {{%/* PDFProperty author */%}} |
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
