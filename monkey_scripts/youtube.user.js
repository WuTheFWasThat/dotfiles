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
function toggleCustomStyle() {
  const styleElemId = 'yt-custom-style';
  const styleEl = document.getElementById(styleElemId);
  if (styleEl) {
    styleEl.parentNode.removeChild(styleEl);
  } else {
    addStyle(`
      .html5-video-player.playing-mode {
        position: fixed;
        left: 0;
        bottom: 0px;
      }
      .playing-mode .html5-video-container {
        width: 100% !important;
        height: 100% !important;
      }
      .playing-mode .html5-main-video {
        width: 100% !important;
        height: 100% !important;
        left: 0px !important;
      }
      #masthead-positioner {
        z-index: 0 !important;
      }
    `, styleElemId);
  }
}

// toggle once by default
toggleCustomStyle();

function togglePlay() {
  $('.ytp-play-button').click();
}

document.addEventListener("keydown", function(e) {
  var keyCode = e.keyCode;
  if (keyCode === 13) { // enter
    toggleCustomStyle();
  } else if (keyCode === 0 || keyCode === 32) { // space
    togglePlay();
  }
}, false);

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
