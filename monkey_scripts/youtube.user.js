// ==UserScript==
// @name         Youtube-mini-fullscreen
// @namespace    wuthefwasthat
// @version      0.1
// @description  Youtube mini-fullscreen
// @match        *://www.youtube.com/watch*
// @copyright    2017+, You
// @grant        none
// ==/UserScript==

function addStyle(style_str, id) {
  var el = document.createElement('style');
  el.type = "text/css";
  if (id) el.id = id;
  if (el.styleSheet) { el.styleSheet.cssText = str; } // IE only
  else { el.appendChild(document.createTextNode(style_str)); }
  document.head.appendChild(el);
}

// TODO: make this work for all widths
function toggleVideo() {
  const styleElemId = 'yt-custom-style';
  const styleEl = document.getElementById(styleElemId);
  if (styleEl) {
    styleEl.parentNode.removeChild(styleEl);
  } else {
    addStyle(`
      #content {
        min-width: none !important;
        max-width: none !important;
      }
      .html5-main-video {
        width: 100% !important;
        height: 100% !important;
        left: 0px !important;
      }
      .html5-video-container {
        width: 100% !important;
        height: 100% !important;
      }
      .html5-video-player {
        position: fixed;
      }
    `, styleElemId);
  }
}

// toggle once by default
toggleVideo();
document.addEventListener("keydown", function(e) {
  var keyCode = e.keyCode;
  if (keyCode === 13) { // enter
    toggleVideo();
  }
}, false);

/*
function loadScript(src, callback) {
  var el = document.createElement('script');
  el.src = src;
  el.onload = callback;
  document.head.appendChild(el);
}

function loadJquery(callback) {
  loadScript('//code.jquery.com/jquery-latest.min.js', function() {
    jQuery.noConflict();
    callback(jQuery);
  });
}

loadJquery(function($) {
  window.$ = $;
});
*/
