module.exports = {
  title: 'Hugo-theme-vivliocli',
  author: 'mochimo',
  size: 'A4',
  workspaceDir: '.',
  entry: [
    
    '../ja/twoColumns/sample.html',
  ],
  static: { '/': ['..'] },
  output: [
    'TwoColumns.pdf'
  ]
}
