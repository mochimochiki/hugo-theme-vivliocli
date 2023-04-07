`hugo-theme-vivliocli` は、<u>**美しい組版PDF出力ができるドキュメントサイト**</u>を構築するためのHugoテーマです。このテーマでは[Vivliostyle CLI](https://github.com/vivliostyle/vivliostyle-cli) を利用することで、サイトの任意のセクションを、表紙・目次・しおり・章番号・ページ番号を含むPDFとして出力できます。

![出力PDF例](assets/2021-02-14-22-57-12.png)

## 特徴

#### 美しい組版PDF出力

`_pdf.md`ファイルが配置された任意のセクションを、<u>**表紙・目次・しおり・章番号・ページ番号を含む組版PDF**</u>として出力できます（[Vivliostyle CLI](https://github.com/vivliostyle/vivliostyle-cli)により実現）。出力形式には左右ページを使用する書籍スタイルや、全ページが同じシンプルスタイルを選択できます。PDFにはMarkdownファイルの階層とヘッダレベルに基いた章節番号が自動で割り当てられます。更に、章節番号の出力レベルや最上位レベルのフォーマット（第X章など）を指定できます。

#### セル結合を含む複雑な表の描画

`include`ショートコードを使えば、Markdown内にcsvファイルを読み込み、複雑な表を簡単に描画することができます。垂直`||`や水平`->`のセル結合が可能です。各セルではMarkdown記法を使用することができ、幅やテキスト整列などのスタイル指定も可能です。

#### 複数エディションのPDF出力

`ShowIf` / `HideIf` ショートコードを使用して、特定のエディションでのみ出力されるブロックやファイルを書くことができます。これにより、ディティールが異なる複数エディションのPDFのセットが出力することができます。

#### MermaidとMathjaxをサポート

[Mermaid](https://mermaid.js.org/)と[Mathjax](https://www.mathjax.org/)により、強力なダイアグラム・チャート・数式描画の機能を利用することができます。

## 使用方法

まずは <u>**[Getting Started](./Manual/GettingStarted.html)**</u> を参照してください。

## 動作環境

* [Hugo](https://gohugo.io/)(v0.94.0以降)
* [Vivliostyle CLI](https://github.com/vivliostyle/vivliostyle-cli)(v5.3.0以降)