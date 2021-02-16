// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

// listen on document.body, so it's executed before the default of
// phoenix_html, which is listening on the window object
document.body.addEventListener('phoenix.link.click', function (e) {
  // Prevent default implementation
  e.stopPropagation();

  // Introduce alternative implementation
  var message = e.target.getAttribute("data-confirm");
  if (!message) { return true; }
  vex.dialog.confirm({
    message: message,
    callback: function (value) {
      if (value == false) { e.preventDefault(); }
    }
  })
}, false);
