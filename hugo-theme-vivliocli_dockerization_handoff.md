# hugo-theme-vivliocli Docker化 再挑戦用ハンドオフレポート

## 目的
`mochimochiki/hugo-theme-vivliocli` の `exampleSite` を、Docker 上で安定してビルドし、必要なら PDF 生成まで通すための方針を整理する。

## 事実として確認できたこと

### 1. テーマの前提
- このテーマは Hugo テーマで、`exampleSite` はサンプル兼ユーザーガイドになっている。
- README では **Hugo v0.163.1 以上** と **Vivliostyle CLI v8.6.0 以上** が前提。
- `_pdf.md` を持つセクションを typeset PDF として出力する設計。

### 2. `exampleSite` 側の依存
- `exampleSite/package.json` には `@vivliostyle/viewer` と `copyfiles` がある。
- `postinstall` で `node_modules/@vivliostyle/viewer/lib/**/*` を `static/viewer` にコピーする。
- つまり、Docker ビルドで `exampleSite` を扱うなら **Node/npm 系の依存解決が必要**。

### 3. サイトビルド手順
- GitHub Actions の公開ワークフローは `cd exampleSite && hugo --minify` だけでビルドしている。
- ここから、通常のサイト生成は Hugo 側で完結し、PDF 周りは別の段で考える構成に見える。

### 4. Vivliostyle CLI 公式 Dockerfile が示す前提
Vivliostyle CLI の公式 Dockerfile では、少なくとも次が入る。
- `ghostscript`
- `poppler-utils`
- `fonts-noto`
- `nodejs` / `pnpm`
- `fontconfig` の alias 設定
- （アーキテクチャに応じて）Chromium / Puppeteer browser

また、公式 Dockerfile は Debian 系 (`debian:13-slim`) をベースにしている。

### 5. フォント周りの扱い
- 公式 `fonts.conf` では、`Hiragino` / `Yu Mincho` / `Meiryo` / `MS Gothic` などを `Noto Serif CJK JP` / `Noto Sans CJK JP` に寄せている。
- つまり、CJK を含むドキュメントでは **フォントが品質を左右する主要因**。

## 推奨方針

### 結論
**Docker は Debian 系ベースで組む。**
Alpine 系や最小構成から始めるより、Vivliostyle CLI 公式 Dockerfile の依存関係に寄せた方が早い。

### 具体的な方針
1. `exampleSite` の通常ビルドと PDF 生成を分けて考える。
2. Node 依存は `exampleSite/package.json` に従って必ず入れる。
3. PDF 生成系は `ghostscript` と `poppler-utils`、CJK フォント、fontconfig alias を入れる。
4. 可能なら Vivliostyle CLI の公式 Dockerfile の構成をベースに近づける。
5. まずは「ビルドが通ること」より先に、「PDF の見た目が破綻しないこと」を品質ゲートにする。

## 実行時に注意すべき点

### 1. フォントが最重要
- 日本語本文があるなら、フォント不足はすぐレイアウト崩れにつながる。
- `Noto Sans CJK JP` / `Noto Serif CJK JP` が使えること。
- 期待したフォント名が環境内で別名扱いになる場合に備え、fontconfig alias を入れる。

### 2. Ghostscript / poppler が必要になる場面がある
- PDF の後処理、ページ処理、変換系で依存しやすい。
- 「HTML は出るが PDF が壊れる」場合、まずここを疑う。

### 3. Node の postinstall を落とさない
- `exampleSite` は viewer を `static/viewer` にコピーするので、`npm install` / `pnpm install` を省略すると後で壊れる。

### 4. Hugo のバージョン差
- README の前提は Hugo 0.114+。
- GitHub Pages の workflow は 0.121.2 を使っている。
- Docker でもこの近辺に合わせるのが安全。

### 5. 画像・表・Mermaid・MathJax を必ず見る
- このテーマは複合要素が売りなので、単純な本文だけで成功判定しない。
- 表、Mermaid、数式、CJK 混在ページで崩れやすい。

### 6. `baseURL` / `relativeURLs` / `canonifyURLs`
- `hugo.toml` では `baseURL` が GitHub Pages 向けに設定されている。
- Docker でローカル確認する場合でも、この設定の影響を受けるので、URL の解決を確認する。

## 品質ゲート

### 最低限通すべき確認
1. `exampleSite` の Hugo ビルドが成功する。
2. PDF が生成される。
3. 生成した PDF を **ページ画像にレンダリングして、実際に目視する**。
4. 先頭ページ、目次ページ、CJK を含む本文ページ、表ページ、Mermaid / 数式ページを重点確認する。

### 目視確認で見るべき点
- 文字の欠け、豆腐、代替フォント化
- 行間・段落間隔の崩れ
- 表のセル崩れ、はみ出し、罫線の欠落
- ページ番号、ヘッダ、フッタの位置
- 画像の拡大縮小崩れ
- TOC / ブックマーク / 見出し階層の破綻

### 判定基準
- 「ファイルが生成された」だけでは不十分。
- **ページ画像を開いて、崩れていないことを確認して初めて合格**。

## おすすめの進め方

### まずやること
- 公式 Vivliostyle CLI Dockerfile の依存セットを参考に、Debian ベースの試作 Dockerfile を作る。
- その中で `exampleSite/package.json` の依存を入れる。
- `cd exampleSite && hugo --minify` を通す。
- PDF 出力を通す。
- 生成された PDF をページ画像にして、実際に見る。

### 失敗したら切り分ける順番
1. Hugo のビルド失敗か
2. Node 依存の失敗か
3. フォント解決の失敗か
4. Ghostscript / PDF 生成の失敗か
5. レイアウト品質の失敗か

## 参照したリポジトリ内情報
- `README.md`
- `exampleSite/package.json`
- `exampleSite/hugo.toml`
- `.github/workflows/gh-pages.yml`
- Vivliostyle CLI 公式 Dockerfile
- Vivliostyle CLI 公式 `build/fonts.conf`

