---
title: ショートコード
weight: 30
---

hugo-theme-vivliocli テーマで使用できるショートコードの一覧です。

## ShowIf

`config.toml`の`showIfs`で列挙されている場合に描画する部分を指定します。以下は`showIfs = ["edition1"]`とした場合に描画されるブロックです。

```bash
{{%/* ShowIf edition1 */%}}
ここにxxxをサポートする場合に表示するコンテンツを記述。
{{%/* /ShowIf */%}}
```

{{% ShowIf edition1 %}}
ここにxxxをサポートする場合に表示するコンテンツを記述。
{{% /ShowIf %}}

[config.tomlの設定](./config.html#showIfs)も参照してください。

## note

注記です。以下のように`note`ショートコードで囲まれた部分が注記としてレンダリングされます。

```
{{%/* note */%}}
ここに注記文章を記載
{{%/* /note */%}}
```
{{% note %}}
ここに注記文章を記載
{{% /note %}}

`note (title)`と言う形式で、引数にタイトルを指定することもできます。note内部にMarkdownを書くことも可能です。

```bash
{{%/* note 注記 */%}}
ここに注記文章を記載

* markdownも記載可能
  * 箇条書きレベル2
* 箇条書きレベル1
{{%/* /note */%}}
```



{{% note 注記 %}}
ここに注記文章を記載

* markdownも記載可能
  * 箇条書きレベル2
* 箇条書きレベル1
{{% /note %}}

## include

Markdownファイル、csvファイルの「部品」を用意しておき、原稿の任意の箇所に「挿し込む」事ができます。部品ファイルを`/content/<language>/_include`以下に配置しておけば、以下のショートコードでincludeすることができます。

```bash
{{</* include "test.md"  */>}} # include /content/jp/_include/test.md
{{</* include "/sample/sample.md" */>}} # include /content/jp/_include/sample/sample.md
{{</* include "test.csv"  */>}} # include /content/jp/_include/test.csv
```

{{% note %}}
* _includeディレクトリ内のMarkdownにはフロントマターは記載しません。
* _includeディレクトリ内のMarkdownのヘッダは目次化することができません。（ページ内目次/PDF目次とも不可）
* _includeディレクトリ内のMarkdownでは、ショートコードは使用できません。（よって多重includeはできません）
* includeショートコードは`{{</* */>}}`スタイル（Markdownレンダリング無し）で記述してください。`{{%/* */%}}`スタイル（Markdownレンダリングあり）で記述すると、csv読み込みが正しく動作しません。
{{% /note %}}