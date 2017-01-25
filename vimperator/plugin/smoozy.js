// smoozy.js
//
// LICENSE:
//   Copyright (c) 2009 snaka<snaka.gml@gmail.com>
//   Copyright (c) 2011 yuttie<yuta.taniguchi.y.t@gmail.com>
//
//     distributable under the terms of MIT license.
//     http://opensource.org/licenses/mit-license.php
//

liberator.plugins.smoozy = (function() {
  mappings.addUserMap(
    [modes.NORMAL],
    ["j", "<Down>"],
    "Smooth scroll down",
    function(count){
      smoothScrollBy(getScrollImpulse() * (count || 1));
    },
    {
      count: true
    }
  );
  mappings.addUserMap(
    [modes.NORMAL],
    ["k", "<Up>"],
    "Smooth scroll up",
    function(count){
      smoothScrollBy(getScrollImpulse() * -(count || 1));
    },
    {
      count: true
    }
  );
  mappings.addUserMap(
    [modes.NORMAL],
    ["<C-f>", "<PageDown>"],
    "Smooth scroll down",
    function(count){
      smoothScrollBy(2 * getScrollImpulse() * (count || 1));
    },
    {
      count: true
    }
  );
  mappings.addUserMap(
    [modes.NORMAL],
    ["<C-b>", "<PageUp>"],
    "Smooth scroll up",
    function(count){
      smoothScrollBy(2 * getScrollImpulse() * -(count || 1));
    },
    {
      count: true
    }
  );
  var PUBLICS = {
  }

  function getScrollImpulse()  { return window.eval(liberator.globalVariables.smoozy_scroll_impulse || '1000'); }
  function getScrollInterval() { return window.eval(liberator.globalVariables.smoozy_scroll_interval || '16.67'); }
  function getScrollFriction() { return window.eval(liberator.globalVariables.smoozy_scroll_friction || '5000'); }
  function getScrollAirDrag()  { return window.eval(liberator.globalVariables.smoozy_scroll_air_drag || '4'); }
  function smoothScrollBy(impulse) {
    win = Buffer.findScrollableWindow();
    applyImpulse(impulse, win);
  }

  function applyImpulse(impulse, win) {
    if (win.smoozyState) {
      var s = win.smoozyState;
      s.impulse += impulse;
    }
    else {
      win.smoozyState = {
        "impulse": impulse,
        "velocity": 0,
        "delta": 0
      };

      // start a thread
      var interval = getScrollInterval();
      var frictionCoef = getScrollFriction();
      var airDragCoef = getScrollAirDrag();
      var dt = interval / 1000;  // unit conversion: ms -> s
      function tick() {
        // update the state
        var s = win.smoozyState;
        var v_sign = s.velocity === 0 ? 0 : Math.abs(s.velocity) / s.velocity;
        var friction = -v_sign * frictionCoef * 1;  // mass is 1
        var airDrag = -s.velocity * airDragCoef;
        var additionalForce = friction + airDrag;
        s.delta += s.velocity * dt;
        s.velocity += s.impulse + (Math.abs(additionalForce * dt) > Math.abs(s.velocity) ? -s.velocity : additionalForce * dt);
        s.impulse = 0;

        // scroll
        var intDelta = s.delta >= 0 ? Math.floor(s.delta) : Math.ceil(s.delta);
        s.delta -= intDelta;
        var posBeforeScroll = win.scrollY;
        win.scrollBy(0, intDelta);
        var posAfterScroll = win.scrollY;
        var reachedBound = Math.abs(posAfterScroll - posBeforeScroll) < Math.abs(intDelta);

        // stop the thread or continue it
        if (Math.abs(s.velocity) < 1 || reachedBound) {
          win.smoozyState = null;
        }
        else {
          setTimeout(tick, interval);
        }
      }
      setTimeout(tick, interval);
    }
  }

  return PUBLICS;
})();
// vim: sw=2 ts=2 et si fdm=marker:
