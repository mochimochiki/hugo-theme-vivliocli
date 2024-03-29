---
title: "フロントマター"
weight: 30
---

セクションや各記事の設定について解説します。

## _index.mdのフロントマター

`_index.md`はデフォルトでは各記事と同等レベルのセクションとして扱われますが、`role`を設定することでパート/チャプターなどのより大きな枠とすることができます。

### role

`role: doc-part` : _index.mdはパートの表紙ページとしてPDF出力されます。
`role: doc-chapter` : _index.mdはチャプターのタイトル及び最初の記事としてPDF出力されます。

{{% note %}}
`_pdf.md`と同階層の`_index.md`はPDFには出力されません。
{{% /note %}}

## 各記事のフロントマター

### ShowIf

`ShowIf`フロントマターを指定することで、`config.toml`の`showIfs`で列挙されているキーワードにマッチした場合にのみ記事を描画する事ができます。以下のフロントマターを指定した記事は`showIfs = ["edition1"]`である場合に描画されます。

```
---
title: edition1の説明
ShowIf: ["edition1"]
---
```

詳しくは [エディション](./edition.html) を参照してください。

### HideIf

`HideIf`フロントマターを指定すると、そのエディションでのみ非表示とする記事/セクションを作ることができます。詳しくは [エディション](./edition.html) を参照してください。

### math

`math: true` としたページにはインライン数式を記述することができます。インライン数式は`$E = mc^2$`のように記載します。なおブロック数式は本フラグの値にかかわらず常に以下のように記載できます。

```text
    ```math
    y = ax^2 + bx + \frac{c}{d}
    ```
```

### pagesize

`pagesize: "A4 landscape"`とした場合、その`.md`から生成されるページは A4 landscape になります。指定可能な値は `_pdf.md` の `pagesize` と同じです。
