module.exports = {
  title: 'Hugo-theme-vivliocli',
  author: 'mochimo',
  size: 'A5',
  entry: [
    '_pdf.vivlio.cover.html',
    
    '../ja/Manual/GettingStarted.html',
    '../ja/Manual/MarkdownShowcase.html',
    '../ja/Manual/frontmatter.html',
    '../ja/Manual/config.html',
    '../ja/Manual/pdfconfig.html',
    '../ja/Manual/edition.html',
    '../ja/Manual/Tags.html',
    '_pdfcolophon.vivlio.colophon.html'
  ],
  output: [
    'UserGuide.pdf'
  ]
}
