---
title: "フロントマター"
weight: 40
---

セクションや各記事のフロントマターの設定について解説します。

## _index.mdのフロントマター

`_index.md`はデフォルトではセクション（各記事と同等レベル）として扱われますが、`role`を設定することでより大きなパート/チャプターなどの大きな枠とすることができます。

### role

`role: doc-part` : このセクションをパートとします。_index.mdはパートの表紙ページとして描画されます。
`role: doc-chapter` : このセクションをチャプターとします。_index.mdはチャプターのタイトル及び最初の記事として描画されます。

## 各記事のフロントマター

### math

`math: true` としたページにはTex数式（Mathjax数式）を記述することができます。インライン数式は`$E = mc^2$`のように記載します。ブロック数式は以下のように記載します。

```tex
$$
y = ax^2 + bx + \frac{c}{d}
$$
```

なお、Mathjax数式はプレビュー時はMathjaxのCDNで描画されますが、PDF出力時はCDNでは数式描画されないため、MathjaxのNode.jsパッケージを利用して数式を事前レンダリングしてからvivliostyleに渡しています。実装は`/exampleSite/CI/MathConverter/MathConverter.ps1`です。