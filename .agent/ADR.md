# ADR

## ADR-260825-01: Vivliostyle 設定に workspaceDir と static を指定する
**背景** : Vivliostyle CLI は v9 で内部が Vite ベースの HTTP サーバに作り変わり、entry の HTML を `<設定ファイルの階層>/.vivliostyle/` へ複製してから配信するようになった。テーマが出力する PDF 用ページは CSS を `../../css/style-main.css` と相対参照するため、複製先から見るとサーバのルートより外に出て読めない。**エラーは出ず、無スタイルの PDF が黙って生成される**。exampleSite の ja/UserGuide で実測すると、埋め込みフォントが本文用サンセリフ(LiberationSans)からブラウザ既定のセリフ(LiberationSerif)に変わり、38ページが40ページになった。
**決定** : 生成する設定ファイルに `workspaceDir: '.'` と `static: { '/': ['..'] }` の2行を加える。entry / output のパスは従来のまま(`'../<言語>/...'`)。
**理由** : `workspaceDir: '.'` で複製をやめてその場配信にし、`static` で公開ディレクトリ全体をサーバのルートとして配信させれば相対参照が届く。設定ファイルは collect_config が `<公開先>/<言語>/` へ集約するので `'..'` が公開ルートにあたる。CI スクリプト(collect_config / run_vivlio / build_pdf.sh / Windows の ps1)は変更不要。CLI 8.20.0 と 11.2.0 の両方で exampleSite の PDF がページ数・埋め込みフォントとも一致することを確認済みで、バージョン更新と切り離して先に入れられる。
**備考** : 別解として、設定ファイルを公開ルートへ集約しパスに言語コードを付ける書き方もある(別環境で先行採用されていた形)。同じ効果だが集約先・フラット名・作業ディレクトリ・言語ループを作り直す必要があり、今回は採らなかった。副作用として設定ファイルと同じ階層に `publication.json` が生成されるが、`public_*/` は gitignore 済み。

## ADR-260806-02: メニューを1ファイルに書き出し、script タグで各ページに配る
**背景** : メニューは partialCached で1度しか組み立てていないが、出来上がったHTMLを全ページに埋め込むため、2500ページでは1ページ336KBのうち328KBがメニューになっていた。実測でビルド時間の約75%、`hugo server` 初回起動の約76%、出力量の97%を占める。
**決定** : ツリー本体を `js/menu-tree-<言語>.js` に1度だけ書き出し、各ページには空の `<nav>` と `<script src>` だけを置く。`params.legacy_menu = true` で従来の埋め込みに戻せる。
**理由** : 2500ページ実測でビルド 12.25秒 → 3.70秒(中央値)、プレビュー初回起動 11.7〜15.4秒 → 3.4〜4.0秒、出力 815MB → 34MB。ブラウザ描画後のDOMは従来と完全一致。
**備考** : `fetch` は `file:` で CORS に阻まれるが、古典的な `<script src>` は対象外で上位階層も読める(Chromium で確認)。サイトのルートURLは `document.currentScript.src` から実行時に割り出すため、ページごとの相対パスを埋め込む必要がなく、uglyurls / relativeURLs のどの組合せでも同じ1本で足りる。`legacy_menu = true` の出力は origin/main とバイト単位で一致(2500ページ2504ファイル / exampleSite 51ファイル、`now` ショートコードの時刻を除く)。PDFモード(isPDF=true)は元々メニューを出さないため出力不変。

## ADR-260806-01: 大規模サイトの計測に --templateMetrics を使わない
**背景** : 2500ページでメニューの寄与を切り分けようとして `--templateMetrics --templateMetricsHints` を使ったが、実測1.6秒で終わるビルドでも `single.html` の cumulative が13.7秒と出た。
**決定** : ページ数の多いサイトの内訳調査に templateMetrics の cumulative / average を使わない。テンプレートを差し替えた版を用意し、ビルド全体を外から複数回測って比べる。
**理由** : cumulative は各テンプレートの経過時間をゴルーチンごとに合算した値で、並列実行の待ち時間を含む。並列度とメモリ確保の圧力が上がるほど実際の処理時間から離れ、順位すら入れ替わる。
**備考** : 小規模サイトでは目安になる。今回は「メニューを出さない版」を作って比較する方法に切り替え、11.9〜13.4秒 対 3.3〜3.8秒 という切り分けを得た。

## ADR-260805-02: partialCached の variant にページごとの値を渡さない
**背景** : 章節番号の走査を速くするため isShow を `.RelPermalink` キーで partialCached 化したところ、1000ページ超で main の11倍(86秒)に悪化した。
**決定** : partialCached の variant にページ固有の値を渡さない。isShow は素の partial に戻す。テーマ全体のルールとする。
**理由** : Hugo の partial キャッシュは1言語あたり1000件のLRU(tpl/partials/partials.go の MaxEntries: 1000)。ページ単位のキーで溢れ、menu-toc や章節番号の対応表まで押し出されて作り直しになる。
**備考** : 1000ページ未満では速くなるため小規模サイトの検証をすり抜ける。1062ページ実測で 86.4秒 → 2.9秒(main 7.5秒)。

## ADR-260805-01: 章節番号をサイト全体で1度だけ計算する方式に変更
**背景** : getSectionNoRaw がページ1枚ごとに `.Site.Home` からツリーを歩き直し、1ページにつき3回呼ばれていた。同じ階層のページ数に比例するためフラット構成で O(ページ数^2) になっていた。
**決定** : getSectionNoMap で全ページ分の対応表を1度だけ構築し、getSectionNoRaw と menu-toc はそれを引くだけにする。
**理由** : 走査回数がページ数に依存しなくなる。2052ページ実測で 21.7秒 → 7.6秒。フォルダの切り方でビルド時間が変わる性質も消える。
**備考** : 出力は変更前とバイト単位で一致(合成2000ページ2221ファイル / exampleSite 120ファイル)。

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

## ADR-260614-01: vivlioカスタム出力フォーマットのテンプレートを明示出力フォーマット指定子で認識させる
**背景** : Hugo v0.163 でマルチドットsuffix(`vivlio.cover.html`等)のカスタム出力フォーマットのテンプレートが認識されず警告が出た。回避策としてメディアタイプに secondary suffix `html`/`js` を足したが、`.html` の Content-Type 逆引きが `text/vivlio_cover`(isPlainText) に汚染され、通常HTMLページがブラウザでソース生表示される副作用が発生(実HTTPヘッダで確認)。
**決定** : メディアタイプの suffix を第1suffixのみ(`["vivlio.cover.html"]`等)に戻し、テンプレートを明示出力フォーマット指定子名 `layouts/_default/single._outputformat_vivlio_cover_.html`(config/colophon同様)にリネーム。
**理由** : Hugo の pathparser は `._outputformat_<name>_.` 形式で `IsOutputFormat(value, "")` を ext="" で呼ぶため `HasSuffix` チェックをスキップし、suffixに`html`を含めずともテンプレートを認識する。出力ファイル名は第1suffixの`FirstSuffix`で決まるため `_pdf.vivlio.cover.html` 等を維持。通常ページの Content-Type は `text/html` に戻る。両立を実HTTPヘッダ+ビルド警告ゼロで検証済み。
**備考** : `._outputformat_X_.` 指定子は v0.163.1 ソース実装(common/paths/pathparser.go)に基づく機構で公式ドキュメント未記載。将来の仕様変更時は要再検証。代替案: secondary suffix維持+プレビュー時vivlio出力抑止。
