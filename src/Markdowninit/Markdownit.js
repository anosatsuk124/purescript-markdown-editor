exports.markdownit = () => {
  const MarkdownIt = require("markdown-it");
  return new MarkdownIt();
}

exports.render = (app) => { return (md) => {
  return app.render(md);
}}
