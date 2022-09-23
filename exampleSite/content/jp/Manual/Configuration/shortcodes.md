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

詳しくは [エディション](./edition.html) を参照してください。

## HideIf

`config.toml`の`showIfs`で列挙されている場合に描画「しない」部分を指定します。以下は`showIfs = ["edition1"]`とした場合に描画されなくなるブロックです。

```bash
{{%/* HideIf edition1 */%}}
ここはedition1のときのみ非表示になる。
{{%/* /HIdeIf */%}}
```

詳しくは [エディション](./edition.html) を参照してください。

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
{{</* include "test_jp.md"  */>}} # /content/jp/_include/test_jp.md
{{</* include "/sample/sample_jp.md" */>}} # /content/jp/_include/sample/sample_jp.md
{{</* include "test_jp.csv"  */>}} # /content/jp/_include/test_jp.csv
{{</* include "./test.csv"  */>}} # /(md file dir path)/test_jp.csv
```

* _includeディレクトリ内のMarkdownにはフロントマターは記載しません。
* includeショートコードは`{{</* */>}}`スタイル（Markdownレンダリング無し）で記述してください。`{{%/* */%}}`スタイル（Markdownレンダリングあり）で記述すると、csv読み込みが正しく動作しません。

### includeでcsvの特定の値のみ参照する

csvファイルについては行を決定するためのkeyと列名を指定することで特定の値のみを参照することもできます。keyには最も左の列が使われます。重複する値がある場合は最初に見つかったものが優先されます。

```bash
{{</* include "test_jp.csv" "003" "Name" */>}} # /content/jp/_include/test_jp.csv の "003" にマッチした行の "Name" 列の値
```

上記の場合、1列目の値が`003`である行の`Name`列の値がショートコードの位置に挿し込まれます。

### 高度な表をincludeする（セル結合/Markdown/幅指定/ヘッダー有無指定）

csvファイルのincludeでは、Markdownよりも高度な表を描画することができます。`||`で縦方向に結合,`->`で横方向に結合できます。

![rich.csv](assets/20220820215713.png)

```bash
{{</* include 
      src="./rich.csv" # sourceファイルのパス
      class="gray"      # tableに付加するclass属性。未指定/simple/gray
      markdown=true     # trueにした場合表内部のMarkdownをレンダリング。初期値false
      head=1         # trueにした場合1行目をヘッダーとみなす。初期値true。数値の場合数値行数をヘッダーとみなす。
      width="90%"       # tableのwidth属性を設定。
      width-ratio="5%-10%-70%-*" # tableの列幅の比率を-区切りで指定。"*"はauto。
*/>}} 
```

{{< include 
      src="./rich.csv" 
      class="gray"
      markdown=true
      head=1
      width="90%"
      width-ratio="5%-10%-70%-*" >}}
