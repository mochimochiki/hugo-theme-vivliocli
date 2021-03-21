---
title: "フロントマター・記事"
weight: 40
---

セクションや各記事の設定について解説します。

## _index.mdのフロントマター

`_index.md`はデフォルトでは各記事と同等レベルのセクションとして扱われますが、`role`を設定することでパート/チャプターなどのより大きな枠とすることができます。

### role

`role: doc-part` : このセクションをパートとします。_index.mdはパートの表紙ページとして描画されます。
`role: doc-chapter` : このセクションをチャプターとします。_index.mdはチャプターのタイトル及び最初の記事として描画されます。

## 各記事のフロントマター

### ShowIf

`ShowIf`フロントマターを指定することで、`config.toml`の`showIfs`で列挙されているキーワードにマッチした場合にのみ記事を描画する事ができます。以下のフロントマターを指定した記事は`showIfs = ["edition1"]`である場合に描画されます。

```
---
title: edition1の説明
ShowIf: ["edition1"]
---
```

[config.tomlの設定](./config.html#showIfs)も参照してください。

### math

`math: true` としたページにはTex数式（Mathjax数式）を記述することができます。インライン数式は`$E = mc^2$`のように記載します。ブロック数式は以下のように記載します。

```tex
$$
y = ax^2 + bx + \frac{c}{d}
$$
```

なお数式はPDF出力時、MathjaxのCDNでは描画できません。PDF出力で数式を正しく描画するためには、`isPDF: true`にした上でhugoサイトビルド後にMathjaxのNode.jsパッケージを利用して数式を事前レンダリングし、その後vivliostyleに渡す必要があります。実装は`/exampleSite/CI/MathConverter/MathConverter.ps1`です。`build.bat`ではこのpowershellスクリプトをhugoサイトビルド後に実行することでMathjax数式をレンダリングしています。

## 各記事のヘッダをPDF目次に表示する {#pdftoc-pagetoc}

各記事のヘッダは通常PDFの目次には出力されませんが、以下のように`#pdftoc-xxx`形式のIDを付加することでそのヘッダをPDFの目次及びしおりに出力できます。

```md
## 基本 {#pdftoc-basic}

基本です。

### 基本 - その1 {#pdftoc-basic-1}

基本その1です。
```

以下のことに注意してください。

* セクションページ`_index.md`には適用できません。
* IDは記事中で一意になるようにしてください。別記事との重複は問題ありません。
* `#pdftoc-xxx`IDを振ったレベルのヘッダより上位のヘッダには必ず`#pdftoc-xxx`ヘッダが振られているようにしてください。目次表示が崩れます。例えば###レベルに`#pdftoc-h3`をつけた場合、そのヘッダが属する##レベルにも`#pdftoc-h2`などを付ける必要があります。
* ヘッダ文自体に`#pdftoc-xxx`を含む文字列を入れないでください。その部分が誤変換されます。