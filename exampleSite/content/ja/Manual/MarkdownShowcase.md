---
title: "MarkdownとShortcodes"
weight: 20
math: true
tags: ["tutorial"]
---

本テーマで利用できるMarkdownとShortcodesのショーケースです。

## Markdown

## Header 2

### Header 3

#### Header 4

##### Header 5

###### Header 6

### テキスト

吾輩は猫である。名前はまだ無い。

どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪な種族であったそうだ。この書生というのは時々我々を捕えて煮て食うという話である。しかしその当時は何という考もなかったから別段恐しいとも思わなかった。ただ彼の掌に載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。掌の上で少し落ちついて書生の顔を見たのがいわゆる人間というものの見始であろう。この時妙なものだと思った感じが今でも残っている。第一毛をもって装飾されべきはずの顔がつるつるしてまるで薬缶だ。その後猫にもだいぶ逢ったがこんな片輪には一度も出会わした事がない。のみならず顔の真中があまりに突起している。そうしてその穴の中から時々ぷうぷうと煙を吹く。どうも咽せぽくて実に弱った。これが人間の飲む煙草というものである事はようやくこの頃知った。

この書生の掌の裏うちでしばらくはよい心持に坐っておったが、しばらくすると非常な速力で運転し始めた。書生が動くのか自分だけが動くのか分らないが無暗に眼が廻る。胸が悪くなる。到底助からないと思っていると、どさりと音がして眼から火が出た。それまでは記憶しているがあとは何の事やらいくら考え出そうとしても分らない。

ふと気が付いて見ると書生はいない。たくさんおった兄弟が一疋も見えぬ。肝心の母親さえ姿を隠してしまった。その上今までの所とは違って無暗に明るい。眼を明いていられぬくらいだ。はてな何でも容子がおかしいと、のそのそ這い出して見ると非常に痛い。吾輩は藁の上から急に笹原の中へ棄てられたのである。

夏目漱石(1905) 『吾輩は猫である』[青空文庫, 底本：「夏目漱石全集1」ちくま文庫、筑摩書房 1987（昭和62）年9月29日第1刷発行](https://www.aozora.gr.jp/cards/000148/files/789_14547.html)

### 箇条書き

* 箇条書き
  * 箇条書き
  * 箇条書き
    * 箇条書き
* 箇条書き
  * 箇条書き

### 順序つきリスト

1. AAA
1. BBB
1. CCC
    1. AAA
    1. BBB
    1. CCC
        * AAA
        * BBB
1. DDD
1. EEE

### リンク

[Google](https://www.google.co.jp/) のリンク。

### 表

より高度な表現ができる[include](#include) も参照してください。

| No. | item | note |
| --- | --- | --- |
| 1    | AAA    | noteA |
| 2    | BBB    | noteB |
| 3    | CCC    | noteC |

### 引用

> 引用文です。

### インラインコード

`inlinecode`です。

### コードブロック

```
整形済みテキストです。
```

```md
整形済みテキストです。
```

```c#
// comment
if (a == b)
{
  return true;
}
```

### 脚注

Google[^1] です。
Here is a footnote reference,[^Z]

[^1]: 脚注テキスト https://www.google.co.jp/
[^Z]: Here is the footnote.

### 水平線

---

### 斜体

*italic* *斜体*

### 太字

**bold** **太字**

### 取り消し線

~~取り消し線~~

### MathJax

インライン数式は $y = ax^2 + \frac{b}{c}$ のように記載します。インライン数式を有効にするにはフロントマターに`math: true`を記載する必要があります。

ブロック数式は`math`コードブロックで記載します。

```math
\frac{\pi}{2} =
\left( \int_{0}^{\infty} \frac{\sin x}{\sqrt{x}} dx \right)^2 =
\sum_{k=0}^{\infty} \frac{(2k)!}{2^{2k}(k!)^2} \frac{1}{2k+1} =
\prod_{k=1}^{\infty} \frac{4k^2}{4k^2 - 1}
```

### Mermaid

`mermaid`コードブロックは[Mermaid](https://mermaid.js.org/)で記載されたダイアグラムとして描画されます。

```mermaid
sequenceDiagram
Alice->>Bob: Hello Bob.
Bob-->>Alice: Hello Alice.
```

### 図

#### 通常の図

代替テキストなしの図

![](assets/2021-02-28-22-20-24.png)

#### インライン

インラインで小さな図を表示する ![](assets/2021-02-28-22-19-54.png)


#### figure

代替テキストを書くと図番号とキャプションが付く。![exampleSiteのスクリーンショット](assets/2021-02-28-22-20-53.png)

![Configurationディレクトリのスクリーンショット](assets/2021-02-28-22-21-35.png)

代替テキストを空白文字のみにすると図番号とキャプションは付かず、中央寄せのみ。

![  ](assets/2021-02-28-22-21-35.png)

#### 画像サイズの変更（属性の付加）

URLクエリパラメータとして属性を付加すれば画像サイズ変更や境界線を付加可能。

```md
![border=10 & width=50%](assets/2021-02-28-22-21-35.png?border=10&width=50%)
```
![border=10 & width=50%](assets/2021-02-28-22-21-35.png?border=10&width=50%)

## Shortcodes

### ShowIf

`config.toml`の`showIfs`で列挙されている場合に描画する部分を指定します。以下は`showIfs = ["edition1"]`とした場合に描画されるブロックです。

```bash
{{%/* ShowIf edition1 */%}}
ここにxxxをサポートする場合に表示するコンテンツを記述。
{{%/* /ShowIf */%}}
```

詳しくは [エディション](./edition.html) を参照してください。

### HideIf

`config.toml`の`showIfs`で列挙されている場合に描画「しない」部分を指定します。以下は`showIfs = ["edition1"]`とした場合に描画されなくなるブロックです。

```bash
{{%/* HideIf edition1 */%}}
ここはedition1のときのみ非表示になる。
{{%/* /HIdeIf */%}}
```

詳しくは [エディション](./edition.html) を参照してください。

### note

以下のように`note`ショートコードで囲まれた部分が注記としてレンダリングされます。

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


### now

ビルド実行時の時刻を指定のフォーマットで出力します。フォーマットは`2006/1/2 15:04:05 Mon`の日時（正確にこの通りの日付および時刻）を利用して指定する必要があります。

```
{{%/* now "2006/01/02" */%}}
{{%/* now "2006-1-2 15:04" */%}}
{{%/* now "2006年1月2日 15時04分05秒" */%}}
```

{{% now "2006/01/02" %}}
{{% now "2006-1-2 15:04" %}}
{{% now "2006年1月2日 15時04分05秒" %}}


### include

Markdownファイル、csvファイルの「部品」を用意しておき、記事の任意の箇所に「挿し込む」事ができます。`.`からパスを記述することで相対パス指定で読み込み可能です。

```bash
{{</* include "./test.csv"  */>}} # /(md file dir path)/test.csv
```

また、部品ファイルを`/content/<language>/_include`以下に配置しておけば、以下のようにincludeすることができます。

```bash
{{</* include "test_ja.md"  */>}} # /content/ja/_include/test_ja.md
{{</* include "/sample/sample_ja.md" */>}} # /content/ja/_include/sample/sample_ja.md
{{</* include "test_ja.csv"  */>}} # /content/ja/_include/test_ja.csv
```

* _includeディレクトリ内のMarkdownにはフロントマターは記載しません。
* includeショートコードは`{{</* */>}}`スタイル（Markdownレンダリング無し）で記述してください。`{{%/* */%}}`スタイル（Markdownレンダリングあり）で記述すると、csv読み込みが正しく動作しません。

#### csvのinclude

csvファイルのincludeでは、Markdownよりも高度な表を描画することができます。

```bash
{{</* include 
      src="./rich.csv" # sourceファイルのパス
      caption="サンプル表" # キャプション
      class="gray"      # tableに付加するclass属性。未指定/simple/gray
      markdown=true     # trueにした場合表内部のMarkdownをレンダリング。初期値false
      head=1         # trueにした場合1行目をヘッダーとみなす。初期値true。数値の場合数値行数をヘッダーとみなす。
      align="left"  # 表自体を左寄せ/中央寄せ/右寄せ。 left / center / right
      head_align="center" # 表のヘッダーのすべての列を左寄せ/中央寄せ/右寄せ。 left / center / right
      body_align="left" # 表のボディのすべての列を左寄せ/中央寄せ/右寄せ。 left / center / right
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
      head_align="center"
      body_align="left"
      width="90%" >}}

#### csvの書式

##### 縦横結合

`||`で縦方向に結合,`->`で横方向に結合できます。また、`<-`で右のセルとの結合ができます（インデント表現）。

{{< include src="./indent.csv" >}}

##### ColumnCodes

 ヘッダー（複数行の場合最終行）に ColumnCodes を埋め込むことができます。 ColumnCodes は`[[@<識別子>=<値>]]`という形式のコードです。ヘッダーセルの文末に記載することで列に対して作用します。複数のコードを適用する場合`[[@<識別子>=<値> @<識別子>=<値>]]`のようにスペース区切りで記述します。以下にColumnCodesの一覧を列挙します。

|ColumnCodes|解説|
|:--|:--|
|`[[@id=myId]]` | この列の全セルの`<td>`タグに`myColumnId`を`class`属性として埋め込みます。 |
|`[[@w=20%]]` | この列の幅をテーブルの20%とします。指定のない列は`auto`とみなされます。本コードが1つでもあると、`include`ショートコードの`width_ratio`オプションは無視されます。|
|`[[@h:--]]` / `[[@h:--:]]` / `[[@h--:]]` | ヘッダー左/中央/右寄せ（`-`の数は任意）|
| `[[@:--]]` / `[[@:--:]]` / `[[@--:]]` | ボディ左/中央/右寄せ（`-`の数は任意）|

![rich.csv](assets/20220820215713.png)

#### csvの特定の値のみ参照する

csvファイルについては行を決定するためのkeyと列名を指定することで特定の値のみを参照することもできます。keyには最も左の列が使われます。重複する値がある場合は最初に見つかったものが優先されます。

```bash
{{</* include "test_ja.csv" "003" "Name" */>}} # /content/ja/_include/test_ja.csv の "003" にマッチした行の "Name" 列の値
```

上記の場合、1列目の値が`003`である行の`Name`列の値がショートコードの位置に挿し込まれます。

### PDFParam

`_pdf.md`のフロントマターに記述した`doctitle`や`author`などの値を文書に埋め込むことができます。

```sh
{{%/* PDFParam doctitle */%}}
{{%/* PDFParam subtitle */%}}
{{%/* PDFParam author */%}}
```

{{% PDFParam doctitle %}}
{{% PDFParam subtitle %}}
{{% PDFParam author %}}
