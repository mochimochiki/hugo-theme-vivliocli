---
title: hugo.toml
weight: 40
---

Here is an explanation of the main items in `hugo.toml`. Please also refer to the [Hugo official documentation](https://gohugo.io/getting-started/configuration/) and the comments in `hugo.toml` for information about each setting.

## settings under \[params\]

### isPDF

Whether it is a PDF or not. If set to true, menu generation is suppressed on each html page. Set to true when building a PDF.

### theme_css

Specify the css used for typesetting. If using `/static/css/yourtheme.css`, specify it as `/css/yourtheme.css`. By default, `style-main.css` in the theme's `static/css` directory is referenced.

### showIfs

A list of conditions to switch between showing and hiding using ShowIf/HideIf shortcodes or front matter.

```
showIfs = ["edition1", "edition2"]
```

Please refer to [Edition](./edition.html) for more details.

### legacy_menu

Whether to embed the menu (the content tree on the left) into every page. The default is `false`.

When `false` (the default), the menu is written once to `js/menu-tree-<lang>.js` and injected by JavaScript when the page opens. Embedding the same menu in every page makes both build time and output size grow quickly as pages are added: on a 2500-page site, 328KB of each 336KB page was the menu. Writing it to a single file removes that repetition.

Set it to `true` to embed the menu into every page as before. Use this if the menu has to work with JavaScript disabled.

The menu is also displayed when opening the html as a local file (`file:`) with the default `false`.

### sectionNumberLevel

Specify the level at which chapter and section numbers are added. If 0, chapter numbers will not be added.

### sectionDelimiter

Specify the delimiter for chapter and section numbers when sectionNumberLevel >= 2. If not set, `.` is used as the delimiter.

### sectionTopFormat

Specify the format of the top-level section numbers.
Specify one `%s` in the format, and the section number will be inserted at that position.

Example: `sectionTopFormat = "Chapter %s"`

