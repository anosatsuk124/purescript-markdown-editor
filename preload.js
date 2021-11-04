// All of the Node.js APIs are available in the preload process.
// It has the same sandbox as a Chrome extension.
const {remote,contextBridge} =  require('electron');
// const MarkdownIt = require("markdown-it")
// 
// contextBridge.exposeInMainWorld('markdownit', {
//     MarkdownIt: (md) => {
//       const app = new MarkdownIt();
//       return app.render(md);
//   },
//   }
// )
