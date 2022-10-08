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

gitを利用しない場合は、[zip](https://github.com/mochimochiki/hugo-theme-vivliocli/archive/main.zip)をダウンロード・解凍し、`themes\hugo-theme-vivliocil`に配置します。

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

### 表紙の作成

`content`ディレクトリ下に`jp\firstpdf`,`en\firstpdf`ディレクトリを作成します。

```bat
mkdir content\jp\firstpdf
mkdir content\en\firstpdf
```

次に`jp\firstpdf\_pdf.md`ファイルを作成して以下のように編集し、文字コードUTF-8で保存します。このファイルはPDFの表紙/前書/目次となります。PDF出力したいディレクトリに`_pdf.md`を置く、と覚えておきましょう。

```bash
---
pdfname :
  default: "firstpdf" # pdfファイル名。他とかぶらないようにする。
doctitle:
  default: "タイトル"
subtitle:
  default: "サブタイトル"
pagesize: "A4"
colophon: false
outputs:
- vivlio_cover
- vivlio_config
---
```

{{% note %}}
colophon: true とすると奥付ページも生成されます。`_pdfcolophon.md`も必要になります。
参考：[pdf configファイルの作成](../Configuration/pdfconfig.html)
{{% /note %}}

### 記事の作成

次に記事を作成します。`\content\jp\firstpdf`に`_index.md`を作成して以下のように編集します。

```md
---
title: "firstpdf"
weight: 10
---

`_index.md`はサイト上のセクションページになります。PDFには含まれません。
```

また`\content\jp\firstpdf`下に`first.md`, `second.md`を作成して以下のように編集して保存します。

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

以下のコマンドでHugoのプレビューを表示し、記事が表示されることを確認します。記事を編集して保存すると、LiveReloadがかかり、プレビューも更新されます。

```
hugo server
```

### ビルド

`Ctrl+C` でhugoのプレビューを終了し、以下のコマンドを実行してHugoサイトをビルドします。

```bat
hugo -e pdf
```

`-e`オプションに`pdf`をつけることで、`/config/pdf/config.toml`の設定を適用しています。詳細は[config.tomlの設定](../Configuration/config.html)を参照してください。

これで`/public_pdf`にHugoサイトがビルドされました。firstpdfは`/public_pdf/jp/firstpdf`に出力されているはずです。次にfirstpdfを`vivliostyle-cli`でPDF出力します。

```bat
cd .\public_pdf\jp
move /Y firstpdf\_pdf.vivlio.config.js .
move /Y firstpdf\_pdf.vivlio.cover.html .
vivliostyle build -c _pdf.vivlio.config.js
```

`_pdf.vivlio.config.js`, `_pdf.vivlio.cover.html`を移動しています。これらは`_pdf.md`から生成されたもので、ビルド時に`.\public_pdf\jp`直下に置く必要があるため、あらかじめ移動してからconfigファイルを指定してビルドしています。

`\public_pdf\jp\firstPDF.pdf`が成果物です。確認してみましょう。

### セクション番号をカスタマイズする

成果物には第1章、1.1、などのセクション番号が付与されています。これは`config.toml`でカスタマイズすることができます。`\config\pdf\config.toml`を開き、以下の箇所を変更してみましょう。

```bash
sectionNumberLevel = 3 # -> 1に変更
...
  [languages.jp.params]
    sectionTopFormat = "第%s章" # -> この行を削除もしくはコメントアウト
```

> その他のconfigパラメータについては[ヘルプの構成](../Configuration/config.html)および[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)などを参照してください。

一旦`public_pdf`を消して、今度は`build.bat`でビルドしてみます。

```bat
cd ..\..
rmdir public_pdf /s /q
.\CI\build.bat
```

> もしエラーが出力された場合、PDFを開きっぱなしにしていないか確認してください。開いているとPDFの上書きに失敗します。

`public_pdf\jp\firstpdf.pdf` を見てみましょう。以下のことを確認します。

* `sectionNumberLevel = 1`としたことでセクション番号がトップレベルのみ表示されている
* 同時にPDFの目次にもトップレベルのみが表示されるようになっている
* `sectionTopFormat`の指定をやめたことで「第1章」ではなく単に「1」となっている

ビルドには`build.bat`を利用すれば、config/coverファイルのコピーを手動でやる必要がありません。

## NextStep

* PDFの表紙や奥付をカスタマイズするには...[config.tomlの設定](../Configuration/config.html)
* 複数のエディションを作るには...[エディション](../Configuration/edition.html)

