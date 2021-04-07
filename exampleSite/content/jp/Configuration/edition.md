---
title: エディション
weight: 60
---

内容が異なるPDFのファミリーを生成する必要がある場合、HUGOの[Configuration Directory](https://gohugo.io/getting-started/configuration/#configuration-directory)の仕組みを利用してエディションを作り分け、構成や記事内容を切り替えてビルドできます。

## エディションのconfigを作成する

`/config/pdf_other`というディレクトリを作成し、`/config/pdf_sample/config.toml`をコピーして編集することで簡単に`pdf_other`エディションを作成することができます。それぞれのエディションのconfigは[config.tomlの設定](./config.html)に沿って編集します。以下では主要な設定変更について説明します。

### 特定要素の表示/非表示を切り替える

[ShowIf](./shortcodes.html)/[HideIf](./shortcodes.html)ショートコード/フロントマターと共に`showIfs`を使用することで表示/非表示を切り替えます。

```toml
[params]
  showIfs = ["edition1"]
```

この場合、`.md`の記事で以下のように記載した要素が表示されます。

```
{{%/* ShowIf edition1 */%}}
ここにedition1をサポートする場合に表示するコンテンツを記述。
{{%/* /ShowIf */%}}
```

以下のように記載した要素はedition1でのみ非表示になります。

```
{{%/* HideIf edition1 */%}}
ここにedition1の場合には非表示にするコンテンツを記述。
{{%/* /HideIf */%}}
```

### 特定記事・セクションの表示/非表示を切り替える

記事/セクション単位では以下のようにフロントマターを書いている場合にPDFに含まれます。必ずリスト形式（`["xxx", "yyy"]`）で書く必要があります。

```toml
[params]
  showIfs = ["edition1"]
```

`config.toml`に上記の用に"edition1"を含むとき、以下のページはPDFに含まれることになります。

```
---
title: edition1の説明
ShowIf: ["edition1"]
---
```

> `config.toml`で `showIfs = ["@all-pages"]` のように、`@all-pages` を含めると、各記事にShowIfフロントマターが書かれていても強制的に全ページをPDF描画対象とします。

`HideIf`を使用し以下のようにすると、edition1のPDFには含まれなくなります。

```
---
title: edition1以外で表示
HideIf: ["edition1"]
---
```


## ビルドする

エディションを指定してビルドするには、引数にエディションを指定します。例えば`pdf_other`エディションをビルドするには以下のように指定します。

```
.\CI\build.bat pdf_other
```