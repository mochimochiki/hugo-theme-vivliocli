---
title: config.tomlの設定
weight: 10
---

`config.toml`の主な項目の説明をします。設定項目については[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)も合わせて参照してください。

## config.toml直下の設定項目

### publishDir

出力ディレクトリです。`public_(config名)`と設定します。例えば`pdf_sample`ディレクトリに配置した`config.toml`では`public_pdf_sample`と設定します。hugo-theme-vivliocliではpublishDirがこの命名規則に従っている前提でビルドが行われます。

## \[params\] の設定項目

\[params\]以下に設定する設定値です。

### isPDF

PDFかどうか。この設定は通常Webサイト用のconfig.tomlでは`false`としVivliostyleを使用したPDF生成用のconfig.tomlでは`true`にします。trueにすると各htmlページでのmenu生成が抑制されます。

### theme_css

組版に使用するcssを指定します。`/static/css/yourtheme.css`を使用する場合`/css/yourtheme.css`と、指定します。vivliosytleのcssテーマファイルをここに配置して参照することでvivliostyleのテーマをあてることができます。なおデフォルトではテーマの`static/css`下にある`vivlio-theme-manual.css`が参照されています。

### showIfs

`ShowIf`ショートコード・フロントマターで表示する条件の一覧。

```
showIfs = ["edition1", "edition2"]
```

例えば上記のように設定した場合、`.md`ファイルで以下のブロックは表示されます。

```
{{%/* ShowIf edition1 */%}}
ここにedition1をサポートする場合に表示するコンテンツを記述。
{{%/* /ShowIf */%}}
```

以下のフロントマターの記事は描画されません。

```
---
title: edition3の説明
ShowIf: ["edition3"]
---
```

詳しくは [エディション](./edition.html) も参照してください。

### sectionNumberLevel

`pdfconfig.md` をルートとして各記事に章・節版号を付加するレベルを指定します。0の場合章番号の付加は行われません。

### sectionDelimiter

`sectionNumberLevel >= 2` の場合の章・節番号のデリミタを指定します。設定されていない場合`.`がデリミタとなります。

### sectionTopFormat

トップレベルのセクションの番号をフォーマットすることができます。フォーマット中に`%s`を1つ指定してください。その位置にセクション番号が挿入されます。言語ごとに変更することも可能です。

例)`sectionTopFormat = "Chapter %s"`

```
[languages.jp.params]
sectionTopFormat = "第%s章"
[languages.en.params]
sectionTopFormat = "Chapter %s"
```