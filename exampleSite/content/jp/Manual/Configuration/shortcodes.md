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

### csvのinclude

csvファイルのincludeでは、Markdownよりも高度な表を描画することができます。

```bash
{{</* include 
      src="./rich.csv" # sourceファイルのパス
      caption="サンプル表" # キャプション
      class="gray"      # tableに付加するclass属性。未指定/simple/gray
      markdown=true     # trueにした場合表内部のMarkdownをレンダリング。初期値false
      head=1         # trueにした場合1行目をヘッダーとみなす。初期値true。数値の場合数値行数をヘッダーとみなす。
      align="left"  # 表自体を左寄せ/中央寄せ/右寄せ。 left / center / right
      width="90%"       # tableのwidth属性を設定。
*/>}} 
```

{{< include 
      src="./rich.csv" 
      caption="サンプル表"
      class="gray"
      markdown=true
      head=1
      align="left"
      width="90%" >}}

### csvの書式

#### 縦横結合

 `||`で縦方向に結合,`->`で横方向に結合できます。

#### ColumnCodes

 ヘッダー（複数行の場合最終行）に ColumnCodes を埋め込むことができます。 ColumnCodes は`[[@<識別子>=<値>]]`という形式のコードです。ヘッダーセルの文末に記載することで列に対して作用します。 ` `(半角スペース) や `,` 区切りで複数指定することが可能です以下にColumnCodesの一覧を列挙します。

* `[[@id=myColumnId]]` : この列の全セルの`<td>`タグに`myColumnId`を`class`属性として埋め込みます。
* `[[@w=20%]]` : この列の幅をテーブルの20%とします。指定のない列は`auto`とみなされます。本コードが1つでもあると、`include`ショートコードの`width_ratio`オプションは無視されます。
* `[[@align=left]]` : この列を左寄せで描画します。 選択肢： `left` / `center` / `right`

![rich.csv](assets/20220820215713.png)

### csvの特定の値のみ参照する

csvファイルについては行を決定するためのkeyと列名を指定することで特定の値のみを参照することもできます。keyには最も左の列が使われます。重複する値がある場合は最初に見つかったものが優先されます。

```bash
{{</* include "test_jp.csv" "003" "Name" */>}} # /content/jp/_include/test_jp.csv の "003" にマッチした行の "Name" 列の値
```

上記の場合、1列目の値が`003`である行の`Name`列の値がショートコードの位置に挿し込まれます。