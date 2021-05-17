---
title: "include"
weight: 30
---

## include md

{{< include test.md >}}

## include csv from current dir

{{< include current-test.csv >}}

## include csv from relative path

{{< include "csv/relative-test.csv" >}}

## include csv from _include dir

{{< include test.csv >}}

## include csv one parameter

### パラメータをinclude

{{< include "test.csv" "005" "名称" >}}

### 列がマッチしない

↓表示されないはず。
{{< include "test.csv" "005" "存在しない列名" >}}

### 行がマッチしない

↓表示されないはず。
{{< include "test.csv" "9999" "名称" >}}

### パラメータが足りない

↓表示されないはず。
{{< include "test.csv" "005" >}}