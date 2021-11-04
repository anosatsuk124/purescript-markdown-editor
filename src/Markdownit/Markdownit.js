exports.markdownIt = (markdown) => {
  const md = window.markdownit();
  const result = md.render( markdown );
  return result;
}
