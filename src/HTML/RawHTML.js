exports.unsafeSetInnerHTML = (element) => {
  return (html) => {
    return () => {
      element.innerHTML = html;
    };
  };
};
