---
pdfname : 'UserGuide' # PDF名称：サイト内で一意である必要があります
doctitle: 'Hugo-theme-vivliocli' # タイトル：PDF表紙のタイトル
subtitle: 'User Guide' # サブタイトル：PDF表紙のサブタイトル
#doc_number: 'doc-number' # 文書番号：PDF表紙の文書番号
header: '2023/4/7' # ヘッダー1：PDF表紙右上ヘッダー1行目
#header2: 'header2' # ヘッダー2：PDF表紙右上ヘッダー2行目
#footer-left: 'left' # 左フッター：PDF表紙左下フッター
footer-center: 'v0.16.1' # 中央フッター：PDF表紙中央フッター
#footer-right: 'right' # 右フッター：PDF表紙右下フッター
author: 'mochimo' # 著者：PDF表紙著者名
#company: 'Company' # 社名：PDF表紙社名
#logo: 'img/logo.png' # ロゴ：PDF表紙左上ロゴ
pagesize: 'A5' # PDFサイズ：A5 / A4 / A3 / A4 landscape / A3 landscape
book: true # true:書籍スタイル false:シンプルスタイル
marks: false # true:トンボを出力するスタイル
cover: true # 表紙を出力するか
toc: true # 目次を出力するか
sectionNumberLevel: 2 # 章節番号の出力レベル
colophon: true # 奥付を出力するか：trueの場合_colophon.mdが必要です。
outputs: # VivlioCLI用Config出力：基本的に編集しません。
- vivlio_cover
- vivlio_config
---
