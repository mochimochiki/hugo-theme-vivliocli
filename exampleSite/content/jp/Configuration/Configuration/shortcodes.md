---
title: ショートコード
weight: 10
---

hugo-theme-vivliocli テーマで使用できるショートコードの一覧です。

## ShowIf

`config.toml`の`showIfs`で列挙されている場合に描画する部分を指定します。以下は`showIfs = ["supportFuncA"]`とした場合に描画されるブロックです。

```
{{%/* ShowIf supportFuncA */%}}
ここにxxxをサポートする場合に表示するコンテンツを記述。
{{%/* /ShowIf */%}}
```

[構成](./10_ConfigureHelp.html#showIfs)も参照してください。

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

```
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
