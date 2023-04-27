---
title: エディション
weight: 60
---

内容が異なるPDFのファミリーを生成する必要がある場合、HUGOの[Configuration Directory](https://gohugo.io/getting-started/configuration/#configuration-directory)の仕組みを利用してエディションを作り分け、構成や記事内容を切り替えてビルドできます。

## エディションのconfigを作成する

`/config/myedition.toml`を作成し、ビルド時に`default.toml`とともに指定することで簡単に`myedition`エディションを作成することができます。

### 特定要素の表示/非表示を切り替える

[ShowIf](./MarkdownShowcase.html)/[HideIf](./MarkdownShowcase.html)ショートコード/フロントマターと共に`showIfs`を使用することで表示/非表示を切り替えます。

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

`config.toml`に"edition1"を含むとき、以下のページはPDFに含まれることになります。

```
---
title: edition1の説明
ShowIf: ["edition1"]
---
```

`HideIf`を使用し以下のようにすると、edition1のPDFには含まれなくなります。

```
---
title: edition1以外で表示
HideIf: ["edition1"]
---
```


## ビルドする

エディションを指定してビルドするには、引数にエディションを指定します。例えば`other`エディションをビルドするには以下のように指定します。

**Hugo**
```
set HUGO_PARAMS_ISPDF=true
hugo --config "config/default.toml","config/other.toml" -b ""
```

**Batch**
```
.\CI\build_pdf.bat other
```