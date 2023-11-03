---
title: "Frontmatter"
weight: 30
---

Explanation of the settings for each section and article:

## Front matter of `_index.md`

By default, `_index.md` is treated as a section at the same level as each article, but by setting `role`, it can be used as a larger framework for parts/chapters.

{{% note %}}
`_index.md` at the same level as `_pdf.md` will not be output to PDF.
{{% /note %}}

### role

`role: doc-part`: `_index.md` is output as the cover page for a part in a PDF.
`role: doc-chapter`: `_index.md` is output as the title of a chapter and the first article in a PDF.

## Front matter of each article

### ShowIf

By specifying the `ShowIf` front matter, an article can only be rendered if it matches the keywords listed in the `showIfs` of `config.toml`. The following front matter specifies an article that will only be rendered if `showIfs = ["edition1"]`:

```
---
title: Description of edition1
ShowIf: ["edition1"]
---
```

For more information, see [Editions](./edition.html).

### HideIf

By specifying the `HideIf` front matter, articles/sections that are hidden only in a specific edition can be created. For more information, refer to [Editions](./edition.html).

### math

By setting `math: true`, you can write inline equations on the page. Inline equations are written as `$E = mc^2$`. Note that block equations can always be written as follows, regardless of the value of this flag:

```text
    ```math
    y = ax^2 + bx + \frac{c}{d}
    ```
```

### pagesize

If you set `pagesize: "A4 landscape"`, the page generated from that `.md` will be A4 landscape. Possible values are the same as `pagesize` of `_pdf.md`.