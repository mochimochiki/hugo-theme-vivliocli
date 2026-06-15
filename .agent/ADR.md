# ADR

## ADR-260614-03: PDFParam の親PDF判定をURLベースからFileパスベースに変更
**背景** : uglyURLs=false にすると getRootPDFParam.html の第2条件 `in ($thisPage.RelPermalink) ($pdf.RelPermalink | path.Dir)` が壊れ、MarkdownShowcase.md で PDFParam が doctitle/subtitle/author を not found とし errorf でビルド失敗。原因はURL文字列比較が uglyURLs の有無で `/Manual/`(true時) と `/Manual/_pdf`(false時) に変化するため。
**決定** : 第2条件を File パスベース `hasPrefix $thisPage.File.Path $pdf.File.Dir`(nil ガード付き)に変更。
**理由** : File パスは uglyURLs に依存しないため、プレビュー(false)とPDF生成(true)の両方で正しく親PDFを判定できる。getRootPDFList は現在言語の .Site.Home から辿るため言語混在の誤マッチもなし。両 uglyURLs でビルド警告ゼロ・doctitle 解決を検証済み。
**備考** : テーマのコアショートコードロジック変更。ADR-260614-02 と併せてプレビュー無限リロードを解消。

## ADR-260614-02: uglyURLs をプレビュー時のみ無効化（自己参照エイリアス回避）
**背景** : Hugo v0.163 で uglyurls=true + defaultContentLanguageInSubdir=true の組合せが、ホーム /en/index.html に自己参照 meta refresh エイリアスを生成し、プレビュー(hugo server)でブラウザが無限リロード(真っ白)になった。v0.121 では発生せず。実HTTPで /en/ がエイリアスHTMLを返すことを確認。
**決定** : uglyurls は PDF生成(Vivliostyle が file:// で `../en/Manual/` フォルダURLを読むため)に必須なので hugo.toml では true のまま残し、Preview.bat に `set HUGO_UGLYURLS=false` を追加してプレビュー時のみ無効化。
**理由** : relativeURLs/defaultContentLanguageInSubdir は両環境で必須、uglyURLs のみ環境別。既存の HUGO_PARAMS_ISPDF 分離パターンに倣い環境変数で上書き。最小変更で済み PDF設定は無傷。
**備考** : canonifyURLs=true もプレビューで副作用懸念ありだが今回は未変更。将来 config 分割(config/preview.toml)でクリーン化する選択肢あり。
**追記** : `disableDefaultSiteRedirect = true`(hugo.toml)により自己参照エイリアス自体が生成されなくなったため、本ADRの `HUGO_UGLYURLS=false` 上書きは不要と判明。Preview.bat には未適用、docker-compose.yml の preview サービスからも削除済み。uglyurls は両環境で true のまま統一。

## ADR-260614-01: vivlioカスタム出力フォーマットのテンプレートを明示出力フォーマット指定子で認識させる
**背景** : Hugo v0.163 でマルチドットsuffix(`vivlio.cover.html`等)のカスタム出力フォーマットのテンプレートが認識されず警告が出た。回避策としてメディアタイプに secondary suffix `html`/`js` を足したが、`.html` の Content-Type 逆引きが `text/vivlio_cover`(isPlainText) に汚染され、通常HTMLページがブラウザでソース生表示される副作用が発生(実HTTPヘッダで確認)。
**決定** : メディアタイプの suffix を第1suffixのみ(`["vivlio.cover.html"]`等)に戻し、テンプレートを明示出力フォーマット指定子名 `layouts/_default/single._outputformat_vivlio_cover_.html`(config/colophon同様)にリネーム。
**理由** : Hugo の pathparser は `._outputformat_<name>_.` 形式で `IsOutputFormat(value, "")` を ext="" で呼ぶため `HasSuffix` チェックをスキップし、suffixに`html`を含めずともテンプレートを認識する。出力ファイル名は第1suffixの`FirstSuffix`で決まるため `_pdf.vivlio.cover.html` 等を維持。通常ページの Content-Type は `text/html` に戻る。両立を実HTTPヘッダ+ビルド警告ゼロで検証済み。
**備考** : `._outputformat_X_.` 指定子は v0.163.1 ソース実装(common/paths/pathparser.go)に基づく機構で公式ドキュメント未記載。将来の仕様変更時は要再検証。代替案: secondary suffix維持+プレビュー時vivlio出力抑止。
