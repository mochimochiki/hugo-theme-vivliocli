---
title: Edition
weight: 60
---

If you need to generate a family of PDFs with different contents, you can use the [Configuration Directory](https://gohugo.io/getting-started/configuration/#configuration-directory) mechanism in Hugo to create editions and switch configurations and article contents for building.

## Creating a config for an edition

Create `/config/myedition.toml`, and specify it with `default.toml` at build time to easily create the `myedition` edition.

### Switching the display of specific elements on and off

Use `showIfs` with `ShowIf` / `HideIf` shortcodes / front matter to switch the display on and off.

```toml
[params]
  showIfs = ["edition1"]
```

With this setting, elements written as follows in the markdown will be displayed.

```
{{%/* ShowIf edition1 */%}}
Write content to be displayed when supporting edition1 here.
{{%/* /ShowIf */%}}
```

Elements written as follows will be hidden only in edition1.

```
{{%/* HideIf edition1 */%}}
Write content to be hidden in edition1 here.
{{%/* /HideIf */%}}
```

### Switching the display of specific articles / sections on and off

When writing front matter like this, the article / section will be included in the PDF. It must be written in list format (`["xxx", "yyy"]`).

```toml
[params]
  showIfs = ["edition1"]
```

If "edition1" is included in config.toml, the following pages will be included in the PDF.

```
---
title: edition1 description
ShowIf: ["edition1"]
---
```

If you use HideIf as follows, it will no longer be included in the PDF for edition1.

```
---
title: Displayed in editions other than edition1
HideIf: ["edition1"]
---
```

## Building

To build with a specified edition, specify the edition as an argument. For example, to build the `other` edition, specify it as follows:

**Hugo**
```
set HUGO_PARAMS_ISPDF=true
hugo --config "config/default.toml","config/other.toml" -b ""
```

**Batch**
```
.\CI\build_pdf.bat other
```