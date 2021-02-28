---
title: "フロントマター"
weight: 40
---

セクションや各記事のフロントマターの設定について解説します。

## _index.mdのフロントマター

`_index.md`はデフォルトでは各記事と同等レベルのセクションとして扱われますが、`role`を設定することでパート/チャプターなどのより大きな枠とすることができます。

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

なお数式はPDF出力時、MathjaxのCDNでは描画できません。PDF出力で数式を正しく描画するためには、`isPDF: true`にした上でhugoサイトビルド後にMathjaxのNode.jsパッケージを利用して数式を事前レンダリングし、その後vivliostyleに渡す必要があります。実装は`/exampleSite/CI/MathConverter/MathConverter.ps1`です。`build.bat`ではこのpowershellスクリプトをhugoサイトビルド後に実行することでMathjax数式をレンダリングしています。