module.exports = {
  title: 'Hugo-theme-vivliocli',
  author: 'mochimo',
  size: 'letter',
  entry: [
    '_pdf.vivlio.cover.html',
    
    '../en/Manual/GettingStarted.html',
    '../en/Manual/MarkdownShowcase.html',
    '../en/Manual/frontmatter.html',
    '../en/Manual/config.html',
    '../en/Manual/pdfconfig.html',
    '../en/Manual/edition.html',
    '../en/Manual/Tags.html',
    '_pdfcolophon.vivlio.colophon.html'
  ],
  output: [
    'UserGuide.pdf'
  ]
}
