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


## ShowIfでOr

{{% ShowIf test test2 %}}
ここはtestもしくはtest2で表示される。
{{% /ShowIf %}}

{{% ShowIf dummy test3 %}}
ここはdummyもしくはtest3で表示される。
{{% /ShowIf %}}

## HideIfでOr

{{% HideIf test test2 %}}
ここはtestもしくはtest2で表示されない。
{{% /HideIf %}}

{{% HideIf dummy test3 %}}
ここはdummyもしくはtest3で表示されない。
{{% /HideIf %}}

{{% HideIf dummy test4 %}}
ここはdummyもしくはtest4で表示されない。
{{% /HideIf %}}

## ShowIf内でのショートコード

{{% ShowIf test %}}

* この下にcsvのinclude。

{{< include "./current-test.csv" >}}

* この下にincludeディレクトリのcsvのinclude

{{< include test_ja.csv >}}

* この下に複雑な表のinclude

{{< include
      src="./cell-merge1.csv"
      class="simple"
      markdown=true
      merge=true
      head=true
      width="90%"
      width-ratio="5%-10%-75%-*" >}}

* この下にmdのinclude

{{< include test_ja.md >}}

ここまで。


{{% /ShowIf %}}

