---
title: hugo.tomlの設定
weight: 40
---

`hugo.toml`の主な項目の説明をします。設定項目については[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)や`hugo.toml`のコメントも合わせて参照してください。

## \[params\] の設定項目

\[params\]以下に設定する設定値です。

### isPDF

PDFかどうか。trueにすると各htmlページでのmenu生成が抑制されます。PDFビルド時は`true`に設定します。

### theme_css

組版に使用するcssを指定します。`/static/css/yourtheme.css`を使用する場合`/css/yourtheme.css`と、指定します。デフォルトではテーマの`static/css`下にある`style-main.css`が参照されています。

### showIfs

`ShowIf`/`HideIf`ショートコード・フロントマターで表示/非表示切り替える条件の一覧。

```
showIfs = ["edition1", "edition2"]
```

詳しくは [エディション](./edition.html) を参照してください。

### legacy_menu

メニュー（左側のコンテンツツリー）を各ページに直接埋め込むかどうか。既定は`false`です。

`false`（既定）の場合、メニューは`js/menu-tree-<言語>.js`という1つのファイルに書き出され、ページを開いたときにJavaScriptが差し込みます。全ページに同じメニューを埋め込むと、ページ数が増えるほどビルド時間も出力量も膨らみます（2500ページのサイトでは1ページ336KBのうち328KBがメニューでした）。1ファイルにまとめることで、この繰り返しがなくなります。

`true`にすると従来どおり全ページに直接埋め込みます。JavaScriptを切った状態でメニューを使う必要がある場合に指定してください。

ローカルのファイル（`file:`）としてhtmlを開く場合も、既定の`false`のままでメニューは表示されます。

### sectionNumberLevel

章節番号を付加するレベルを指定します。0の場合章番号の付加は行われません。

### sectionDelimiter

`sectionNumberLevel >= 2` の場合の章・節番号のデリミタを指定します。設定されていない場合`.`がデリミタとなります。

### sectionTopFormat

トップレベルのセクションの番号をフォーマットすることができます。フォーマット中に`%s`を1つ指定してください。その位置にセクション番号が挿入されます。言語ごとに変更することも可能です。

例)`sectionTopFormat = "Chapter %s"`

```
[languages.ja.params]
sectionTopFormat = "第%s章"
[languages.en.params]
sectionTopFormat = "Chapter %s"
```