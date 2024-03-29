---
title: "Getting Started"
weight: 10
tags: ["tutorial"]
---

## 対象環境

本解説は Windows を対象環境としています。

## インストール

### Hugoのインストール

[Hugo](https://gohugo.io/)を[公式ページのインストール手順](https://gohugo.io/installation/windows/)に従いインストールします。インストールが完了したら、以下のコマンドでHugoのバージョンが表示されることを確認します。

```bat
hugo version
:: Hugo Static Site Generator vx.xx.x ...
```

### Node.jsとVivliostyleのインストール

[Node.js](https://nodejs.org/ja/)のLTS版をインストールします。インストールが完了したら、以下のコマンドでNode.jsおよびnpmのバージョンが表示されることを確認します。

```bat
node -v
:: vX.X.X
:: note: vivliostyle-cli is not working in Node v14.0.0

npm -v
:: X.X.X
```

次にnpmで[vivliostyle-cli](https://github.com/vivliostyle/vivliostyle-cli)をインストールします。インストールが完了したら、Vivliostyleのバージョンが表示されることを確認します。

```bat
npm install -g @vivliostyle/cli
vivliostyle -v
:: cli: X.X.X
:: core: X.X.X
```

### サイト作成とテーマのインストール

Hugoで新しいサイトを作成します。ここでは`myPDF`という名称とします。

```bat
hugo new site myPDF
cd myPDF
```

[releases](https://github.com/mochimochiki/hugo-theme-vivliocli/releases)から最新の`Source code (zip)`をダウンロード・解凍し、`/themes/hugo-theme-vivliocli`に配置します。

{{% note %}}
gitを利用する場合、submoduleとして導入することもできます。

```bat
git init
git submodule add https://github.com/mochimochiki/hugo-theme-vivliocli themes/hugo-theme-vivliocli
```
{{% /note %}}

### exampleSiteからファイルをコピーする

テーマの中にテンプレートとして利用できるexampleSiteがあります。exampleSiteから必要なファイルをコピーします。また、デフォルトのconfig.tomlは削除しておきます。

```bat
xcopy /s themes\hugo-theme-vivliocli\exampleSite\config config\
xcopy /s themes\hugo-theme-vivliocli\exampleSite\CI CI\
del config.toml
```

## 最初のサイトの作成

### config.tomlの編集

`/config/default.toml`を開き、以下の行をコメントアウトもしくは削除します。

```toml
themesdir = "../.."
```

また、`baseURL`, `title` を編集します。

```toml
baseURL = ""
title = "My PDF Site"
```

### 表紙の作成

`content`下に`ja/firstpdf`,`en/firstpdf`ディレクトリを作成します。

```bat
mkdir content\ja\firstpdf
mkdir content\en\firstpdf
```

次に`ja/firstpdf/_pdf.md`ファイルを作成して以下のように編集し、文字コードUTF-8で保存します。このファイルはPDFの表紙/前書/目次となります。`_pdf.md`を配置したディレクトリ下がPDF出力の単位となります。

```bash
---
pdfname: 'firstpdf'
doctitle: 'My first pdf'
subtitle: 'subtitle'
header: '2023/1/1'
author: 'auther'
pagesize: 'A4'
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
詳細は[_pdf.mdの設定](./pdfconfig.html)を参照してください。
{{% /note %}}

### 記事の作成

次に記事を作成します。`/content/ja/firstpdf`に`_index.md`を作成して以下のように編集します。

```md
---
title: "firstpdf"
weight: 10
---

`_index.md`はサイト上のセクションページになります。PDFには含まれません。
```

また`/content/ja/firstpdf`下に`first.md`, `second.md`を作成して以下のように編集して保存します。

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

```bat
hugo server --config config\default.toml
```

### ビルド

`Ctrl+C` でhugoのプレビューを終了し、以下のコマンドを実行してHugoサイトをビルドします。

```bat
cd CI\windows
build_pdf.bat
```

> エラーが出力された場合、PDFを開いたままにしていないか確認してください。開いているとPDFの上書きに失敗します。

`/public_default/ja/firstPDF.pdf`が成果物です。確認してみましょう。

### 章節番号をカスタマイズする

`1.1`などの章節番号の出力レベルは`_pdf.md`でカスタマイズすることができます。`_pdf.md`を開き、以下の箇所を変更してみましょう。

```bash
sectionNumberLevel: 2 # -> 1に変更
```

また、トップレベルの出力形式やデリミタの設定は `/config/default.toml` で設定できます。

```bash
  [languages.ja.params]
    sectionDelimiter = "."
    sectionTopFormat = "第%s章" # -> "Chapter %s" に変更
```

> その他のconfigパラメータについては[config.tomlの設定](./config.html)および[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)などを参照してください。

`/public_default/ja/firstpdf.pdf` で以下のことを確認します。

* `sectionNumberLevel = 1`としたことでセクション番号がトップレベルのみ表示されている
* 同時にPDFの目次にもトップレベルのみが表示されるようになっている
* `sectionTopFormat`の指定を"Chapter %s"にしたことで「第1章」ではなく「Chapter 1」となっている

## NextStep

* 原稿で利用できるMarkdownやShortcodesを確認する
  * [MarkdownとShortcodes](./MarkdownShowcase.html)
* PDFの表紙や奥付をカスタマイズする
  * [config.tomlの設定](./config.html)
  * [_pdf.mdの設定](./pdfconfig.html)
* 複数のエディションを作る
  * [エディション](./edition.html)

