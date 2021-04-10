---
title: "ShowIf/HideIf ShortCode テスト"
weight: 40
---

## ShowIf

ここは共通。

{{% ShowIf test %}}
ここは"test"をshowIfsに含む場合に出力。

## ShowIf内の見出し2

テスト

### ShowIf内の見出し3

テスト
{{% /ShowIf %}}

## HideIf

ここは共通。

{{% HideIf test %}}
ここは"test"をshowIfsに含まない場合に出力。

## HideIf内の見出し2

テスト

### HideIf内の見出し3

テスト

{{% /HideIf %}}

## 共通の見出し2

テスト

### 共通の見出し3

テスト