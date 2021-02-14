---
title: hugo-theme-vivliocliの設定
role: doc-chapter
weight: 10
---

本章ではhugo-theme-vivliocliで設定可能な項目について解説します。

# config.tomlの設定

`config.toml`の主な項目の説明をします。特に`[params]`の項目を設定することで、`vivliostyle-cli`の`vivliostyle.config.js`が生成されます。 その他の設定項目については[HUGO公式ドキュメント](https://gohugo.io/getting-started/configuration/)も合わせて参照してください。

## config.toml直下の設定項目

### publishDir

出力ディレクトリです。`public_(environment名)`と設定します。例えば`pdf_sample`ディレクトリに配置した`config.toml`では`public_pdf_sample`と設定します。

## \[params\] の設定項目

\[params\]以下に設定する設定値です。

### author

`vivliostyle.config.js` のauthorを設定します。

### isPDF

PDFかどうか。この設定は通常Webサイト用のconfig.tomlでは`false`としVivliostyleを使用したPDF生成用のconfig.tomlでは`true`にします。現状での違いは、trueにすると各htmlページでのmenu生成が抑制されることです。

### theme_css

組版に使用するcssを指定します。`/static/css/yourtheme.css`を使用する場合`/css/yourtheme.css`と、指定します。vivliosytleのバンドル済みcssファイルをここに配置して参照することでvivliostyleのテーマをあてることができます。

### pagesize

`vivliostyle.config.js` のsizeを設定します。

### showIfs

`ShowIf`ショートコードで表示する条件の一覧。

```
showIfs = ["supportFuncA", "supportFuncB"]
```

例えば上記のように設定した場合、`.md`ファイルで以下のブロックは表示されます。

```
{{%/* ShowIf supportFuncA */%}}
ここにFuncAをサポートする場合に表示するコンテンツを記述。
{{%/* /ShowIf */%}}
```

本設定について詳しくは[エディション](./30_Edition.html)を参照してください。
