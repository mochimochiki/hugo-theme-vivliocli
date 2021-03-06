---
title: "Getting Started"
tags: ["tutorial"]
---

## 対象環境

本解説は Windows 10 を対象環境としています。

## インストール

[Hugo](https://gohugo.io/)のインストールがまだであればインストールしておきます。`v0.68`以上に対応しています（フロントマターで[_buildオプションのlist](https://gohugo.io/content-management/build-options/#list)を使用しているため）。

```bat
hugo version
:: Hugo Static Site Generator v0.80.0 ...
```

本テーマでは[vivliostyle-cli](https://github.com/vivliostyle/vivliostyle-cli)を利用してPDF出力を行うため、[Node.js](https://nodejs.org/ja/)およびvivliostyle-cliのインストールを実施します。以下はchocotaleyを用いた導入例です。

```bat
choco install -y nodejs

node -v
:: v15.9.0
:: note: vivliostyle-cli is not working in Node v14.0.0

npm -v
:: 7.5.3

npm install -g @vivliostyle/cli
vivliostyle -v
:: cli: 3.0.3
:: core: 2.4.2
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

gitを利用しない場合は、[zip](https://github.com/mochimochiki/hugo-theme-vivliocli/archive/master.zip)をダウンロード・解凍し、`themes\hugo-theme-vivliocil`に配置します。

### exampleSiteからファイルをコピーする

テーマの中にテンプレートとして利用できるexampleSiteがあります。exampleSiteから必要なファイルをコピーします。また、デフォルトのconfig.tomlは削除しておきます。

```bat
xcopy /s themes\hugo-theme-vivliocli\exampleSite\config config\
xcopy /s themes\hugo-theme-vivliocli\exampleSite\CI CI\
rm config.toml
```

## 最初のサイトの作成

### config.tomlの編集

`config\_default\config.toml`を開き、以下の行をコメントアウトもしくは削除します。

```toml
themesdir = "../.."
```

その他のconfigパラメータについては[ヘルプの構成](../Configuration/config.html)および[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)などを参照してください。

### 表紙の作成

`content`ディレクトリ下に`jp`,`en`ディレクトリを作成します。

```bat
mkdir content\jp
mkdir content\en
```

作成した`jp`および`en`下に`_pdfcover.md`ファイルを作成して以下のように編集し、文字コードUTF-8で保存します。このファイルはサイト上ではサイトトップの`index.html`となり、PDFでは表紙/前書/目次となります。

```md
---
type: "vivlio_cover"
url: "myPDF.cover.html"
_build: { list: false }

title: "myPDF"
author: "my name"
toc: true
colophon: false
---

# はじめに

`hugo-theme-vivliocil`を使ってPDF出力。

```

```md
---
type: "vivlio_cover"
url: "myPDF.cover.html"
_build: { list: false }

title: "myPDF"
author: "my name"
toc: true
colophon: false
---

# Introduction

PDF output using `hugo-theme-vivliocil`.

```

> colophon: true とすると奥付ページも生成されます。`_pdfcolophon.md`も必要になります。`exampleSite\content\jp\_pdfcolophon.md`などを参考にしてください。

### configファイルの作成

`\content\jp`および`\content\en`下に`_pdfconfig.md`ファイルを作成して以下のように編集し、文字コードUTF-8で保存します。このファイルはHugoビルド後に`vivliostyle-cli`のconfigファイルとなります。原稿ではないため、フロントマターのみで構成されます。なお、`toc`と`colophon`については、`_pdfconfig.md`と`_pdfcover.md`で一致させておきます。

```md
---
type: "vivlio_config"
url: "myPDF.js"
_build: { list: false }

title   : "myPDF"
output : "myPDF_JP.pdf" # or myPDF_EN.pdf
pagesize: "A4"
toc: true
colophon: false
---
```


### 記事の作成

次に記事を作成します。`\content\jp\Chapter1`ディレクトリを作成し、`_index.md`を作成して以下のように編集します（以下、`\content\en`下にも適宜同様にします）。

```md
---
title: Sample Chapter1
role: doc-chapter
weight: 10
---

サンプルチャプター1です。 role: doc-chapter とすることでチャプターを作ることができます。チャプターのindexページの後にも改ページが入るため、短いと少し記事が寂しく見えることになります。
```

{{% note %}}
ディレクトリ名やファイル名はASCII文字で記述してください。日本語を使用すると`vivliostyle-cli`ビルドに失敗します。（`vivliostyle-cli v3.0.3`時点）
{{% /note %}}

また`\content\jp\Chapter1`下に`second.md`, `third.md`を作成して以下のように編集して保存します。

```md
---
title: "2番目の記事"
weight: 10
---

## 2番目の記事

こんにちは。これは2番目の記事です。
```

```md
---
title: "3番目の記事"
weight: 20
---

## 3番目の記事

こんにちは。これは3番目の記事です。
```

以下のコマンドでHugoのプレビューを表示し、記事が表示されることを確認します。記事を編集して保存すると、LiveReloadがかかり、プレビューも更新されます。

```
hugo server
```

### ビルド

`Ctrl+C` でhugoのプレビューを終了し、以下のコマンドを実行してHugoサイトをビルドします。

```bat
hugo -e pdf_sample
```

`-e`オプションに`pdf_sample`をつけることで、`/config/pdf_sample/config.toml`をオーバーライドしています。これは主に`isPDF= true`とするためです。詳細は[config.tomlの設定](../Configuration/config.html)を参照してください。

これで`/public_pdf_sample`にHugoサイトがビルドされました。次にこのサイトを`vivliostyle-cli`でPDF出力します。

```bat
vivliostyle build -c .\public_pdf_sample\jp\myPDF.js
```

`vivliostyle-cli`のconfigファイルとして`myPDF.js`を指定しています。このファイルは`_pdfconfig.md`から生成されたものです。

`\public_pdf_sample\jp\myPDF_JP.pdf`が成果物です。確認してみましょう。