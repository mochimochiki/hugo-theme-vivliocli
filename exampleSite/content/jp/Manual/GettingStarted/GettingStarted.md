---
title: "Getting Started"
tags: ["tutorial"]
---

## 対象環境

本解説は Windows を対象環境としています。

## インストール

[Hugo](https://gohugo.io/)のインストールがまだであればインストールしておきます。`v0.68`以上に対応しています（フロントマターで[_buildオプションのlist](https://gohugo.io/content-management/build-options/#list)を使用しているため）。

```bat
hugo version
:: Hugo Static Site Generator vx.xx.x ...
```

本テーマでは[vivliostyle-cli](https://github.com/vivliostyle/vivliostyle-cli)を利用してPDF出力を行うため、[Node.js](https://nodejs.org/jp/)上で動作するvivliostyle-cliのインストールを実施します。

```bat
node -v
:: vX.X.X
:: note: vivliostyle-cli is not working in Node v14.0.0

npm -v
:: X.X.X

npm install -g @vivliostyle/cli
vivliostyle -v
:: cli: X.X.X
:: core: X.X.X
```

### hugo-theme-vivliocliのインストール

新しいプロジェクトを作成します。ここでは`myPDF`という名称とします。

```bat
hugo new site myPDF
cd myPDF
```

次にテーマをsubmoduleとして導入します。

```bat
git init
git submodule add https://github.com/mochimochiki/hugo-theme-vivliocli themes/hugo-theme-vivliocli
```

gitを利用しない場合は、[zip](https://github.com/mochimochiki/hugo-theme-vivliocli/archive/main.zip)をダウンロード・解凍し、`themes/hugo-theme-vivliocil`に配置します。

### exampleSiteからファイルをコピーする

テーマの中にテンプレートとして利用できるexampleSiteがあります。exampleSiteから必要なファイルをコピーします。また、デフォルトのconfig.tomlは削除しておきます。

```bat
xcopy /s themes/hugo-theme-vivliocli/exampleSite/config config/
xcopy /s themes/hugo-theme-vivliocli/exampleSite/CI CI/
rm config.toml
```

## 最初のサイトの作成

### config.tomlの編集

`config/default.toml`を開き、以下の行をコメントアウトもしくは削除します。

```toml
themesdir = "../.."
```

また、baseURLを空文字にし、サイトタイトルを編集します。

```toml
baseURL = ""
title = "My PDF Site"
```

### 表紙の作成

`content`ディレクトリ下に`jp/firstpdf`,`en/firstpdf`ディレクトリを作成します。

```bat
mkdir content/jp/firstpdf
mkdir content/en/firstpdf
```

次に`jp/firstpdf/_pdf.md`ファイルを作成して以下のように編集し、文字コードUTF-8で保存します。このファイルはPDFの表紙/前書/目次となります。`_pdf.md`の配置されたディレクトリ下がPDF出力の単位となります。

```bash
---
pdfname :
  default: 'firstpdf'
doctitle:
  default: 'My first pdf'
subtitle:
  default: 'subtitle'
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
```

{{% note %}}
詳細は[pdf configファイルの作成](../Configuration/pdfconfig.html)を参照してください。
{{% /note %}}

### 記事の作成

次に記事を作成します。`/content/jp/firstpdf`に`_index.md`を作成して以下のように編集します。

```md
---
title: "firstpdf"
weight: 10
---

`_index.md`はサイト上のセクションページになります。PDFには含まれません。
```

また`/content/jp/firstpdf`下に`first.md`, `second.md`を作成して以下のように編集して保存します。

```md
---
title: "最初の記事"
weight: 10
---

## 最初の記事

こんにちは。これは最初の記事です。
```

```md
---
title: "次の記事"
weight: 20
---

## 次の記事

こんにちは。これは次の記事です。
```

以下のコマンドでHugoのプレビューを表示してメニューの`Languages` から`Japanese`を選択し、作成した記事が表示されることを確認します。記事を編集して保存すると、LiveReloadがかかり、プレビューも更新されます。

```
hugo server --config config/default.toml
```

### ビルド

`Ctrl+C` でhugoのプレビューを終了し、以下のコマンドを実行してHugoサイトをビルドします。

```bat
hugo --config config/default.toml,config/pdf.toml
```

`--config`オプションに`config/pdf.toml`を追加で指定することで、`/config/pdf.toml`の設定をオーバーライドしています。詳細は[config.tomlの設定](../Configuration/config.html)を参照してください。

これで`/public_pdf`にHugoサイトがビルドされました。firstpdfは`/public_pdf/jp/firstpdf`に出力されているはずです。次にfirstpdfを`vivliostyle-cli`でPDF出力します。

```bat
cd ./public_pdf/jp
move /Y firstpdf/_pdf.vivlio.config.js .
move /Y firstpdf/_pdf.vivlio.cover.html .
vivliostyle build -c _pdf.vivlio.config.js
```

`_pdf.vivlio.config.js`, `_pdf.vivlio.cover.html`を移動しています。これらは`_pdf.md`から生成されるVivliostyleのConfigファイルで、ビルド時に`/public_pdf/jp`直下に置く必要があります。

`/public_pdf/jp/firstPDF.pdf`が成果物です。確認してみましょう。

### セクション番号をカスタマイズする

成果物には1.1、などのセクション番号が付与されています。このセクション番号の出力レベルは`_pdf.md`でカスタマイズすることができます。`_pdf.md`を開き、以下の箇所を変更してみましょう。

```bash
sectionNumberLevel: 2 # -> 1に変更
```

また、トップレベルの出力形式やデリミタの設定は `/config/pdf.toml` で設定できます。

```bash
  [languages.jp.params]
    sectionDelimiter = "."
    sectionTopFormat = "第%s章" # -> "Chapter %s" に変更
```

> その他のconfigパラメータについては[config.tomlの設定](../Configuration/config.html)および[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)などを参照してください。

一旦`public_pdf`を消して、今度は`build_pdf.bat`でビルドしてみます。

```bat
cd ../..
rmdir public_pdf /s /q
cd CI/windows
build_pdf.bat
```

> エラーが出力された場合、PDFを開いたままにしていないか確認してください。開いているとPDFの上書きに失敗します。

`public_pdf/jp/firstpdf.pdf` を見てみましょう。以下のことを確認します。

* `sectionNumberLevel = 1`としたことでセクション番号がトップレベルのみ表示されている
* 同時にPDFの目次にもトップレベルのみが表示されるようになっている
* `sectionTopFormat`の指定を"Chapter %s"にしたことで「第1章」ではなく「Chapter 1」となっている


## NextStep

* PDFの表紙や奥付をカスタマイズするには...
  * [config.tomlの設定](../Configuration/config.html)
  * [pdf configファイルの作成](../Configuration/pdfconfig.html)
* 複数のエディションを作るには...[エディション](../Configuration/edition.html)

