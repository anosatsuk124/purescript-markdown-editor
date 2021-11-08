const MarkdownIt = require('markdown-it');

exports.markdownIt = (markdown) => {
  const md = new MarkdownIt();
  return md.render( markdown );
}
