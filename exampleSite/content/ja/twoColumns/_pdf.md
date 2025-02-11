---
pdfname : 'TwoColumns' # PDF名称：サイト内で一意である必要があります
doctitle: 'Hugo-theme-vivliocli' # タイトル：PDF表紙のタイトル
subtitle: 'TwoColumns Sample' # サブタイトル：PDF表紙のサブタイトル
#doc_number: 'doc-number' # 文書番号：PDF表紙の文書番号
header: '{{% now "2006/01/02" %}}' # ヘッダー1：PDF表紙右上ヘッダー1行目
author: 'mochimo' # 著者：PDF表紙著者名
pagesize: 'A4' # PDFサイズ：A5 / A4 / A3 / A4 landscape / A3 landscape
book: false # true:書籍スタイル false:シンプルスタイル
marks: false # true:トンボを出力するスタイル
cover: false # 表紙を出力するか
toc: false # 目次を出力するか
sectionNumberLevel: -1 # 章節番号の出力レベル
colophon: false # 奥付を出力するか：trueの場合_colophon.mdが必要です。
outputs: # VivlioCLI用Config出力：基本的に編集しません。
- vivlio_cover
- vivlio_config
---
