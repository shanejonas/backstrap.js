//  Copyright (c) 2011 Alex MacCaw (info@eribium.org)
//  
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
define( function(require, exports, module){
  var $ = require('jquery');

  // tap lib from Spine
  (function() {
    var $, m, parentIfText, swipeDirection, touch, types, _fn, _i, _len;
    $ = jQuery;
    $.support.touch = 'ontouchstart' in window;
    touch = {};
    parentIfText = function(node) {
      if ('tagName' in node) {
        return node;
      } else {
        return node.parentNode;
      }
    };
    swipeDirection = function(x1, x2, y1, y2) {
      var xDelta, yDelta;
      xDelta = Math.abs(x1 - x2);
      yDelta = Math.abs(y1 - y2);
      if (xDelta >= yDelta) {
        if (x1 - x2 > 0) {
          return 'Left';
        } else {
          return 'Right';
        }
      } else {
        if (y1 - y2 > 0) {
          return 'Up';
        } else {
          return 'Down';
        }
      }
    };
    $(function() {
      return $('body').bind('touchstart', function(e) {
        var delta, now;
        e = e.originalEvent;
        now = Date.now();
        delta = now - (touch.last || now);
        touch.target = parentIfText(e.touches[0].target);
        touch.x1 = e.touches[0].pageX;
        touch.y1 = e.touches[0].pageY;
        return touch.last = now;
      }).bind('touchmove', function(e) {
        e = e.originalEvent;
        touch.x2 = e.touches[0].pageX;
        return touch.y2 = e.touches[0].pageY;
      }).bind('touchend', function(e) {
        e = e.originalEvent;
        if (touch.x2 > 0 || touch.y2 > 0) {
          (Math.abs(touch.x1 - touch.x2) > 30 || Math.abs(touch.y1 - touch.y2) > 30) && $(touch.target).trigger('swipe') && $(touch.target).trigger('swipe' + (swipeDirection(touch.x1, touch.x2, touch.y1, touch.y2)));
          return touch.x1 = touch.x2 = touch.y1 = touch.y2 = touch.last = 0;
        } else if ('last' in touch) {
          $(touch.target).trigger('tap');
          return touch = {};
        }
      }).bind('touchcancel', function(e) {
        return touch = {};
      });
    });
    if ($.support.touch) {
      $('body').bind('click', function(e) {
        return e.preventDefault();
      });
    } else {
      $(function() {
        return $('body').bind('click', function(e) {
          return $(e.target).trigger('tap');
        });
      });
    }
    types = ['swipe', 'swipeLeft', 'swipeRight', 'swipeUp', 'swipeDown', 'tap'];
    _fn = function(m) {
      return $.fn[m] = function(callback) {
        return this.bind(m, callback);
      };
    };
    for (_i = 0, _len = types.length; _i < _len; _i++) {
      m = types[_i];
      _fn(m);
    }
  }).call(this);
  
});

