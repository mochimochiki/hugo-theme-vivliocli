module.exports = {
  title: 'Test',
  author: 'auther',
  size: 'A4',
  entry: [
    '_pdf.vivlio.cover.html',
    
    '../ja/Test/TestChapter1/00_test.html',
    '../ja/Test/TestChapter1/01_日本語ファイル.html',
    '../ja/Test/TestChapter1/02_pageTOC.html',
    '../ja/Test/TestChapter1/03_include.html',
    '../ja/Test/TestChapter1/04_ShowIfHideIfShortCode.html',
    '../ja/Test/TestChapter1/05_ShowIfFrontMatter.html',
    '../ja/Test/TestChapter1/07_TableOfContents.html',
    '../ja/Test/TestChapter1/08_pagebreak.html',
    '../ja/Test/TestChapter1/09_ImageResize.html',
    '../ja/Test/TestChapter1/10_MathJax.html',
    '../ja/Test/TestChapter1/11_2columns.html',
    '../ja/Test/TestChapter1/12_2columns_2.html',
    '../ja/Test/TestChapter1/13_Tags.html',
  ],
  output: [
    'Test.pdf'
  ]
}
