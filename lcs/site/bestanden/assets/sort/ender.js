/*!
  * =============================================================
  * Ender: open module JavaScript framework (https://ender.no.de)
  * Build: ender build domready qwery bean formwatcher formwatcher-hint
  * Packages: ender-js@0.4.5 domready@0.2.11 qwery@3.4.1 bean@1.0.3 bonzo@1.3.5 reqwest@0.7.3 morpheus@0.6.7 ender-json@1.1.0 formwatcher@2.1.9 formwatcher-hint@2.1.9
  * =============================================================
  */

/*!
  * Ender: open module JavaScript framework (client-lib)
  * copyright Dustin Diaz & Jacob Thornton 2011-2012 (@ded @fat)
  * http://ender.jit.su
  * License MIT
  */
(function (context) {

  // a global object for node.js module compatiblity
  // ============================================

  context['global'] = context

  // Implements simple module system
  // losely based on CommonJS Modules spec v1.1.1
  // ============================================

  var modules = {}
    , old = context['$']
    , oldEnder = context['ender']
    , oldRequire = context['require']
    , oldProvide = context['provide']

  function require (identifier) {
    // modules can be required from ender's build system, or found on the window
    var module = modules['$' + identifier] || window[identifier]
    if (!module) throw new Error("Ender Error: Requested module '" + identifier + "' has not been defined.")
    return module
  }

  function provide (name, what) {
    return (modules['$' + name] = what)
  }

  context['provide'] = provide
  context['require'] = require

  function aug(o, o2) {
    for (var k in o2) k != 'noConflict' && k != '_VERSION' && (o[k] = o2[k])
    return o
  }

  /**
   * main Ender return object
   * @constructor
   * @param {Array|Node|string} s a CSS selector or DOM node(s)
   * @param {Array.|Node} r a root node(s)
   */
  function Ender(s, r) {
    var elements
      , i

    this.selector = s
    // string || node || nodelist || window
    if (typeof s == 'undefined') {
      elements = []
      this.selector = ''
    } else if (typeof s == 'string' || s.nodeName || (s.length && 'item' in s) || s == window) {
      elements = ender._select(s, r)
    } else {
      elements = isFinite(s.length) ? s : [s]
    }
    this.length = elements.length
    for (i = this.length; i--;) this[i] = elements[i]
  }

  /**
   * @param {function(el, i, inst)} fn
   * @param {Object} opt_scope
   * @returns {Ender}
   */
  Ender.prototype['forEach'] = function (fn, opt_scope) {
    var i, l
    // opt out of native forEach so we can intentionally call our own scope
    // defaulting to the current item and be able to return self
    for (i = 0, l = this.length; i < l; ++i) i in this && fn.call(opt_scope || this[i], this[i], i, this)
    // return self for chaining
    return this
  }

  Ender.prototype.$ = ender // handy reference to self

  // dev tools secret sauce
  Ender.prototype.splice = function () { throw new Error('Not implemented') }

  function ender(s, r) {
    return new Ender(s, r)
  }

  ender['_VERSION'] = '0.4.5'

  ender.fn = Ender.prototype // for easy compat to jQuery plugins

  ender.ender = function (o, chain) {
    aug(chain ? Ender.prototype : ender, o)
  }

  ender._select = function (s, r) {
    if (typeof s == 'string') return (r || document).querySelectorAll(s)
    if (s.nodeName) return [s]
    return s
  }


  // use callback to receive Ender's require & provide and remove them from global
  ender.noConflict = function (callback) {
    context['$'] = old
    if (callback) {
      context['provide'] = oldProvide
      context['require'] = oldRequire
      context['ender'] = oldEnder
      if (typeof callback == 'function') callback(require, provide, this)
    }
    return this
  }

  if (typeof module !== 'undefined' && module.exports) module.exports = ender
  // use subscript notation as extern for Closure compilation
  context['ender'] = context['$'] = ender

}(this));

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*!
    * domready (c) Dustin Diaz 2012 - License MIT
    */
  !function (name, definition) {
    if (typeof module != 'undefined') module.exports = definition()
    else if (typeof define == 'function' && typeof define.amd == 'object') define(definition)
    else this[name] = definition()
  }('domready', function (ready) {

    var fns = [], fn, f = false
      , doc = document
      , testEl = doc.documentElement
      , hack = testEl.doScroll
      , domContentLoaded = 'DOMContentLoaded'
      , addEventListener = 'addEventListener'
      , onreadystatechange = 'onreadystatechange'
      , readyState = 'readyState'
      , loaded = /^loade|c/.test(doc[readyState])

    function flush(f) {
      loaded = 1
      while (f = fns.shift()) f()
    }

    doc[addEventListener] && doc[addEventListener](domContentLoaded, fn = function () {
      doc.removeEventListener(domContentLoaded, fn, f)
      flush()
    }, f)


    hack && doc.attachEvent(onreadystatechange, fn = function () {
      if (/^c/.test(doc[readyState])) {
        doc.detachEvent(onreadystatechange, fn)
        flush()
      }
    })

    return (ready = hack ?
      function (fn) {
        self != top ?
          loaded ? fn() : fns.push(fn) :
          function () {
            try {
              testEl.doScroll('left')
            } catch (e) {
              return setTimeout(function() { ready(fn) }, 50)
            }
            fn()
          }()
      } :
      function (fn) {
        loaded ? fn() : fns.push(fn)
      })
  })
  if (typeof provide == "function") provide("domready", module.exports);

  !function ($) {
    var ready = require('domready')
    $.ender({domReady: ready})
    $.ender({
      ready: function (f) {
        ready(f)
        return this
      }
    }, true)
  }(ender);
}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*!
    * @preserve Qwery - A Blazing Fast query selector engine
    * https://github.com/ded/qwery
    * copyright Dustin Diaz 2012
    * MIT License
    */

  (function (name, context, definition) {
    if (typeof module != 'undefined' && module.exports) module.exports = definition()
    else if (typeof define == 'function' && define.amd) define(definition)
    else context[name] = definition()
  })('qwery', this, function () {
    var doc = document
      , html = doc.documentElement
      , byClass = 'getElementsByClassName'
      , byTag = 'getElementsByTagName'
      , qSA = 'querySelectorAll'
      , useNativeQSA = 'useNativeQSA'
      , tagName = 'tagName'
      , nodeType = 'nodeType'
      , select // main select() method, assign later

      , id = /#([\w\-]+)/
      , clas = /\.[\w\-]+/g
      , idOnly = /^#([\w\-]+)$/
      , classOnly = /^\.([\w\-]+)$/
      , tagOnly = /^([\w\-]+)$/
      , tagAndOrClass = /^([\w]+)?\.([\w\-]+)$/
      , splittable = /(^|,)\s*[>~+]/
      , normalizr = /^\s+|\s*([,\s\+\~>]|$)\s*/g
      , splitters = /[\s\>\+\~]/
      , splittersMore = /(?![\s\w\-\/\?\&\=\:\.\(\)\!,@#%<>\{\}\$\*\^'"]*\]|[\s\w\+\-]*\))/
      , specialChars = /([.*+?\^=!:${}()|\[\]\/\\])/g
      , simple = /^(\*|[a-z0-9]+)?(?:([\.\#]+[\w\-\.#]+)?)/
      , attr = /\[([\w\-]+)(?:([\|\^\$\*\~]?\=)['"]?([ \w\-\/\?\&\=\:\.\(\)\!,@#%<>\{\}\$\*\^]+)["']?)?\]/
      , pseudo = /:([\w\-]+)(\(['"]?([^()]+)['"]?\))?/
      , easy = new RegExp(idOnly.source + '|' + tagOnly.source + '|' + classOnly.source)
      , dividers = new RegExp('(' + splitters.source + ')' + splittersMore.source, 'g')
      , tokenizr = new RegExp(splitters.source + splittersMore.source)
      , chunker = new RegExp(simple.source + '(' + attr.source + ')?' + '(' + pseudo.source + ')?')

    var walker = {
        ' ': function (node) {
          return node && node !== html && node.parentNode
        }
      , '>': function (node, contestant) {
          return node && node.parentNode == contestant.parentNode && node.parentNode
        }
      , '~': function (node) {
          return node && node.previousSibling
        }
      , '+': function (node, contestant, p1, p2) {
          if (!node) return false
          return (p1 = previous(node)) && (p2 = previous(contestant)) && p1 == p2 && p1
        }
      }

    function cache() {
      this.c = {}
    }
    cache.prototype = {
      g: function (k) {
        return this.c[k] || undefined
      }
    , s: function (k, v, r) {
        v = r ? new RegExp(v) : v
        return (this.c[k] = v)
      }
    }

    var classCache = new cache()
      , cleanCache = new cache()
      , attrCache = new cache()
      , tokenCache = new cache()

    function classRegex(c) {
      return classCache.g(c) || classCache.s(c, '(^|\\s+)' + c + '(\\s+|$)', 1)
    }

    // not quite as fast as inline loops in older browsers so don't use liberally
    function each(a, fn) {
      var i = 0, l = a.length
      for (; i < l; i++) fn(a[i])
    }

    function flatten(ar) {
      for (var r = [], i = 0, l = ar.length; i < l; ++i) arrayLike(ar[i]) ? (r = r.concat(ar[i])) : (r[r.length] = ar[i])
      return r
    }

    function arrayify(ar) {
      var i = 0, l = ar.length, r = []
      for (; i < l; i++) r[i] = ar[i]
      return r
    }

    function previous(n) {
      while (n = n.previousSibling) if (n[nodeType] == 1) break;
      return n
    }

    function q(query) {
      return query.match(chunker)
    }

    // called using `this` as element and arguments from regex group results.
    // given => div.hello[title="world"]:foo('bar')
    // div.hello[title="world"]:foo('bar'), div, .hello, [title="world"], title, =, world, :foo('bar'), foo, ('bar'), bar]
    function interpret(whole, tag, idsAndClasses, wholeAttribute, attribute, qualifier, value, wholePseudo, pseudo, wholePseudoVal, pseudoVal) {
      var i, m, k, o, classes
      if (this[nodeType] !== 1) return false
      if (tag && tag !== '*' && this[tagName] && this[tagName].toLowerCase() !== tag) return false
      if (idsAndClasses && (m = idsAndClasses.match(id)) && m[1] !== this.id) return false
      if (idsAndClasses && (classes = idsAndClasses.match(clas))) {
        for (i = classes.length; i--;) if (!classRegex(classes[i].slice(1)).test(this.className)) return false
      }
      if (pseudo && qwery.pseudos[pseudo] && !qwery.pseudos[pseudo](this, pseudoVal)) return false
      if (wholeAttribute && !value) { // select is just for existance of attrib
        o = this.attributes
        for (k in o) {
          if (Object.prototype.hasOwnProperty.call(o, k) && (o[k].name || k) == attribute) {
            return this
          }
        }
      }
      if (wholeAttribute && !checkAttr(qualifier, getAttr(this, attribute) || '', value)) {
        // select is for attrib equality
        return false
      }
      return this
    }

    function clean(s) {
      return cleanCache.g(s) || cleanCache.s(s, s.replace(specialChars, '\\$1'))
    }

    function checkAttr(qualify, actual, val) {
      switch (qualify) {
      case '=':
        return actual == val
      case '^=':
        return actual.match(attrCache.g('^=' + val) || attrCache.s('^=' + val, '^' + clean(val), 1))
      case '$=':
        return actual.match(attrCache.g('$=' + val) || attrCache.s('$=' + val, clean(val) + '$', 1))
      case '*=':
        return actual.match(attrCache.g(val) || attrCache.s(val, clean(val), 1))
      case '~=':
        return actual.match(attrCache.g('~=' + val) || attrCache.s('~=' + val, '(?:^|\\s+)' + clean(val) + '(?:\\s+|$)', 1))
      case '|=':
        return actual.match(attrCache.g('|=' + val) || attrCache.s('|=' + val, '^' + clean(val) + '(-|$)', 1))
      }
      return 0
    }

    // given a selector, first check for simple cases then collect all base candidate matches and filter
    function _qwery(selector, _root) {
      var r = [], ret = [], i, l, m, token, tag, els, intr, item, root = _root
        , tokens = tokenCache.g(selector) || tokenCache.s(selector, selector.split(tokenizr))
        , dividedTokens = selector.match(dividers)

      if (!tokens.length) return r

      token = (tokens = tokens.slice(0)).pop() // copy cached tokens, take the last one
      if (tokens.length && (m = tokens[tokens.length - 1].match(idOnly))) root = byId(_root, m[1])
      if (!root) return r

      intr = q(token)
      // collect base candidates to filter
      els = root !== _root && root[nodeType] !== 9 && dividedTokens && /^[+~]$/.test(dividedTokens[dividedTokens.length - 1]) ?
        function (r) {
          while (root = root.nextSibling) {
            root[nodeType] == 1 && (intr[1] ? intr[1] == root[tagName].toLowerCase() : 1) && (r[r.length] = root)
          }
          return r
        }([]) :
        root[byTag](intr[1] || '*')
      // filter elements according to the right-most part of the selector
      for (i = 0, l = els.length; i < l; i++) {
        if (item = interpret.apply(els[i], intr)) r[r.length] = item
      }
      if (!tokens.length) return r

      // filter further according to the rest of the selector (the left side)
      each(r, function (e) { if (ancestorMatch(e, tokens, dividedTokens)) ret[ret.length] = e })
      return ret
    }

    // compare element to a selector
    function is(el, selector, root) {
      if (isNode(selector)) return el == selector
      if (arrayLike(selector)) return !!~flatten(selector).indexOf(el) // if selector is an array, is el a member?

      var selectors = selector.split(','), tokens, dividedTokens
      while (selector = selectors.pop()) {
        tokens = tokenCache.g(selector) || tokenCache.s(selector, selector.split(tokenizr))
        dividedTokens = selector.match(dividers)
        tokens = tokens.slice(0) // copy array
        if (interpret.apply(el, q(tokens.pop())) && (!tokens.length || ancestorMatch(el, tokens, dividedTokens, root))) {
          return true
        }
      }
      return false
    }

    // given elements matching the right-most part of a selector, filter out any that don't match the rest
    function ancestorMatch(el, tokens, dividedTokens, root) {
      var cand
      // recursively work backwards through the tokens and up the dom, covering all options
      function crawl(e, i, p) {
        while (p = walker[dividedTokens[i]](p, e)) {
          if (isNode(p) && (interpret.apply(p, q(tokens[i])))) {
            if (i) {
              if (cand = crawl(p, i - 1, p)) return cand
            } else return p
          }
        }
      }
      return (cand = crawl(el, tokens.length - 1, el)) && (!root || isAncestor(cand, root))
    }

    function isNode(el, t) {
      return el && typeof el === 'object' && (t = el[nodeType]) && (t == 1 || t == 9)
    }

    function uniq(ar) {
      var a = [], i, j;
      o:
      for (i = 0; i < ar.length; ++i) {
        for (j = 0; j < a.length; ++j) if (a[j] == ar[i]) continue o
        a[a.length] = ar[i]
      }
      return a
    }

    function arrayLike(o) {
      return (typeof o === 'object' && isFinite(o.length))
    }

    function normalizeRoot(root) {
      if (!root) return doc
      if (typeof root == 'string') return qwery(root)[0]
      if (!root[nodeType] && arrayLike(root)) return root[0]
      return root
    }

    function byId(root, id, el) {
      // if doc, query on it, else query the parent doc or if a detached fragment rewrite the query and run on the fragment
      return root[nodeType] === 9 ? root.getElementById(id) :
        root.ownerDocument &&
          (((el = root.ownerDocument.getElementById(id)) && isAncestor(el, root) && el) ||
            (!isAncestor(root, root.ownerDocument) && select('[id="' + id + '"]', root)[0]))
    }

    function qwery(selector, _root) {
      var m, el, root = normalizeRoot(_root)

      // easy, fast cases that we can dispatch with simple DOM calls
      if (!root || !selector) return []
      if (selector === window || isNode(selector)) {
        return !_root || (selector !== window && isNode(root) && isAncestor(selector, root)) ? [selector] : []
      }
      if (selector && arrayLike(selector)) return flatten(selector)
      if (m = selector.match(easy)) {
        if (m[1]) return (el = byId(root, m[1])) ? [el] : []
        if (m[2]) return arrayify(root[byTag](m[2]))
        if (hasByClass && m[3]) return arrayify(root[byClass](m[3]))
      }

      return select(selector, root)
    }

    // where the root is not document and a relationship selector is first we have to
    // do some awkward adjustments to get it to work, even with qSA
    function collectSelector(root, collector) {
      return function (s) {
        var oid, nid
        if (splittable.test(s)) {
          if (root[nodeType] !== 9) {
            // make sure the el has an id, rewrite the query, set root to doc and run it
            if (!(nid = oid = root.getAttribute('id'))) root.setAttribute('id', nid = '__qwerymeupscotty')
            s = '[id="' + nid + '"]' + s // avoid byId and allow us to match context element
            collector(root.parentNode || root, s, true)
            oid || root.removeAttribute('id')
          }
          return;
        }
        s.length && collector(root, s, false)
      }
    }

    var isAncestor = 'compareDocumentPosition' in html ?
      function (element, container) {
        return (container.compareDocumentPosition(element) & 16) == 16
      } : 'contains' in html ?
      function (element, container) {
        container = container[nodeType] === 9 || container == window ? html : container
        return container !== element && container.contains(element)
      } :
      function (element, container) {
        while (element = element.parentNode) if (element === container) return 1
        return 0
      }
    , getAttr = function () {
        // detect buggy IE src/href getAttribute() call
        var e = doc.createElement('p')
        return ((e.innerHTML = '<a href="#x">x</a>') && e.firstChild.getAttribute('href') != '#x') ?
          function (e, a) {
            return a === 'class' ? e.className : (a === 'href' || a === 'src') ?
              e.getAttribute(a, 2) : e.getAttribute(a)
          } :
          function (e, a) { return e.getAttribute(a) }
      }()
    , hasByClass = !!doc[byClass]
      // has native qSA support
    , hasQSA = doc.querySelector && doc[qSA]
      // use native qSA
    , selectQSA = function (selector, root) {
        var result = [], ss, e
        try {
          if (root[nodeType] === 9 || !splittable.test(selector)) {
            // most work is done right here, defer to qSA
            return arrayify(root[qSA](selector))
          }
          // special case where we need the services of `collectSelector()`
          each(ss = selector.split(','), collectSelector(root, function (ctx, s) {
            e = ctx[qSA](s)
            if (e.length == 1) result[result.length] = e.item(0)
            else if (e.length) result = result.concat(arrayify(e))
          }))
          return ss.length > 1 && result.length > 1 ? uniq(result) : result
        } catch (ex) { }
        return selectNonNative(selector, root)
      }
      // no native selector support
    , selectNonNative = function (selector, root) {
        var result = [], items, m, i, l, r, ss
        selector = selector.replace(normalizr, '$1')
        if (m = selector.match(tagAndOrClass)) {
          r = classRegex(m[2])
          items = root[byTag](m[1] || '*')
          for (i = 0, l = items.length; i < l; i++) {
            if (r.test(items[i].className)) result[result.length] = items[i]
          }
          return result
        }
        // more complex selector, get `_qwery()` to do the work for us
        each(ss = selector.split(','), collectSelector(root, function (ctx, s, rewrite) {
          r = _qwery(s, ctx)
          for (i = 0, l = r.length; i < l; i++) {
            if (ctx[nodeType] === 9 || rewrite || isAncestor(r[i], root)) result[result.length] = r[i]
          }
        }))
        return ss.length > 1 && result.length > 1 ? uniq(result) : result
      }
    , configure = function (options) {
        // configNativeQSA: use fully-internal selector or native qSA where present
        if (typeof options[useNativeQSA] !== 'undefined')
          select = !options[useNativeQSA] ? selectNonNative : hasQSA ? selectQSA : selectNonNative
      }

    configure({ useNativeQSA: true })

    qwery.configure = configure
    qwery.uniq = uniq
    qwery.is = is
    qwery.pseudos = {}

    return qwery
  });

  if (typeof provide == "function") provide("qwery", module.exports);

  (function ($) {
    var q = function () {
      var r
      try {
        r = require('qwery')
      } catch (ex) {
        r = require('qwery-mobile')
      } finally {
        return r
      }
    }()

    $.pseudos = q.pseudos

    $._select = function (s, r) {
      // detect if sibling module 'bonzo' is available at run-time
      // rather than load-time since technically it's not a dependency and
      // can be loaded in any order
      // hence the lazy function re-definition
      return ($._select = (function () {
        var b
        if (typeof $.create == 'function') return function (s, r) {
          return /^\s*</.test(s) ? $.create(s, r) : q(s, r)
        }
        try {
          b = require('bonzo')
          return function (s, r) {
            return /^\s*</.test(s) ? b.create(s, r) : q(s, r)
          }
        } catch (e) { }
        return q
      })())(s, r)
    }

    $.ender({
        find: function (s) {
          var r = [], i, l, j, k, els
          for (i = 0, l = this.length; i < l; i++) {
            els = q(s, this[i])
            for (j = 0, k = els.length; j < k; j++) r.push(els[j])
          }
          return $(q.uniq(r))
        }
      , and: function (s) {
          var plus = $(s)
          for (var i = this.length, j = 0, l = this.length + plus.length; i < l; i++, j++) {
            this[i] = plus[j]
          }
          this.length += plus.length
          return this
        }
      , is: function(s, r) {
          var i, l
          for (i = 0, l = this.length; i < l; i++) {
            if (q.is(this[i], s, r)) {
              return true
            }
          }
          return false
        }
    }, true)
  }(ender));

}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*!
    * Bean - copyright (c) Jacob Thornton 2011-2012
    * https://github.com/fat/bean
    * MIT license
    */
  (function (name, context, definition) {
    if (typeof module != 'undefined' && module.exports) module.exports = definition()
    else if (typeof define == 'function' && define.amd) define(definition)
    else context[name] = definition()
  })('bean', this, function (name, context) {
    name    = name    || 'bean'
    context = context || this

    var win            = window
      , old            = context[name]
      , namespaceRegex = /[^\.]*(?=\..*)\.|.*/
      , nameRegex      = /\..*/
      , addEvent       = 'addEventListener'
      , removeEvent    = 'removeEventListener'
      , doc            = document || {}
      , root           = doc.documentElement || {}
      , W3C_MODEL      = root[addEvent]
      , eventSupport   = W3C_MODEL ? addEvent : 'attachEvent'
      , ONE            = {} // singleton for quick matching making add() do one()

      , slice          = Array.prototype.slice
      , str2arr        = function (s, d) { return s.split(d || ' ') }
      , isString       = function (o) { return typeof o == 'string' }
      , isFunction     = function (o) { return typeof o == 'function' }

        // events that we consider to be 'native', anything not in this list will
        // be treated as a custom event
      , standardNativeEvents =
          'click dblclick mouseup mousedown contextmenu '                  + // mouse buttons
          'mousewheel mousemultiwheel DOMMouseScroll '                     + // mouse wheel
          'mouseover mouseout mousemove selectstart selectend '            + // mouse movement
          'keydown keypress keyup '                                        + // keyboard
          'orientationchange '                                             + // mobile
          'focus blur change reset select submit '                         + // form elements
          'load unload beforeunload resize move DOMContentLoaded '         + // window
          'readystatechange message '                                      + // window
          'error abort scroll '                                              // misc
        // element.fireEvent('onXYZ'... is not forgiving if we try to fire an event
        // that doesn't actually exist, so make sure we only do these on newer browsers
      , w3cNativeEvents =
          'show '                                                          + // mouse buttons
          'input invalid '                                                 + // form elements
          'touchstart touchmove touchend touchcancel '                     + // touch
          'gesturestart gesturechange gestureend '                         + // gesture
          'textinput'                                                      + // TextEvent
          'readystatechange pageshow pagehide popstate '                   + // window
          'hashchange offline online '                                     + // window
          'afterprint beforeprint '                                        + // printing
          'dragstart dragenter dragover dragleave drag drop dragend '      + // dnd
          'loadstart progress suspend emptied stalled loadmetadata '       + // media
          'loadeddata canplay canplaythrough playing waiting seeking '     + // media
          'seeked ended durationchange timeupdate play pause ratechange '  + // media
          'volumechange cuechange '                                        + // media
          'checking noupdate downloading cached updateready obsolete '       // appcache

        // convert to a hash for quick lookups
      , nativeEvents = (function (hash, events, i) {
          for (i = 0; i < events.length; i++) events[i] && (hash[events[i]] = 1)
          return hash
        }({}, str2arr(standardNativeEvents + (W3C_MODEL ? w3cNativeEvents : ''))))

        // custom events are events that we *fake*, they are not provided natively but
        // we can use native events to generate them
      , customEvents = (function () {
          var isAncestor = 'compareDocumentPosition' in root
                ? function (element, container) {
                    return container.compareDocumentPosition && (container.compareDocumentPosition(element) & 16) === 16
                  }
                : 'contains' in root
                  ? function (element, container) {
                      container = container.nodeType === 9 || container === window ? root : container
                      return container !== element && container.contains(element)
                    }
                  : function (element, container) {
                      while (element = element.parentNode) if (element === container) return 1
                      return 0
                    }
            , check = function (event) {
                var related = event.relatedTarget
                return !related
                  ? related == null
                  : (related !== this && related.prefix !== 'xul' && !/document/.test(this.toString())
                      && !isAncestor(related, this))
              }

          return {
              mouseenter: { base: 'mouseover', condition: check }
            , mouseleave: { base: 'mouseout', condition: check }
            , mousewheel: { base: /Firefox/.test(navigator.userAgent) ? 'DOMMouseScroll' : 'mousewheel' }
          }
        }())

        // we provide a consistent Event object across browsers by taking the actual DOM
        // event object and generating a new one from its properties.
      , Event = (function () {
              // a whitelist of properties (for different event types) tells us what to check for and copy
          var commonProps  = str2arr('altKey attrChange attrName bubbles cancelable ctrlKey currentTarget ' +
                'detail eventPhase getModifierState isTrusted metaKey relatedNode relatedTarget shiftKey '  +
                'srcElement target timeStamp type view which propertyName')
            , mouseProps   = commonProps.concat(str2arr('button buttons clientX clientY dataTransfer '      +
                'fromElement offsetX offsetY pageX pageY screenX screenY toElement'))
            , mouseWheelProps = mouseProps.concat(str2arr('wheelDelta wheelDeltaX wheelDeltaY wheelDeltaZ ' +
                'axis')) // 'axis' is FF specific
            , keyProps     = commonProps.concat(str2arr('char charCode key keyCode keyIdentifier '          +
                'keyLocation location'))
            , textProps    = commonProps.concat(str2arr('data'))
            , touchProps   = commonProps.concat(str2arr('touches targetTouches changedTouches scale rotation'))
            , messageProps = commonProps.concat(str2arr('data origin source'))
            , stateProps   = commonProps.concat(str2arr('state'))
            , overOutRegex = /over|out/
              // some event types need special handling and some need special properties, do that all here
            , typeFixers   = [
                  { // key events
                      reg: /key/i
                    , fix: function (event, newEvent) {
                        newEvent.keyCode = event.keyCode || event.which
                        return keyProps
                      }
                  }
                , { // mouse events
                      reg: /click|mouse(?!(.*wheel|scroll))|menu|drag|drop/i
                    , fix: function (event, newEvent, type) {
                        newEvent.rightClick = event.which === 3 || event.button === 2
                        newEvent.pos = { x: 0, y: 0 }
                        if (event.pageX || event.pageY) {
                          newEvent.clientX = event.pageX
                          newEvent.clientY = event.pageY
                        } else if (event.clientX || event.clientY) {
                          newEvent.clientX = event.clientX + doc.body.scrollLeft + root.scrollLeft
                          newEvent.clientY = event.clientY + doc.body.scrollTop + root.scrollTop
                        }
                        if (overOutRegex.test(type)) {
                          newEvent.relatedTarget = event.relatedTarget
                            || event[(type == 'mouseover' ? 'from' : 'to') + 'Element']
                        }
                        return mouseProps
                      }
                  }
                , { // mouse wheel events
                      reg: /mouse.*(wheel|scroll)/i
                    , fix: function () { return mouseWheelProps }
                  }
                , { // TextEvent
                      reg: /^text/i
                    , fix: function () { return textProps }
                  }
                , { // touch and gesture events
                      reg: /^touch|^gesture/i
                    , fix: function () { return touchProps }
                  }
                , { // message events
                      reg: /^message$/i
                    , fix: function () { return messageProps }
                  }
                , { // popstate events
                      reg: /^popstate$/i
                    , fix: function () { return stateProps }
                  }
                , { // everything else
                      reg: /.*/
                    , fix: function () { return commonProps }
                  }
              ]
            , typeFixerMap = {} // used to map event types to fixer functions (above), a basic cache mechanism

            , Event = function (event, element, isNative) {
                if (!arguments.length) return
                event = event || ((element.ownerDocument || element.document || element).parentWindow || win).event
                this.originalEvent = event
                this.isNative       = isNative
                this.isBean         = true

                if (!event) return

                var type   = event.type
                  , target = event.target || event.srcElement
                  , i, l, p, props, fixer

                this.target = target && target.nodeType === 3 ? target.parentNode : target

                if (isNative) { // we only need basic augmentation on custom events, the rest expensive & pointless
                  fixer = typeFixerMap[type]
                  if (!fixer) { // haven't encountered this event type before, map a fixer function for it
                    for (i = 0, l = typeFixers.length; i < l; i++) {
                      if (typeFixers[i].reg.test(type)) { // guaranteed to match at least one, last is .*
                        typeFixerMap[type] = fixer = typeFixers[i].fix
                        break
                      }
                    }
                  }

                  props = fixer(event, this, type)
                  for (i = props.length; i--;) {
                    if (!((p = props[i]) in this) && p in event) this[p] = event[p]
                  }
                }
              }

          // preventDefault() and stopPropagation() are a consistent interface to those functions
          // on the DOM, stop() is an alias for both of them together
          Event.prototype.preventDefault = function () {
            if (this.originalEvent.preventDefault) this.originalEvent.preventDefault()
            else this.originalEvent.returnValue = false
          }
          Event.prototype.stopPropagation = function () {
            if (this.originalEvent.stopPropagation) this.originalEvent.stopPropagation()
            else this.originalEvent.cancelBubble = true
          }
          Event.prototype.stop = function () {
            this.preventDefault()
            this.stopPropagation()
            this.stopped = true
          }
          // stopImmediatePropagation() has to be handled internally because we manage the event list for
          // each element
          // note that originalElement may be a Bean#Event object in some situations
          Event.prototype.stopImmediatePropagation = function () {
            if (this.originalEvent.stopImmediatePropagation) this.originalEvent.stopImmediatePropagation()
            this.isImmediatePropagationStopped = function () { return true }
          }
          Event.prototype.isImmediatePropagationStopped = function () {
            return this.originalEvent.isImmediatePropagationStopped && this.originalEvent.isImmediatePropagationStopped()
          }
          Event.prototype.clone = function (currentTarget) {
            //TODO: this is ripe for optimisation, new events are *expensive*
            // improving this will speed up delegated events
            var ne = new Event(this, this.element, this.isNative)
            ne.currentTarget = currentTarget
            return ne
          }

          return Event
        }())

        // if we're in old IE we can't do onpropertychange on doc or win so we use doc.documentElement for both
      , targetElement = function (element, isNative) {
          return !W3C_MODEL && !isNative && (element === doc || element === win) ? root : element
        }

        /**
          * Bean maintains an internal registry for event listeners. We don't touch elements, objects
          * or functions to identify them, instead we store everything in the registry.
          * Each event listener has a RegEntry object, we have one 'registry' for the whole instance.
          */
      , RegEntry = (function () {
          // each handler is wrapped so we can handle delegation and custom events
          var wrappedHandler = function (element, fn, condition, args) {
              var call = function (event, eargs) {
                    return fn.apply(element, args ? slice.call(eargs, event ? 0 : 1).concat(args) : eargs)
                  }
                , findTarget = function (event, eventElement) {
                    return fn.__beanDel ? fn.__beanDel.ft(event.target, element) : eventElement
                  }
                , handler = condition
                    ? function (event) {
                        var target = findTarget(event, this) // deleated event
                        if (condition.apply(target, arguments)) {
                          if (event) event.currentTarget = target
                          return call(event, arguments)
                        }
                      }
                    : function (event) {
                        if (fn.__beanDel) event = event.clone(findTarget(event)) // delegated event, fix the fix
                        return call(event, arguments)
                      }
              handler.__beanDel = fn.__beanDel
              return handler
            }

          , RegEntry = function (element, type, handler, original, namespaces, args, root) {
              var customType     = customEvents[type]
                , isNative

              if (type == 'unload') {
                // self clean-up
                handler = once(removeListener, element, type, handler, original)
              }

              if (customType) {
                if (customType.condition) {
                  handler = wrappedHandler(element, handler, customType.condition, args)
                }
                type = customType.base || type
              }

              this.isNative      = isNative = nativeEvents[type] && !!element[eventSupport]
              this.customType    = !W3C_MODEL && !isNative && type
              this.element       = element
              this.type          = type
              this.original      = original
              this.namespaces    = namespaces
              this.eventType     = W3C_MODEL || isNative ? type : 'propertychange'
              this.target        = targetElement(element, isNative)
              this[eventSupport] = !!this.target[eventSupport]
              this.root          = root
              this.handler       = wrappedHandler(element, handler, null, args)
            }

          // given a list of namespaces, is our entry in any of them?
          RegEntry.prototype.inNamespaces = function (checkNamespaces) {
            var i, j, c = 0
            if (!checkNamespaces) return true
            if (!this.namespaces) return false
            for (i = checkNamespaces.length; i--;) {
              for (j = this.namespaces.length; j--;) {
                if (checkNamespaces[i] == this.namespaces[j]) c++
              }
            }
            return checkNamespaces.length === c
          }

          // match by element, original fn (opt), handler fn (opt)
          RegEntry.prototype.matches = function (checkElement, checkOriginal, checkHandler) {
            return this.element === checkElement &&
              (!checkOriginal || this.original === checkOriginal) &&
              (!checkHandler || this.handler === checkHandler)
          }

          return RegEntry
        }())

      , registry = (function () {
          // our map stores arrays by event type, just because it's better than storing
          // everything in a single array.
          // uses '$' as a prefix for the keys for safety and 'r' as a special prefix for
          // rootListeners so we can look them up fast
          var map = {}

            // generic functional search of our registry for matching listeners,
            // `fn` returns false to break out of the loop
            , forAll = function (element, type, original, handler, root, fn) {
                var pfx = root ? 'r' : '$'
                if (!type || type == '*') {
                  // search the whole registry
                  for (var t in map) {
                    if (t.charAt(0) == pfx) {
                      forAll(element, t.substr(1), original, handler, root, fn)
                    }
                  }
                } else {
                  var i = 0, l, list = map[pfx + type], all = element == '*'
                  if (!list) return
                  for (l = list.length; i < l; i++) {
                    if ((all || list[i].matches(element, original, handler)) && !fn(list[i], list, i, type)) return
                  }
                }
              }

            , has = function (element, type, original, root) {
                // we're not using forAll here simply because it's a bit slower and this
                // needs to be fast
                var i, list = map[(root ? 'r' : '$') + type]
                if (list) {
                  for (i = list.length; i--;) {
                    if (!list[i].root && list[i].matches(element, original, null)) return true
                  }
                }
                return false
              }

            , get = function (element, type, original, root) {
                var entries = []
                forAll(element, type, original, null, root, function (entry) {
                  return entries.push(entry)
                })
                return entries
              }

            , put = function (entry) {
                var has = !entry.root && !this.has(entry.element, entry.type, null, false)
                  , key = (entry.root ? 'r' : '$') + entry.type
                ;(map[key] || (map[key] = [])).push(entry)
                return has
              }

            , del = function (entry) {
                forAll(entry.element, entry.type, null, entry.handler, entry.root, function (entry, list, i) {
                  list.splice(i, 1)
                  entry.removed = true
                  if (list.length === 0) delete map[(entry.root ? 'r' : '$') + entry.type]
                  return false
                })
              }

              // dump all entries, used for onunload
            , entries = function () {
                var t, entries = []
                for (t in map) {
                  if (t.charAt(0) == '$') entries = entries.concat(map[t])
                }
                return entries
              }

          return { has: has, get: get, put: put, del: del, entries: entries }
        }())

        // we need a selector engine for delegated events, use querySelectorAll if it exists
        // but for older browsers we need Qwery, Sizzle or similar
      , selectorEngine
      , setSelectorEngine = function (e) {
          if (!arguments.length) {
            selectorEngine = doc.querySelectorAll
              ? function (s, r) {
                  return r.querySelectorAll(s)
                }
              : function () {
                  throw new Error('Bean: No selector engine installed') // eeek
                }
          } else {
            selectorEngine = e
          }
        }

        // we attach this listener to each DOM event that we need to listen to, only once
        // per event type per DOM element
      , rootListener = function (event, type) {
          if (!W3C_MODEL && type && event && event.propertyName != '_on' + type) return

          var listeners = registry.get(this, type || event.type, null, false)
            , l = listeners.length
            , i = 0

          event = new Event(event, this, true)
          if (type) event.type = type

          // iterate through all handlers registered for this type, calling them unless they have
          // been removed by a previous handler or stopImmediatePropagation() has been called
          for (; i < l && !event.isImmediatePropagationStopped(); i++) {
            if (!listeners[i].removed) listeners[i].handler.call(this, event)
          }
        }

        // add and remove listeners to DOM elements
      , listener = W3C_MODEL
          ? function (element, type, add) {
              // new browsers
              element[add ? addEvent : removeEvent](type, rootListener, false)
            }
          : function (element, type, add, custom) {
              // IE8 and below, use attachEvent/detachEvent and we have to piggy-back propertychange events
              // to simulate event bubbling etc.
              var entry
              if (add) {
                registry.put(entry = new RegEntry(
                    element
                  , custom || type
                  , function (event) { // handler
                      rootListener.call(element, event, custom)
                    }
                  , rootListener
                  , null
                  , null
                  , true // is root
                ))
                if (custom && element['_on' + custom] == null) element['_on' + custom] = 0
                entry.target.attachEvent('on' + entry.eventType, entry.handler)
              } else {
                entry = registry.get(element, custom || type, rootListener, true)[0]
                if (entry) {
                  entry.target.detachEvent('on' + entry.eventType, entry.handler)
                  registry.del(entry)
                }
              }
            }

      , once = function (rm, element, type, fn, originalFn) {
          // wrap the handler in a handler that does a remove as well
          return function () {
            fn.apply(this, arguments)
            rm(element, type, originalFn)
          }
        }

      , removeListener = function (element, orgType, handler, namespaces) {
          var type     = orgType && orgType.replace(nameRegex, '')
            , handlers = registry.get(element, type, null, false)
            , removed  = {}
            , i, l

          for (i = 0, l = handlers.length; i < l; i++) {
            if ((!handler || handlers[i].original === handler) && handlers[i].inNamespaces(namespaces)) {
              // TODO: this is problematic, we have a registry.get() and registry.del() that
              // both do registry searches so we waste cycles doing this. Needs to be rolled into
              // a single registry.forAll(fn) that removes while finding, but the catch is that
              // we'll be splicing the arrays that we're iterating over. Needs extra tests to
              // make sure we don't screw it up. @rvagg
              registry.del(handlers[i])
              if (!removed[handlers[i].eventType] && handlers[i][eventSupport])
                removed[handlers[i].eventType] = { t: handlers[i].eventType, c: handlers[i].type }
            }
          }
          // check each type/element for removed listeners and remove the rootListener where it's no longer needed
          for (i in removed) {
            if (!registry.has(element, removed[i].t, null, false)) {
              // last listener of this type, remove the rootListener
              listener(element, removed[i].t, false, removed[i].c)
            }
          }
        }

        // set up a delegate helper using the given selector, wrap the handler function
      , delegate = function (selector, fn) {
          //TODO: findTarget (therefore $) is called twice, once for match and once for
          // setting e.currentTarget, fix this so it's only needed once
          var findTarget = function (target, root) {
                var i, array = isString(selector) ? selectorEngine(selector, root) : selector
                for (; target && target !== root; target = target.parentNode) {
                  for (i = array.length; i--;) {
                    if (array[i] === target) return target
                  }
                }
              }
            , handler = function (e) {
                var match = findTarget(e.target, this)
                if (match) fn.apply(match, arguments)
              }

          // __beanDel isn't pleasant but it's a private function, not exposed outside of Bean
          handler.__beanDel = {
              ft       : findTarget // attach it here for customEvents to use too
            , selector : selector
          }
          return handler
        }

      , fireListener = W3C_MODEL ? function (isNative, type, element) {
          // modern browsers, do a proper dispatchEvent()
          var evt = doc.createEvent(isNative ? 'HTMLEvents' : 'UIEvents')
          evt[isNative ? 'initEvent' : 'initUIEvent'](type, true, true, win, 1)
          element.dispatchEvent(evt)
        } : function (isNative, type, element) {
          // old browser use onpropertychange, just increment a custom property to trigger the event
          element = targetElement(element, isNative)
          isNative ? element.fireEvent('on' + type, doc.createEventObject()) : element['_on' + type]++
        }

        /**
          * Public API: off(), on(), add(), (remove()), one(), fire(), clone()
          */

        /**
          * off(element[, eventType(s)[, handler ]])
          */
      , off = function (element, typeSpec, fn) {
          var isTypeStr = isString(typeSpec)
            , k, type, namespaces, i

          if (isTypeStr && typeSpec.indexOf(' ') > 0) {
            // off(el, 't1 t2 t3', fn) or off(el, 't1 t2 t3')
            typeSpec = str2arr(typeSpec)
            for (i = typeSpec.length; i--;)
              off(element, typeSpec[i], fn)
            return element
          }

          type = isTypeStr && typeSpec.replace(nameRegex, '')
          if (type && customEvents[type]) type = customEvents[type].base

          if (!typeSpec || isTypeStr) {
            // off(el) or off(el, t1.ns) or off(el, .ns) or off(el, .ns1.ns2.ns3)
            if (namespaces = isTypeStr && typeSpec.replace(namespaceRegex, '')) namespaces = str2arr(namespaces, '.')
            removeListener(element, type, fn, namespaces)
          } else if (isFunction(typeSpec)) {
            // off(el, fn)
            removeListener(element, null, typeSpec)
          } else {
            // off(el, { t1: fn1, t2, fn2 })
            for (k in typeSpec) {
              if (typeSpec.hasOwnProperty(k)) off(element, k, typeSpec[k])
            }
          }

          return element
        }

        /**
          * on(element, eventType(s)[, selector], handler[, args ])
          */
      , on = function(element, events, selector, fn) {
          var originalFn, type, types, i, args, entry, first

          //TODO: the undefined check means you can't pass an 'args' argument, fix this perhaps?
          if (selector === undefined && typeof events == 'object') {
            //TODO: this can't handle delegated events
            for (type in events) {
              if (events.hasOwnProperty(type)) {
                on.call(this, element, type, events[type])
              }
            }
            return
          }

          if (!isFunction(selector)) {
            // delegated event
            originalFn = fn
            args       = slice.call(arguments, 4)
            fn         = delegate(selector, originalFn, selectorEngine)
          } else {
            args       = slice.call(arguments, 3)
            fn         = originalFn = selector
          }

          types = str2arr(events)

          // special case for one(), wrap in a self-removing handler
          if (this === ONE) {
            fn = once(off, element, events, fn, originalFn)
          }

          for (i = types.length; i--;) {
            // add new handler to the registry and check if it's the first for this element/type
            first = registry.put(entry = new RegEntry(
                element
              , types[i].replace(nameRegex, '') // event type
              , fn
              , originalFn
              , str2arr(types[i].replace(namespaceRegex, ''), '.') // namespaces
              , args
              , false // not root
            ))
            if (entry[eventSupport] && first) {
              // first event of this type on this element, add root listener
              listener(element, entry.eventType, true, entry.customType)
            }
          }

          return element
        }

        /**
          * add(element[, selector], eventType(s), handler[, args ])
          *
          * Deprecated: kept (for now) for backward-compatibility
          */
      , add = function (element, events, fn, delfn) {
          return on.apply(
              null
            , !isString(fn)
                ? slice.call(arguments)
                : [ element, fn, events, delfn ].concat(arguments.length > 3 ? slice.call(arguments, 5) : [])
          )
        }

        /**
          * one(element, eventType(s)[, selector], handler[, args ])
          */
      , one = function () {
          return on.apply(ONE, arguments)
        }

        /**
          * fire(element, eventType(s)[, args ])
          *
          * The optional 'args' argument must be an array, if no 'args' argument is provided
          * then we can use the browser's DOM event system, otherwise we trigger handlers manually
          */
      , fire = function (element, type, args) {
          var types = str2arr(type)
            , i, j, l, names, handlers

          for (i = types.length; i--;) {
            type = types[i].replace(nameRegex, '')
            if (names = types[i].replace(namespaceRegex, '')) names = str2arr(names, '.')
            if (!names && !args && element[eventSupport]) {
              fireListener(nativeEvents[type], type, element)
            } else {
              // non-native event, either because of a namespace, arguments or a non DOM element
              // iterate over all listeners and manually 'fire'
              handlers = registry.get(element, type, null, false)
              args = [false].concat(args)
              for (j = 0, l = handlers.length; j < l; j++) {
                if (handlers[j].inNamespaces(names)) {
                  handlers[j].handler.apply(element, args)
                }
              }
            }
          }
          return element
        }

        /**
          * clone(dstElement, srcElement[, eventType ])
          *
          * TODO: perhaps for consistency we should allow the same flexibility in type specifiers?
          */
      , clone = function (element, from, type) {
          var handlers = registry.get(from, type, null, false)
            , l = handlers.length
            , i = 0
            , args, beanDel

          for (; i < l; i++) {
            if (handlers[i].original) {
              args = [ element, handlers[i].type ]
              if (beanDel = handlers[i].handler.__beanDel) args.push(beanDel.selector)
              args.push(handlers[i].original)
              on.apply(null, args)
            }
          }
          return element
        }

      , bean = {
            on                : on
          , add               : add
          , one               : one
          , off               : off
          , remove            : off
          , clone             : clone
          , fire              : fire
          , setSelectorEngine : setSelectorEngine
          , noConflict        : function () {
              context[name] = old
              return this
            }
        }

    // for IE, clean up on unload to avoid leaks
    if (win.attachEvent) {
      var cleanup = function () {
        var i, entries = registry.entries()
        for (i in entries) {
          if (entries[i].type && entries[i].type !== 'unload') off(entries[i].element, entries[i].type)
        }
        win.detachEvent('onunload', cleanup)
        win.CollectGarbage && win.CollectGarbage()
      }
      win.attachEvent('onunload', cleanup)
    }

    // initialize selector engine to internal default (qSA or throw Error)
    setSelectorEngine()

    return bean
  });
  if (typeof provide == "function") provide("bean", module.exports);

  !function ($) {
    var b = require('bean')

      , integrate = function (method, type, method2) {
          var _args = type ? [type] : []
          return function () {
            for (var i = 0, l = this.length; i < l; i++) {
              if (!arguments.length && method == 'on' && type) method = 'fire'
              b[method].apply(this, [this[i]].concat(_args, Array.prototype.slice.call(arguments, 0)))
            }
            return this
          }
        }

      , add   = integrate('add')
      , on    = integrate('on')
      , one   = integrate('one')
      , off   = integrate('off')
      , fire  = integrate('fire')
      , clone = integrate('clone')

      , hover = function (enter, leave, i) { // i for internal
          for (i = this.length; i--;) {
            b.on.call(this, this[i], 'mouseenter', enter)
            b.on.call(this, this[i], 'mouseleave', leave)
          }
          return this
        }

      , methods = {
            on             : on
          , addListener    : on
          , bind           : on
          , listen         : on
          , delegate       : add // jQuery compat, same arg order as add()

          , one            : one

          , off            : off
          , unbind         : off
          , unlisten       : off
          , removeListener : off
          , undelegate     : off

          , emit           : fire
          , trigger        : fire

          , cloneEvents    : clone

          , hover          : hover
        }

      , shortcuts =
           ('blur change click dblclick error focus focusin focusout keydown keypress '
          + 'keyup load mousedown mouseenter mouseleave mouseout mouseover mouseup '
          + 'mousemove resize scroll select submit unload').split(' ')

    for (var i = shortcuts.length; i--;) {
      methods[shortcuts[i]] = integrate('on', shortcuts[i])
    }

    b.setSelectorEngine($)

    $.ender(methods, true)
  }(ender);
}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*!
    * Bonzo: DOM Utility (c) Dustin Diaz 2012
    * https://github.com/ded/bonzo
    * License MIT
    */
  (function (name, context, definition) {
    if (typeof module != 'undefined' && module.exports) module.exports = definition()
    else if (typeof define == 'function' && define.amd) define(definition)
    else context[name] = definition()
  })('bonzo', this, function() {
    var win = window
      , doc = win.document
      , html = doc.documentElement
      , parentNode = 'parentNode'
      , specialAttributes = /^(checked|value|selected|disabled)$/i
        // tags that we have trouble inserting *into*
      , specialTags = /^(select|fieldset|table|tbody|tfoot|td|tr|colgroup)$/i
      , simpleScriptTagRe = /\s*<script +src=['"]([^'"]+)['"]>/
      , table = ['<table>', '</table>', 1]
      , td = ['<table><tbody><tr>', '</tr></tbody></table>', 3]
      , option = ['<select>', '</select>', 1]
      , noscope = ['_', '', 0, 1]
      , tagMap = { // tags that we have trouble *inserting*
            thead: table, tbody: table, tfoot: table, colgroup: table, caption: table
          , tr: ['<table><tbody>', '</tbody></table>', 2]
          , th: td , td: td
          , col: ['<table><colgroup>', '</colgroup></table>', 2]
          , fieldset: ['<form>', '</form>', 1]
          , legend: ['<form><fieldset>', '</fieldset></form>', 2]
          , option: option, optgroup: option
          , script: noscope, style: noscope, link: noscope, param: noscope, base: noscope
        }
      , stateAttributes = /^(checked|selected|disabled)$/
      , ie = /msie/i.test(navigator.userAgent)
      , hasClass, addClass, removeClass
      , uidMap = {}
      , uuids = 0
      , digit = /^-?[\d\.]+$/
      , dattr = /^data-(.+)$/
      , px = 'px'
      , setAttribute = 'setAttribute'
      , getAttribute = 'getAttribute'
      , byTag = 'getElementsByTagName'
      , features = function() {
          var e = doc.createElement('p')
          e.innerHTML = '<a href="#x">x</a><table style="float:left;"></table>'
          return {
            hrefExtended: e[byTag]('a')[0][getAttribute]('href') != '#x' // IE < 8
          , autoTbody: e[byTag]('tbody').length !== 0 // IE < 8
          , computedStyle: doc.defaultView && doc.defaultView.getComputedStyle
          , cssFloat: e[byTag]('table')[0].style.styleFloat ? 'styleFloat' : 'cssFloat'
          , transform: function () {
              var props = ['transform', 'webkitTransform', 'MozTransform', 'OTransform', 'msTransform'], i
              for (i = 0; i < props.length; i++) {
                if (props[i] in e.style) return props[i]
              }
            }()
          , classList: 'classList' in e
          , opasity: function () {
              return typeof doc.createElement('a').style.opacity !== 'undefined'
            }()
          }
        }()
      , trimReplace = /(^\s*|\s*$)/g
      , whitespaceRegex = /\s+/
      , toString = String.prototype.toString
      , unitless = { lineHeight: 1, zoom: 1, zIndex: 1, opacity: 1, boxFlex: 1, WebkitBoxFlex: 1, MozBoxFlex: 1 }
      , query = doc.querySelectorAll && function (selector) { return doc.querySelectorAll(selector) }
      , trim = String.prototype.trim ?
          function (s) {
            return s.trim()
          } :
          function (s) {
            return s.replace(trimReplace, '')
          }

      , getStyle = features.computedStyle
          ? function (el, property) {
              var value = null
                , computed = doc.defaultView.getComputedStyle(el, '')
              computed && (value = computed[property])
              return el.style[property] || value
            }
          : !(ie && html.currentStyle)
            ? function (el, property) {
                return el.style[property]
              }
            :
            /**
             * @param {Element} el
             * @param {string} property
             * @return {string|number}
             */
            function (el, property) {
              var val, value
              if (property == 'opacity' && !features.opasity) {
                val = 100
                try {
                  val = el['filters']['DXImageTransform.Microsoft.Alpha'].opacity
                } catch (e1) {
                  try {
                    val = el['filters']('alpha').opacity
                  } catch (e2) {}
                }
                return val / 100
              }
              value = el.currentStyle ? el.currentStyle[property] : null
              return el.style[property] || value
            }

    function isNode(node) {
      return node && node.nodeName && (node.nodeType == 1 || node.nodeType == 11)
    }


    function normalize(node, host, clone) {
      var i, l, ret
      if (typeof node == 'string') return bonzo.create(node)
      if (isNode(node)) node = [ node ]
      if (clone) {
        ret = [] // don't change original array
        for (i = 0, l = node.length; i < l; i++) ret[i] = cloneNode(host, node[i])
        return ret
      }
      return node
    }

    /**
     * @param {string} c a class name to test
     * @return {boolean}
     */
    function classReg(c) {
      return new RegExp('(^|\\s+)' + c + '(\\s+|$)')
    }


    /**
     * @param {Bonzo|Array} ar
     * @param {function(Object, number, (Bonzo|Array))} fn
     * @param {Object=} opt_scope
     * @param {boolean=} opt_rev
     * @return {Bonzo|Array}
     */
    function each(ar, fn, opt_scope, opt_rev) {
      var ind, i = 0, l = ar.length
      for (; i < l; i++) {
        ind = opt_rev ? ar.length - i - 1 : i
        fn.call(opt_scope || ar[ind], ar[ind], ind, ar)
      }
      return ar
    }


    /**
     * @param {Bonzo|Array} ar
     * @param {function(Object, number, (Bonzo|Array))} fn
     * @param {Object=} opt_scope
     * @return {Bonzo|Array}
     */
    function deepEach(ar, fn, opt_scope) {
      for (var i = 0, l = ar.length; i < l; i++) {
        if (isNode(ar[i])) {
          deepEach(ar[i].childNodes, fn, opt_scope)
          fn.call(opt_scope || ar[i], ar[i], i, ar)
        }
      }
      return ar
    }


    /**
     * @param {string} s
     * @return {string}
     */
    function camelize(s) {
      return s.replace(/-(.)/g, function (m, m1) {
        return m1.toUpperCase()
      })
    }


    /**
     * @param {string} s
     * @return {string}
     */
    function decamelize(s) {
      return s ? s.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase() : s
    }


    /**
     * @param {Element} el
     * @return {*}
     */
    function data(el) {
      el[getAttribute]('data-node-uid') || el[setAttribute]('data-node-uid', ++uuids)
      var uid = el[getAttribute]('data-node-uid')
      return uidMap[uid] || (uidMap[uid] = {})
    }


    /**
     * removes the data associated with an element
     * @param {Element} el
     */
    function clearData(el) {
      var uid = el[getAttribute]('data-node-uid')
      if (uid) delete uidMap[uid]
    }


    function dataValue(d) {
      var f
      try {
        return (d === null || d === undefined) ? undefined :
          d === 'true' ? true :
            d === 'false' ? false :
              d === 'null' ? null :
                (f = parseFloat(d)) == d ? f : d;
      } catch(e) {}
      return undefined
    }


    /**
     * @param {Bonzo|Array} ar
     * @param {function(Object, number, (Bonzo|Array))} fn
     * @param {Object=} opt_scope
     * @return {boolean} whether `some`thing was found
     */
    function some(ar, fn, opt_scope) {
      for (var i = 0, j = ar.length; i < j; ++i) if (fn.call(opt_scope || null, ar[i], i, ar)) return true
      return false
    }


    /**
     * this could be a giant enum of CSS properties
     * but in favor of file size sans-closure deadcode optimizations
     * we're just asking for any ol string
     * then it gets transformed into the appropriate style property for JS access
     * @param {string} p
     * @return {string}
     */
    function styleProperty(p) {
        (p == 'transform' && (p = features.transform)) ||
          (/^transform-?[Oo]rigin$/.test(p) && (p = features.transform + 'Origin')) ||
          (p == 'float' && (p = features.cssFloat))
        return p ? camelize(p) : null
    }

    // this insert method is intense
    function insert(target, host, fn, rev) {
      var i = 0, self = host || this, r = []
        // target nodes could be a css selector if it's a string and a selector engine is present
        // otherwise, just use target
        , nodes = query && typeof target == 'string' && target.charAt(0) != '<' ? query(target) : target
      // normalize each node in case it's still a string and we need to create nodes on the fly
      each(normalize(nodes), function (t, j) {
        each(self, function (el) {
          fn(t, r[i++] = j > 0 ? cloneNode(self, el) : el)
        }, null, rev)
      }, this, rev)
      self.length = i
      each(r, function (e) {
        self[--i] = e
      }, null, !rev)
      return self
    }


    /**
     * sets an element to an explicit x/y position on the page
     * @param {Element} el
     * @param {?number} x
     * @param {?number} y
     */
    function xy(el, x, y) {
      var $el = bonzo(el)
        , style = $el.css('position')
        , offset = $el.offset()
        , rel = 'relative'
        , isRel = style == rel
        , delta = [parseInt($el.css('left'), 10), parseInt($el.css('top'), 10)]

      if (style == 'static') {
        $el.css('position', rel)
        style = rel
      }

      isNaN(delta[0]) && (delta[0] = isRel ? 0 : el.offsetLeft)
      isNaN(delta[1]) && (delta[1] = isRel ? 0 : el.offsetTop)

      x != null && (el.style.left = x - offset.left + delta[0] + px)
      y != null && (el.style.top = y - offset.top + delta[1] + px)

    }

    // classList support for class management
    // altho to be fair, the api sucks because it won't accept multiple classes at once
    if (features.classList) {
      hasClass = function (el, c) {
        return el.classList.contains(c)
      }
      addClass = function (el, c) {
        el.classList.add(c)
      }
      removeClass = function (el, c) {
        el.classList.remove(c)
      }
    }
    else {
      hasClass = function (el, c) {
        return classReg(c).test(el.className)
      }
      addClass = function (el, c) {
        el.className = trim(el.className + ' ' + c)
      }
      removeClass = function (el, c) {
        el.className = trim(el.className.replace(classReg(c), ' '))
      }
    }


    /**
     * this allows method calling for setting values
     *
     * @example
     * bonzo(elements).css('color', function (el) {
     *   return el.getAttribute('data-original-color')
     * })
     *
     * @param {Element} el
     * @param {function (Element)|string}
     * @return {string}
     */
    function setter(el, v) {
      return typeof v == 'function' ? v(el) : v
    }

    function scroll(x, y, type) {
      var el = this[0]
      if (!el) return this
      if (x == null && y == null) {
        return (isBody(el) ? getWindowScroll() : { x: el.scrollLeft, y: el.scrollTop })[type]
      }
      if (isBody(el)) {
        win.scrollTo(x, y)
      } else {
        x != null && (el.scrollLeft = x)
        y != null && (el.scrollTop = y)
      }
      return this
    }

    /**
     * @constructor
     * @param {Array.<Element>|Element|Node|string} elements
     */
    function Bonzo(elements) {
      this.length = 0
      if (elements) {
        elements = typeof elements !== 'string' &&
          !elements.nodeType &&
          typeof elements.length !== 'undefined' ?
            elements :
            [elements]
        this.length = elements.length
        for (var i = 0; i < elements.length; i++) this[i] = elements[i]
      }
    }

    Bonzo.prototype = {

        /**
         * @param {number} index
         * @return {Element|Node}
         */
        get: function (index) {
          return this[index] || null
        }

        // itetators
        /**
         * @param {function(Element|Node)} fn
         * @param {Object=} opt_scope
         * @return {Bonzo}
         */
      , each: function (fn, opt_scope) {
          return each(this, fn, opt_scope)
        }

        /**
         * @param {Function} fn
         * @param {Object=} opt_scope
         * @return {Bonzo}
         */
      , deepEach: function (fn, opt_scope) {
          return deepEach(this, fn, opt_scope)
        }


        /**
         * @param {Function} fn
         * @param {Function=} opt_reject
         * @return {Array}
         */
      , map: function (fn, opt_reject) {
          var m = [], n, i
          for (i = 0; i < this.length; i++) {
            n = fn.call(this, this[i], i)
            opt_reject ? (opt_reject(n) && m.push(n)) : m.push(n)
          }
          return m
        }

      // text and html inserters!

      /**
       * @param {string} h the HTML to insert
       * @param {boolean=} opt_text whether to set or get text content
       * @return {Bonzo|string}
       */
      , html: function (h, opt_text) {
          var method = opt_text
                ? html.textContent === undefined ? 'innerText' : 'textContent'
                : 'innerHTML'
            , that = this
            , append = function (el, i) {
                each(normalize(h, that, i), function (node) {
                  el.appendChild(node)
                })
              }
            , updateElement = function (el, i) {
                try {
                  if (opt_text || (typeof h == 'string' && !specialTags.test(el.tagName))) {
                    return el[method] = h
                  }
                } catch (e) {}
                append(el, i)
              }
          return typeof h != 'undefined'
            ? this.empty().each(updateElement)
            : this[0] ? this[0][method] : ''
        }

        /**
         * @param {string=} opt_text the text to set, otherwise this is a getter
         * @return {Bonzo|string}
         */
      , text: function (opt_text) {
          return this.html(opt_text, true)
        }

        // more related insertion methods

        /**
         * @param {Bonzo|string|Element|Array} node
         * @return {Bonzo}
         */
      , append: function (node) {
          var that = this
          return this.each(function (el, i) {
            each(normalize(node, that, i), function (i) {
              el.appendChild(i)
            })
          })
        }


        /**
         * @param {Bonzo|string|Element|Array} node
         * @return {Bonzo}
         */
      , prepend: function (node) {
          var that = this
          return this.each(function (el, i) {
            var first = el.firstChild
            each(normalize(node, that, i), function (i) {
              el.insertBefore(i, first)
            })
          })
        }


        /**
         * @param {Bonzo|string|Element|Array} target the location for which you'll insert your new content
         * @param {Object=} opt_host an optional host scope (primarily used when integrated with Ender)
         * @return {Bonzo}
         */
      , appendTo: function (target, opt_host) {
          return insert.call(this, target, opt_host, function (t, el) {
            t.appendChild(el)
          })
        }


        /**
         * @param {Bonzo|string|Element|Array} target the location for which you'll insert your new content
         * @param {Object=} opt_host an optional host scope (primarily used when integrated with Ender)
         * @return {Bonzo}
         */
      , prependTo: function (target, opt_host) {
          return insert.call(this, target, opt_host, function (t, el) {
            t.insertBefore(el, t.firstChild)
          }, 1)
        }


        /**
         * @param {Bonzo|string|Element|Array} node
         * @return {Bonzo}
         */
      , before: function (node) {
          var that = this
          return this.each(function (el, i) {
            each(normalize(node, that, i), function (i) {
              el[parentNode].insertBefore(i, el)
            })
          })
        }


        /**
         * @param {Bonzo|string|Element|Array} node
         * @return {Bonzo}
         */
      , after: function (node) {
          var that = this
          return this.each(function (el, i) {
            each(normalize(node, that, i), function (i) {
              el[parentNode].insertBefore(i, el.nextSibling)
            }, null, 1)
          })
        }


        /**
         * @param {Bonzo|string|Element|Array} target the location for which you'll insert your new content
         * @param {Object=} opt_host an optional host scope (primarily used when integrated with Ender)
         * @return {Bonzo}
         */
      , insertBefore: function (target, opt_host) {
          return insert.call(this, target, opt_host, function (t, el) {
            t[parentNode].insertBefore(el, t)
          })
        }


        /**
         * @param {Bonzo|string|Element|Array} target the location for which you'll insert your new content
         * @param {Object=} opt_host an optional host scope (primarily used when integrated with Ender)
         * @return {Bonzo}
         */
      , insertAfter: function (target, opt_host) {
          return insert.call(this, target, opt_host, function (t, el) {
            var sibling = t.nextSibling
            sibling ?
              t[parentNode].insertBefore(el, sibling) :
              t[parentNode].appendChild(el)
          }, 1)
        }


        /**
         * @param {Bonzo|string|Element|Array} node
         * @return {Bonzo}
         */
      , replaceWith: function (node) {
          bonzo(normalize(node)).insertAfter(this)
          return this.remove()
        }

        /**
         * @param {Object=} opt_host an optional host scope (primarily used when integrated with Ender)
         * @return {Bonzo}
         */
      , clone: function (opt_host) {
          var ret = [] // don't change original array
            , l, i
          for (i = 0, l = this.length; i < l; i++) ret[i] = cloneNode(opt_host || this, this[i])
          return bonzo(ret)
        }

        // class management

        /**
         * @param {string} c
         * @return {Bonzo}
         */
      , addClass: function (c) {
          c = toString.call(c).split(whitespaceRegex)
          return this.each(function (el) {
            // we `each` here so you can do $el.addClass('foo bar')
            each(c, function (c) {
              if (c && !hasClass(el, setter(el, c)))
                addClass(el, setter(el, c))
            })
          })
        }


        /**
         * @param {string} c
         * @return {Bonzo}
         */
      , removeClass: function (c) {
          c = toString.call(c).split(whitespaceRegex)
          return this.each(function (el) {
            each(c, function (c) {
              if (c && hasClass(el, setter(el, c)))
                removeClass(el, setter(el, c))
            })
          })
        }


        /**
         * @param {string} c
         * @return {boolean}
         */
      , hasClass: function (c) {
          c = toString.call(c).split(whitespaceRegex)
          return some(this, function (el) {
            return some(c, function (c) {
              return c && hasClass(el, c)
            })
          })
        }


        /**
         * @param {string} c classname to toggle
         * @param {boolean=} opt_condition whether to add or remove the class straight away
         * @return {Bonzo}
         */
      , toggleClass: function (c, opt_condition) {
          c = toString.call(c).split(whitespaceRegex)
          return this.each(function (el) {
            each(c, function (c) {
              if (c) {
                typeof opt_condition !== 'undefined' ?
                  opt_condition ? !hasClass(el, c) && addClass(el, c) : removeClass(el, c) :
                  hasClass(el, c) ? removeClass(el, c) : addClass(el, c)
              }
            })
          })
        }

        // display togglers

        /**
         * @param {string=} opt_type useful to set back to anything other than an empty string
         * @return {Bonzo}
         */
      , show: function (opt_type) {
          opt_type = typeof opt_type == 'string' ? opt_type : ''
          return this.each(function (el) {
            el.style.display = opt_type
          })
        }


        /**
         * @return {Bonzo}
         */
      , hide: function () {
          return this.each(function (el) {
            el.style.display = 'none'
          })
        }


        /**
         * @param {Function=} opt_callback
         * @param {string=} opt_type
         * @return {Bonzo}
         */
      , toggle: function (opt_callback, opt_type) {
          opt_type = typeof opt_type == 'string' ? opt_type : '';
          typeof opt_callback != 'function' && (opt_callback = null)
          return this.each(function (el) {
            el.style.display = (el.offsetWidth || el.offsetHeight) ? 'none' : opt_type;
            opt_callback && opt_callback.call(el)
          })
        }


        // DOM Walkers & getters

        /**
         * @return {Element|Node}
         */
      , first: function () {
          return bonzo(this.length ? this[0] : [])
        }


        /**
         * @return {Element|Node}
         */
      , last: function () {
          return bonzo(this.length ? this[this.length - 1] : [])
        }


        /**
         * @return {Element|Node}
         */
      , next: function () {
          return this.related('nextSibling')
        }


        /**
         * @return {Element|Node}
         */
      , previous: function () {
          return this.related('previousSibling')
        }


        /**
         * @return {Element|Node}
         */
      , parent: function() {
          return this.related(parentNode)
        }


        /**
         * @private
         * @param {string} method the directional DOM method
         * @return {Element|Node}
         */
      , related: function (method) {
          return bonzo(this.map(
            function (el) {
              el = el[method]
              while (el && el.nodeType !== 1) {
                el = el[method]
              }
              return el || 0
            },
            function (el) {
              return el
            }
          ))
        }


        /**
         * @return {Bonzo}
         */
      , focus: function () {
          this.length && this[0].focus()
          return this
        }


        /**
         * @return {Bonzo}
         */
      , blur: function () {
          this.length && this[0].blur()
          return this
        }

        // style getter setter & related methods

        /**
         * @param {Object|string} o
         * @param {string=} opt_v
         * @return {Bonzo|string}
         */
      , css: function (o, opt_v) {
          var p, iter = o
          // is this a request for just getting a style?
          if (opt_v === undefined && typeof o == 'string') {
            // repurpose 'v'
            opt_v = this[0]
            if (!opt_v) return null
            if (opt_v === doc || opt_v === win) {
              p = (opt_v === doc) ? bonzo.doc() : bonzo.viewport()
              return o == 'width' ? p.width : o == 'height' ? p.height : ''
            }
            return (o = styleProperty(o)) ? getStyle(opt_v, o) : null
          }

          if (typeof o == 'string') {
            iter = {}
            iter[o] = opt_v
          }

          if (ie && iter.opacity) {
            // oh this 'ol gamut
            iter.filter = 'alpha(opacity=' + (iter.opacity * 100) + ')'
            // give it layout
            iter.zoom = o.zoom || 1;
            delete iter.opacity;
          }

          function fn(el, p, v) {
            for (var k in iter) {
              if (iter.hasOwnProperty(k)) {
                v = iter[k];
                // change "5" to "5px" - unless you're line-height, which is allowed
                (p = styleProperty(k)) && digit.test(v) && !(p in unitless) && (v += px)
                try { el.style[p] = setter(el, v) } catch(e) {}
              }
            }
          }
          return this.each(fn)
        }


        /**
         * @param {number=} opt_x
         * @param {number=} opt_y
         * @return {Bonzo|number}
         */
      , offset: function (opt_x, opt_y) {
          if (opt_x && typeof opt_x == 'object' && (typeof opt_x.top == 'number' || typeof opt_x.left == 'number')) {
            return this.each(function (el) {
              xy(el, opt_x.left, opt_x.top)
            })
          } else if (typeof opt_x == 'number' || typeof opt_y == 'number') {
            return this.each(function (el) {
              xy(el, opt_x, opt_y)
            })
          }
          if (!this[0]) return {
              top: 0
            , left: 0
            , height: 0
            , width: 0
          }
          var el = this[0]
            , de = el.ownerDocument.documentElement
            , bcr = el.getBoundingClientRect()
            , scroll = getWindowScroll()
            , width = el.offsetWidth
            , height = el.offsetHeight
            , top = bcr.top + scroll.y - Math.max(0, de && de.clientTop, doc.body.clientTop)
            , left = bcr.left + scroll.x - Math.max(0, de && de.clientLeft, doc.body.clientLeft)

          return {
              top: top
            , left: left
            , height: height
            , width: width
          }
        }


        /**
         * @return {number}
         */
      , dim: function () {
          if (!this.length) return { height: 0, width: 0 }
          var el = this[0]
            , de = el.nodeType == 9 && el.documentElement // document
            , orig = !de && !!el.style && !el.offsetWidth && !el.offsetHeight ?
               // el isn't visible, can't be measured properly, so fix that
               function (t) {
                 var s = {
                     position: el.style.position || ''
                   , visibility: el.style.visibility || ''
                   , display: el.style.display || ''
                 }
                 t.first().css({
                     position: 'absolute'
                   , visibility: 'hidden'
                   , display: 'block'
                 })
                 return s
              }(this) : null
            , width = de
                ? Math.max(el.body.scrollWidth, el.body.offsetWidth, de.scrollWidth, de.offsetWidth, de.clientWidth)
                : el.offsetWidth
            , height = de
                ? Math.max(el.body.scrollHeight, el.body.offsetHeight, de.scrollHeight, de.offsetHeight, de.clientHeight)
                : el.offsetHeight

          orig && this.first().css(orig)
          return {
              height: height
            , width: width
          }
        }

        // attributes are hard. go shopping

        /**
         * @param {string} k an attribute to get or set
         * @param {string=} opt_v the value to set
         * @return {Bonzo|string}
         */
      , attr: function (k, opt_v) {
          var el = this[0]
            , n

          if (typeof k != 'string' && !(k instanceof String)) {
            for (n in k) {
              k.hasOwnProperty(n) && this.attr(n, k[n])
            }
            return this
          }

          return typeof opt_v == 'undefined' ?
            !el ? null : specialAttributes.test(k) ?
              stateAttributes.test(k) && typeof el[k] == 'string' ?
                true : el[k] : (k == 'href' || k =='src') && features.hrefExtended ?
                  el[getAttribute](k, 2) : el[getAttribute](k) :
            this.each(function (el) {
              specialAttributes.test(k) ? (el[k] = setter(el, opt_v)) : el[setAttribute](k, setter(el, opt_v))
            })
        }


        /**
         * @param {string} k
         * @return {Bonzo}
         */
      , removeAttr: function (k) {
          return this.each(function (el) {
            stateAttributes.test(k) ? (el[k] = false) : el.removeAttribute(k)
          })
        }


        /**
         * @param {string=} opt_s
         * @return {Bonzo|string}
         */
      , val: function (s) {
          return (typeof s == 'string') ?
            this.attr('value', s) :
            this.length ? this[0].value : null
        }

        // use with care and knowledge. this data() method uses data attributes on the DOM nodes
        // to do this differently costs a lot more code. c'est la vie
        /**
         * @param {string|Object=} opt_k the key for which to get or set data
         * @param {Object=} opt_v
         * @return {Bonzo|Object}
         */
      , data: function (opt_k, opt_v) {
          var el = this[0], o, m
          if (typeof opt_v === 'undefined') {
            if (!el) return null
            o = data(el)
            if (typeof opt_k === 'undefined') {
              each(el.attributes, function (a) {
                (m = ('' + a.name).match(dattr)) && (o[camelize(m[1])] = dataValue(a.value))
              })
              return o
            } else {
              if (typeof o[opt_k] === 'undefined')
                o[opt_k] = dataValue(this.attr('data-' + decamelize(opt_k)))
              return o[opt_k]
            }
          } else {
            return this.each(function (el) { data(el)[opt_k] = opt_v })
          }
        }

        // DOM detachment & related

        /**
         * @return {Bonzo}
         */
      , remove: function () {
          this.deepEach(clearData)
          return this.detach()
        }


        /**
         * @return {Bonzo}
         */
      , empty: function () {
          return this.each(function (el) {
            deepEach(el.childNodes, clearData)

            while (el.firstChild) {
              el.removeChild(el.firstChild)
            }
          })
        }


        /**
         * @return {Bonzo}
         */
      , detach: function () {
          return this.each(function (el) {
            el[parentNode] && el[parentNode].removeChild(el)
          })
        }

        // who uses a mouse anyway? oh right.

        /**
         * @param {number} y
         */
      , scrollTop: function (y) {
          return scroll.call(this, null, y, 'y')
        }


        /**
         * @param {number} x
         */
      , scrollLeft: function (x) {
          return scroll.call(this, x, null, 'x')
        }

    }


    function cloneNode(host, el) {
      var c = el.cloneNode(true)
        , cloneElems
        , elElems
        , i

      // check for existence of an event cloner
      // preferably https://github.com/fat/bean
      // otherwise Bonzo won't do this for you
      if (host.$ && typeof host.cloneEvents == 'function') {
        host.$(c).cloneEvents(el)

        // clone events from every child node
        cloneElems = host.$(c).find('*')
        elElems = host.$(el).find('*')

        for (i = 0; i < elElems.length; i++)
          host.$(cloneElems[i]).cloneEvents(elElems[i])
      }
      return c
    }

    function isBody(element) {
      return element === win || (/^(?:body|html)$/i).test(element.tagName)
    }

    function getWindowScroll() {
      return { x: win.pageXOffset || html.scrollLeft, y: win.pageYOffset || html.scrollTop }
    }

    function createScriptFromHtml(html) {
      var scriptEl = document.createElement('script')
        , matches = html.match(simpleScriptTagRe)
      scriptEl.src = matches[1]
      return scriptEl
    }

    /**
     * @param {Array.<Element>|Element|Node|string} els
     * @return {Bonzo}
     */
    function bonzo(els) {
      return new Bonzo(els)
    }

    bonzo.setQueryEngine = function (q) {
      query = q;
      delete bonzo.setQueryEngine
    }

    bonzo.aug = function (o, target) {
      // for those standalone bonzo users. this love is for you.
      for (var k in o) {
        o.hasOwnProperty(k) && ((target || Bonzo.prototype)[k] = o[k])
      }
    }

    bonzo.create = function (node) {
      // hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
      return typeof node == 'string' && node !== '' ?
        function () {
          if (simpleScriptTagRe.test(node)) return [createScriptFromHtml(node)]
          var tag = node.match(/^\s*<([^\s>]+)/)
            , el = doc.createElement('div')
            , els = []
            , p = tag ? tagMap[tag[1].toLowerCase()] : null
            , dep = p ? p[2] + 1 : 1
            , ns = p && p[3]
            , pn = parentNode
            , tb = features.autoTbody && p && p[0] == '<table>' && !(/<tbody/i).test(node)

          el.innerHTML = p ? (p[0] + node + p[1]) : node
          while (dep--) el = el.firstChild
          // for IE NoScope, we may insert cruft at the begining just to get it to work
          if (ns && el && el.nodeType !== 1) el = el.nextSibling
          do {
            // tbody special case for IE<8, creates tbody on any empty table
            // we don't want it if we're just after a <thead>, <caption>, etc.
            if ((!tag || el.nodeType == 1) && (!tb || (el.tagName && el.tagName != 'TBODY'))) {
              els.push(el)
            }
          } while (el = el.nextSibling)
          // IE < 9 gives us a parentNode which messes up insert() check for cloning
          // `dep` > 1 can also cause problems with the insert() check (must do this last)
          each(els, function(el) { el[pn] && el[pn].removeChild(el) })
          return els
        }() : isNode(node) ? [node.cloneNode(true)] : []
    }

    bonzo.doc = function () {
      var vp = bonzo.viewport()
      return {
          width: Math.max(doc.body.scrollWidth, html.scrollWidth, vp.width)
        , height: Math.max(doc.body.scrollHeight, html.scrollHeight, vp.height)
      }
    }

    bonzo.firstChild = function (el) {
      for (var c = el.childNodes, i = 0, j = (c && c.length) || 0, e; i < j; i++) {
        if (c[i].nodeType === 1) e = c[j = i]
      }
      return e
    }

    bonzo.viewport = function () {
      return {
          width: ie ? html.clientWidth : self.innerWidth
        , height: ie ? html.clientHeight : self.innerHeight
      }
    }

    bonzo.isAncestor = 'compareDocumentPosition' in html ?
      function (container, element) {
        return (container.compareDocumentPosition(element) & 16) == 16
      } : 'contains' in html ?
      function (container, element) {
        return container !== element && container.contains(element);
      } :
      function (container, element) {
        while (element = element[parentNode]) {
          if (element === container) {
            return true
          }
        }
        return false
      }

    return bonzo
  }); // the only line we care about using a semi-colon. placed here for concatenation tools

  if (typeof provide == "function") provide("bonzo", module.exports);

  (function ($) {

    var b = require('bonzo')
    b.setQueryEngine($)
    $.ender(b)
    $.ender(b(), true)
    $.ender({
      create: function (node) {
        return $(b.create(node))
      }
    })

    $.id = function (id) {
      return $([document.getElementById(id)])
    }

    function indexOf(ar, val) {
      for (var i = 0; i < ar.length; i++) if (ar[i] === val) return i
      return -1
    }

    function uniq(ar) {
      var r = [], i = 0, j = 0, k, item, inIt
      for (; item = ar[i]; ++i) {
        inIt = false
        for (k = 0; k < r.length; ++k) {
          if (r[k] === item) {
            inIt = true; break
          }
        }
        if (!inIt) r[j++] = item
      }
      return r
    }

    $.ender({
      parents: function (selector, closest) {
        if (!this.length) return this
        if (!selector) selector = '*'
        var collection = $(selector), j, k, p, r = []
        for (j = 0, k = this.length; j < k; j++) {
          p = this[j]
          while (p = p.parentNode) {
            if (~indexOf(collection, p)) {
              r.push(p)
              if (closest) break;
            }
          }
        }
        return $(uniq(r))
      }

    , parent: function() {
        return $(uniq(b(this).parent()))
      }

    , closest: function (selector) {
        return this.parents(selector, true)
      }

    , first: function () {
        return $(this.length ? this[0] : this)
      }

    , last: function () {
        return $(this.length ? this[this.length - 1] : [])
      }

    , next: function () {
        return $(b(this).next())
      }

    , previous: function () {
        return $(b(this).previous())
      }

    , related: function (t) {
        return $(b(this).related(t))
      }

    , appendTo: function (t) {
        return b(this.selector).appendTo(t, this)
      }

    , prependTo: function (t) {
        return b(this.selector).prependTo(t, this)
      }

    , insertAfter: function (t) {
        return b(this.selector).insertAfter(t, this)
      }

    , insertBefore: function (t) {
        return b(this.selector).insertBefore(t, this)
      }

    , clone: function () {
        return $(b(this).clone(this))
      }

    , siblings: function () {
        var i, l, p, r = []
        for (i = 0, l = this.length; i < l; i++) {
          p = this[i]
          while (p = p.previousSibling) p.nodeType == 1 && r.push(p)
          p = this[i]
          while (p = p.nextSibling) p.nodeType == 1 && r.push(p)
        }
        return $(r)
      }

    , children: function () {
        var i, l, el, r = []
        for (i = 0, l = this.length; i < l; i++) {
          if (!(el = b.firstChild(this[i]))) continue;
          r.push(el)
          while (el = el.nextSibling) el.nodeType == 1 && r.push(el)
        }
        return $(uniq(r))
      }

    , height: function (v) {
        return dimension.call(this, 'height', v)
      }

    , width: function (v) {
        return dimension.call(this, 'width', v)
      }
    }, true)

    /**
     * @param {string} type either width or height
     * @param {number=} opt_v becomes a setter instead of a getter
     * @return {number}
     */
    function dimension(type, opt_v) {
      return typeof opt_v == 'undefined'
        ? b(this).dim()[type]
        : this.css(type, opt_v)
    }
  }(ender));
}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*!
    * Reqwest! A general purpose XHR connection manager
    * (c) Dustin Diaz 2013
    * https://github.com/ded/reqwest
    * license MIT
    */
  !function (name, context, definition) {
    if (typeof module != 'undefined' && module.exports) module.exports = definition()
    else if (typeof define == 'function' && define.amd) define(definition)
    else context[name] = definition()
  }('reqwest', this, function () {

    var win = window
      , doc = document
      , twoHundo = /^20\d$/
      , byTag = 'getElementsByTagName'
      , readyState = 'readyState'
      , contentType = 'Content-Type'
      , requestedWith = 'X-Requested-With'
      , head = doc[byTag]('head')[0]
      , uniqid = 0
      , callbackPrefix = 'reqwest_' + (+new Date())
      , lastValue // data stored by the most recent JSONP callback
      , xmlHttpRequest = 'XMLHttpRequest'
      , noop = function () {}

      , isArray = typeof Array.isArray == 'function'
          ? Array.isArray
          : function (a) {
              return a instanceof Array
            }

      , defaultHeaders = {
            contentType: 'application/x-www-form-urlencoded'
          , requestedWith: xmlHttpRequest
          , accept: {
                '*':  'text/javascript, text/html, application/xml, text/xml, */*'
              , xml:  'application/xml, text/xml'
              , html: 'text/html'
              , text: 'text/plain'
              , json: 'application/json, text/javascript'
              , js:   'application/javascript, text/javascript'
            }
        }

      , xhr = win[xmlHttpRequest]
          ? function () {
              return new XMLHttpRequest()
            }
          : function () {
              return new ActiveXObject('Microsoft.XMLHTTP')
            }
      , globalSetupOptions = {
          dataFilter: function (data) {
            return data
          }
        }

    function handleReadyState(r, success, error) {
      return function () {
        // use _aborted to mitigate against IE err c00c023f
        // (can't read props on aborted request objects)
        if (r._aborted) return error(r.request)
        if (r.request && r.request[readyState] == 4) {
          r.request.onreadystatechange = noop
          if (twoHundo.test(r.request.status))
            success(r.request)
          else
            error(r.request)
        }
      }
    }

    function setHeaders(http, o) {
      var headers = o.headers || {}
        , h

      headers.Accept = headers.Accept
        || defaultHeaders.accept[o.type]
        || defaultHeaders.accept['*']

      // breaks cross-origin requests with legacy browsers
      if (!o.crossOrigin && !headers[requestedWith]) headers[requestedWith] = defaultHeaders.requestedWith
      if (!headers[contentType]) headers[contentType] = o.contentType || defaultHeaders.contentType
      for (h in headers)
        headers.hasOwnProperty(h) && http.setRequestHeader(h, headers[h])
    }

    function setCredentials(http, o) {
      if (typeof o.withCredentials !== 'undefined' && typeof http.withCredentials !== 'undefined') {
        http.withCredentials = !!o.withCredentials
      }
    }

    function generalCallback(data) {
      lastValue = data
    }

    function urlappend (url, s) {
      return url + (/\?/.test(url) ? '&' : '?') + s
    }

    function handleJsonp(o, fn, err, url) {
      var reqId = uniqid++
        , cbkey = o.jsonpCallback || 'callback' // the 'callback' key
        , cbval = o.jsonpCallbackName || reqwest.getcallbackPrefix(reqId)
        // , cbval = o.jsonpCallbackName || ('reqwest_' + reqId) // the 'callback' value
        , cbreg = new RegExp('((^|\\?|&)' + cbkey + ')=([^&]+)')
        , match = url.match(cbreg)
        , script = doc.createElement('script')
        , loaded = 0
        , isIE10 = navigator.userAgent.indexOf('MSIE 10.0') !== -1

      if (match) {
        if (match[3] === '?') {
          url = url.replace(cbreg, '$1=' + cbval) // wildcard callback func name
        } else {
          cbval = match[3] // provided callback func name
        }
      } else {
        url = urlappend(url, cbkey + '=' + cbval) // no callback details, add 'em
      }

      win[cbval] = generalCallback

      script.type = 'text/javascript'
      script.src = url
      script.async = true
      if (typeof script.onreadystatechange !== 'undefined' && !isIE10) {
        // need this for IE due to out-of-order onreadystatechange(), binding script
        // execution to an event listener gives us control over when the script
        // is executed. See http://jaubourg.net/2010/07/loading-script-as-onclick-handler-of.html
        //
        // if this hack is used in IE10 jsonp callback are never called
        script.event = 'onclick'
        script.htmlFor = script.id = '_reqwest_' + reqId
      }

      script.onload = script.onreadystatechange = function () {
        if ((script[readyState] && script[readyState] !== 'complete' && script[readyState] !== 'loaded') || loaded) {
          return false
        }
        script.onload = script.onreadystatechange = null
        script.onclick && script.onclick()
        // Call the user callback with the last value stored and clean up values and scripts.
        o.success && o.success(lastValue)
        lastValue = undefined
        head.removeChild(script)
        loaded = 1
      }

      // Add the script to the DOM head
      head.appendChild(script)

      // Enable JSONP timeout
      return {
        abort: function () {
          script.onload = script.onreadystatechange = null
          o.error && o.error({}, 'Request is aborted: timeout', {})
          lastValue = undefined
          head.removeChild(script)
          loaded = 1
        }
      }
    }

    function getRequest(fn, err) {
      var o = this.o
        , method = (o.method || 'GET').toUpperCase()
        , url = typeof o === 'string' ? o : o.url
        // convert non-string objects to query-string form unless o.processData is false
        , data = (o.processData !== false && o.data && typeof o.data !== 'string')
          ? reqwest.toQueryString(o.data)
          : (o.data || null)
        , http

      // if we're working on a GET request and we have data then we should append
      // query string to end of URL and not post data
      if ((o.type == 'jsonp' || method == 'GET') && data) {
        url = urlappend(url, data)
        data = null
      }

      if (o.type == 'jsonp') return handleJsonp(o, fn, err, url)

      http = xhr()
      http.open(method, url, true)
      setHeaders(http, o)
      setCredentials(http, o)
      http.onreadystatechange = handleReadyState(this, fn, err)
      o.before && o.before(http)
      http.send(data)
      return http
    }

    function Reqwest(o, fn) {
      this.o = o
      this.fn = fn

      init.apply(this, arguments)
    }

    function setType(url) {
      var m = url.match(/\.(json|jsonp|html|xml)(\?|$)/)
      return m ? m[1] : 'js'
    }

    function init(o, fn) {

      this.url = typeof o == 'string' ? o : o.url
      this.timeout = null

      // whether request has been fulfilled for purpose
      // of tracking the Promises
      this._fulfilled = false
      // success handlers
      this._fulfillmentHandlers = []
      // error handlers
      this._errorHandlers = []
      // complete (both success and fail) handlers
      this._completeHandlers = []
      this._erred = false
      this._responseArgs = {}

      var self = this
        , type = o.type || setType(this.url)

      fn = fn || function () {}

      if (o.timeout) {
        this.timeout = setTimeout(function () {
          self.abort()
        }, o.timeout)
      }

      if (o.success) {
        this._fulfillmentHandlers.push(function () {
          o.success.apply(o, arguments)
        })
      }

      if (o.error) {
        this._errorHandlers.push(function () {
          o.error.apply(o, arguments)
        })
      }

      if (o.complete) {
        this._completeHandlers.push(function () {
          o.complete.apply(o, arguments)
        })
      }

      function complete (resp) {
        o.timeout && clearTimeout(self.timeout)
        self.timeout = null
        while (self._completeHandlers.length > 0) {
          self._completeHandlers.shift()(resp)
        }
      }

      function success (resp) {
        // use global data filter on response text
        var filteredResponse = globalSetupOptions.dataFilter(resp.responseText, type)
          , r = resp.responseText = filteredResponse
        if (r) {
          switch (type) {
          case 'json':
            try {
              resp = win.JSON ? win.JSON.parse(r) : eval('(' + r + ')')
            } catch (err) {
              return error(resp, 'Could not parse JSON in response', err)
            }
            break
          case 'js':
            resp = eval(r)
            break
          case 'html':
            resp = r
            break
          case 'xml':
            resp = resp.responseXML
                && resp.responseXML.parseError // IE trololo
                && resp.responseXML.parseError.errorCode
                && resp.responseXML.parseError.reason
              ? null
              : resp.responseXML
            break
          }
        }

        self._responseArgs.resp = resp
        self._fulfilled = true
        fn(resp)
        while (self._fulfillmentHandlers.length > 0) {
          self._fulfillmentHandlers.shift()(resp)
        }

        complete(resp)
      }

      function error(resp, msg, t) {
        self._responseArgs.resp = resp
        self._responseArgs.msg = msg
        self._responseArgs.t = t
        self._erred = true
        while (self._errorHandlers.length > 0) {
          self._errorHandlers.shift()(resp, msg, t)
        }
        complete(resp)
      }

      this.request = getRequest.call(this, success, error)
    }

    Reqwest.prototype = {
      abort: function () {
        this._aborted = true
        this.request.abort()
      }

    , retry: function () {
        init.call(this, this.o, this.fn)
      }

      /**
       * Small deviation from the Promises A CommonJs specification
       * http://wiki.commonjs.org/wiki/Promises/A
       */

      /**
       * `then` will execute upon successful requests
       */
    , then: function (success, fail) {
        if (this._fulfilled) {
          success(this._responseArgs.resp)
        } else if (this._erred) {
          fail(this._responseArgs.resp, this._responseArgs.msg, this._responseArgs.t)
        } else {
          this._fulfillmentHandlers.push(success)
          this._errorHandlers.push(fail)
        }
        return this
      }

      /**
       * `always` will execute whether the request succeeds or fails
       */
    , always: function (fn) {
        if (this._fulfilled || this._erred) {
          fn(this._responseArgs.resp)
        } else {
          this._completeHandlers.push(fn)
        }
        return this
      }

      /**
       * `fail` will execute when the request fails
       */
    , fail: function (fn) {
        if (this._erred) {
          fn(this._responseArgs.resp, this._responseArgs.msg, this._responseArgs.t)
        } else {
          this._errorHandlers.push(fn)
        }
        return this
      }
    }

    function reqwest(o, fn) {
      return new Reqwest(o, fn)
    }

    // normalize newline variants according to spec -> CRLF
    function normalize(s) {
      return s ? s.replace(/\r?\n/g, '\r\n') : ''
    }

    function serial(el, cb) {
      var n = el.name
        , t = el.tagName.toLowerCase()
        , optCb = function (o) {
            // IE gives value="" even where there is no value attribute
            // 'specified' ref: http://www.w3.org/TR/DOM-Level-3-Core/core.html#ID-862529273
            if (o && !o.disabled)
              cb(n, normalize(o.attributes.value && o.attributes.value.specified ? o.value : o.text))
          }
        , ch, ra, val, i

      // don't serialize elements that are disabled or without a name
      if (el.disabled || !n) return

      switch (t) {
      case 'input':
        if (!/reset|button|image|file/i.test(el.type)) {
          ch = /checkbox/i.test(el.type)
          ra = /radio/i.test(el.type)
          val = el.value
          // WebKit gives us "" instead of "on" if a checkbox has no value, so correct it here
          ;(!(ch || ra) || el.checked) && cb(n, normalize(ch && val === '' ? 'on' : val))
        }
        break
      case 'textarea':
        cb(n, normalize(el.value))
        break
      case 'select':
        if (el.type.toLowerCase() === 'select-one') {
          optCb(el.selectedIndex >= 0 ? el.options[el.selectedIndex] : null)
        } else {
          for (i = 0; el.length && i < el.length; i++) {
            el.options[i].selected && optCb(el.options[i])
          }
        }
        break
      }
    }

    // collect up all form elements found from the passed argument elements all
    // the way down to child elements; pass a '<form>' or form fields.
    // called with 'this'=callback to use for serial() on each element
    function eachFormElement() {
      var cb = this
        , e, i
        , serializeSubtags = function (e, tags) {
            var i, j, fa
            for (i = 0; i < tags.length; i++) {
              fa = e[byTag](tags[i])
              for (j = 0; j < fa.length; j++) serial(fa[j], cb)
            }
          }

      for (i = 0; i < arguments.length; i++) {
        e = arguments[i]
        if (/input|select|textarea/i.test(e.tagName)) serial(e, cb)
        serializeSubtags(e, [ 'input', 'select', 'textarea' ])
      }
    }

    // standard query string style serialization
    function serializeQueryString() {
      return reqwest.toQueryString(reqwest.serializeArray.apply(null, arguments))
    }

    // { 'name': 'value', ... } style serialization
    function serializeHash() {
      var hash = {}
      eachFormElement.apply(function (name, value) {
        if (name in hash) {
          hash[name] && !isArray(hash[name]) && (hash[name] = [hash[name]])
          hash[name].push(value)
        } else hash[name] = value
      }, arguments)
      return hash
    }

    // [ { name: 'name', value: 'value' }, ... ] style serialization
    reqwest.serializeArray = function () {
      var arr = []
      eachFormElement.apply(function (name, value) {
        arr.push({name: name, value: value})
      }, arguments)
      return arr
    }

    reqwest.serialize = function () {
      if (arguments.length === 0) return ''
      var opt, fn
        , args = Array.prototype.slice.call(arguments, 0)

      opt = args.pop()
      opt && opt.nodeType && args.push(opt) && (opt = null)
      opt && (opt = opt.type)

      if (opt == 'map') fn = serializeHash
      else if (opt == 'array') fn = reqwest.serializeArray
      else fn = serializeQueryString

      return fn.apply(null, args)
    }

    reqwest.toQueryString = function (o, trad) {
      var prefix, i
        , traditional = trad || false
        , s = []
        , enc = encodeURIComponent
        , add = function (key, value) {
            // If value is a function, invoke it and return its value
            value = ('function' === typeof value) ? value() : (value == null ? '' : value)
            s[s.length] = enc(key) + '=' + enc(value)
          }
      // If an array was passed in, assume that it is an array of form elements.
      if (isArray(o)) {
        for (i = 0; o && i < o.length; i++) add(o[i].name, o[i].value)
      } else {
        // If traditional, encode the "old" way (the way 1.3.2 or older
        // did it), otherwise encode params recursively.
        for (prefix in o) {
          buildParams(prefix, o[prefix], traditional, add)
        }
      }

      // spaces should be + according to spec
      return s.join('&').replace(/%20/g, '+')
    }

    function buildParams(prefix, obj, traditional, add) {
      var name, i, v
        , rbracket = /\[\]$/

      if (isArray(obj)) {
        // Serialize array item.
        for (i = 0; obj && i < obj.length; i++) {
          v = obj[i]
          if (traditional || rbracket.test(prefix)) {
            // Treat each array item as a scalar.
            add(prefix, v)
          } else {
            buildParams(prefix + '[' + (typeof v === 'object' ? i : '') + ']', v, traditional, add)
          }
        }
      } else if (obj.toString() === '[object Object]') {
        // Serialize object item.
        for (name in obj) {
          buildParams(prefix + '[' + name + ']', obj[name], traditional, add)
        }

      } else {
        // Serialize scalar item.
        add(prefix, obj)
      }
    }

    reqwest.getcallbackPrefix = function () {
      return callbackPrefix
    }

    // jQuery and Zepto compatibility, differences can be remapped here so you can call
    // .ajax.compat(options, callback)
    reqwest.compat = function (o, fn) {
      if (o) {
        o.type && (o.method = o.type) && delete o.type
        o.dataType && (o.type = o.dataType)
        o.jsonpCallback && (o.jsonpCallbackName = o.jsonpCallback) && delete o.jsonpCallback
        o.jsonp && (o.jsonpCallback = o.jsonp)
      }
      return new Reqwest(o, fn)
    }

    reqwest.ajaxSetup = function (options) {
      options = options || {}
      for (var k in options) {
        globalSetupOptions[k] = options[k]
      }
    }

    return reqwest
  });

  if (typeof provide == "function") provide("reqwest", module.exports);

  !function ($) {
    var r = require('reqwest')
      , integrate = function (method) {
          return function () {
            var args = Array.prototype.slice.call(arguments, 0)
              , i = (this && this.length) || 0
            while (i--) args.unshift(this[i])
            return r[method].apply(null, args)
          }
        }
      , s = integrate('serialize')
      , sa = integrate('serializeArray')

    $.ender({
        ajax: r
      , serialize: r.serialize
      , serializeArray: r.serializeArray
      , toQueryString: r.toQueryString
      , ajaxSetup: r.ajaxSetup
    })

    $.ender({
        serialize: s
      , serializeArray: sa
    }, true)
  }(ender);

}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*!
    * Morpheus - A Brilliant Animator
    * https://github.com/ded/morpheus - (c) Dustin Diaz 2011
    * License MIT
    */
  !function (name, definition) {
    if (typeof define == 'function') define(definition)
    else if (typeof module != 'undefined') module.exports = definition()
    else this[name] = definition()
  }('morpheus', function () {

    var doc = document
      , win = window
      , perf = win.performance
      , perfNow = perf && (perf.now || perf.webkitNow || perf.msNow || perf.mozNow)
      , now = perfNow ? function () { return perfNow.call(perf) } : function () { return +new Date() }
      , html = doc.documentElement
      , thousand = 1000
      , rgbOhex = /^rgb\(|#/
      , relVal = /^([+\-])=([\d\.]+)/
      , numUnit = /^(?:[\+\-]=?)?\d+(?:\.\d+)?(%|in|cm|mm|em|ex|pt|pc|px)$/
      , rotate = /rotate\(((?:[+\-]=)?([\-\d\.]+))deg\)/
      , scale = /scale\(((?:[+\-]=)?([\d\.]+))\)/
      , skew = /skew\(((?:[+\-]=)?([\-\d\.]+))deg, ?((?:[+\-]=)?([\-\d\.]+))deg\)/
      , translate = /translate\(((?:[+\-]=)?([\-\d\.]+))px, ?((?:[+\-]=)?([\-\d\.]+))px\)/
        // these elements do not require 'px'
      , unitless = { lineHeight: 1, zoom: 1, zIndex: 1, opacity: 1, transform: 1}

    // which property name does this browser use for transform
    var transform = function () {
      var styles = doc.createElement('a').style
        , props = ['webkitTransform', 'MozTransform', 'OTransform', 'msTransform', 'Transform']
        , i
      for (i = 0; i < props.length; i++) {
        if (props[i] in styles) return props[i]
      }
    }()

    // does this browser support the opacity property?
    var opasity = function () {
      return typeof doc.createElement('a').style.opacity !== 'undefined'
    }()

    // initial style is determined by the elements themselves
    var getStyle = doc.defaultView && doc.defaultView.getComputedStyle ?
      function (el, property) {
        property = property == 'transform' ? transform : property
        var value = null
          , computed = doc.defaultView.getComputedStyle(el, '')
        computed && (value = computed[camelize(property)])
        return el.style[property] || value
      } : html.currentStyle ?

      function (el, property) {
        property = camelize(property)

        if (property == 'opacity') {
          var val = 100
          try {
            val = el.filters['DXImageTransform.Microsoft.Alpha'].opacity
          } catch (e1) {
            try {
              val = el.filters('alpha').opacity
            } catch (e2) {}
          }
          return val / 100
        }
        var value = el.currentStyle ? el.currentStyle[property] : null
        return el.style[property] || value
      } :
      function (el, property) {
        return el.style[camelize(property)]
      }

    var frame = function () {
      // native animation frames
      // http://webstuff.nfshost.com/anim-timing/Overview.html
      // http://dev.chromium.org/developers/design-documents/requestanimationframe-implementation
      return win.requestAnimationFrame  ||
        win.webkitRequestAnimationFrame ||
        win.mozRequestAnimationFrame    ||
        win.msRequestAnimationFrame     ||
        win.oRequestAnimationFrame      ||
        function (callback) {
          win.setTimeout(function () {
            callback(+new Date())
          }, 17) // when I was 17..
        }
    }()

    var children = []

    function has(array, elem, i) {
      if (Array.prototype.indexOf) return array.indexOf(elem)
      for (i = 0; i < array.length; ++i) {
        if (array[i] === elem) return i
      }
    }

    function render(timestamp) {
      var i, count = children.length
      // if we're using a high res timer, make sure timestamp is not the old epoch-based value.
      // http://updates.html5rocks.com/2012/05/requestAnimationFrame-API-now-with-sub-millisecond-precision
      if (perfNow && timestamp > 1e12) timestamp = now()
      for (i = count; i--;) {
        children[i](timestamp)
      }
      children.length && frame(render)
    }

    function live(f) {
      if (children.push(f) === 1) frame(render)
    }

    function die(f) {
      var rest, index = has(children, f)
      if (index >= 0) {
        rest = children.slice(index + 1)
        children.length = index
        children = children.concat(rest)
      }
    }

    function parseTransform(style, base) {
      var values = {}, m
      if (m = style.match(rotate)) values.rotate = by(m[1], base ? base.rotate : null)
      if (m = style.match(scale)) values.scale = by(m[1], base ? base.scale : null)
      if (m = style.match(skew)) {values.skewx = by(m[1], base ? base.skewx : null); values.skewy = by(m[3], base ? base.skewy : null)}
      if (m = style.match(translate)) {values.translatex = by(m[1], base ? base.translatex : null); values.translatey = by(m[3], base ? base.translatey : null)}
      return values
    }

    function formatTransform(v) {
      var s = ''
      if ('rotate' in v) s += 'rotate(' + v.rotate + 'deg) '
      if ('scale' in v) s += 'scale(' + v.scale + ') '
      if ('translatex' in v) s += 'translate(' + v.translatex + 'px,' + v.translatey + 'px) '
      if ('skewx' in v) s += 'skew(' + v.skewx + 'deg,' + v.skewy + 'deg)'
      return s
    }

    function rgb(r, g, b) {
      return '#' + (1 << 24 | r << 16 | g << 8 | b).toString(16).slice(1)
    }

    // convert rgb and short hex to long hex
    function toHex(c) {
      var m = c.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)/)
      return (m ? rgb(m[1], m[2], m[3]) : c)
        .replace(/#(\w)(\w)(\w)$/, '#$1$1$2$2$3$3') // short skirt to long jacket
    }

    // change font-size => fontSize etc.
    function camelize(s) {
      return s.replace(/-(.)/g, function (m, m1) {
        return m1.toUpperCase()
      })
    }

    // aren't we having it?
    function fun(f) {
      return typeof f == 'function'
    }

    function nativeTween(t) {
      // default to a pleasant-to-the-eye easeOut (like native animations)
      return Math.sin(t * Math.PI / 2)
    }

    /**
      * Core tween method that requests each frame
      * @param duration: time in milliseconds. defaults to 1000
      * @param fn: tween frame callback function receiving 'position'
      * @param done {optional}: complete callback function
      * @param ease {optional}: easing method. defaults to easeOut
      * @param from {optional}: integer to start from
      * @param to {optional}: integer to end at
      * @returns method to stop the animation
      */
    function tween(duration, fn, done, ease, from, to) {
      ease = fun(ease) ? ease : morpheus.easings[ease] || nativeTween
      var time = duration || thousand
        , self = this
        , diff = to - from
        , start = now()
        , stop = 0
        , end = 0

      function run(t) {
        var delta = t - start
        if (delta > time || stop) {
          to = isFinite(to) ? to : 1
          stop ? end && fn(to) : fn(to)
          die(run)
          return done && done.apply(self)
        }
        // if you don't specify a 'to' you can use tween as a generic delta tweener
        // cool, eh?
        isFinite(to) ?
          fn((diff * ease(delta / time)) + from) :
          fn(ease(delta / time))
      }

      live(run)

      return {
        stop: function (jump) {
          stop = 1
          end = jump // jump to end of animation?
          if (!jump) done = null // remove callback if not jumping to end
        }
      }
    }

    /**
      * generic bezier method for animating x|y coordinates
      * minimum of 2 points required (start and end).
      * first point start, last point end
      * additional control points are optional (but why else would you use this anyway ;)
      * @param points: array containing control points
         [[0, 0], [100, 200], [200, 100]]
      * @param pos: current be(tween) position represented as float  0 - 1
      * @return [x, y]
      */
    function bezier(points, pos) {
      var n = points.length, r = [], i, j
      for (i = 0; i < n; ++i) {
        r[i] = [points[i][0], points[i][1]]
      }
      for (j = 1; j < n; ++j) {
        for (i = 0; i < n - j; ++i) {
          r[i][0] = (1 - pos) * r[i][0] + pos * r[parseInt(i + 1, 10)][0]
          r[i][1] = (1 - pos) * r[i][1] + pos * r[parseInt(i + 1, 10)][1]
        }
      }
      return [r[0][0], r[0][1]]
    }

    // this gets you the next hex in line according to a 'position'
    function nextColor(pos, start, finish) {
      var r = [], i, e, from, to
      for (i = 0; i < 6; i++) {
        from = Math.min(15, parseInt(start.charAt(i),  16))
        to   = Math.min(15, parseInt(finish.charAt(i), 16))
        e = Math.floor((to - from) * pos + from)
        e = e > 15 ? 15 : e < 0 ? 0 : e
        r[i] = e.toString(16)
      }
      return '#' + r.join('')
    }

    // this retreives the frame value within a sequence
    function getTweenVal(pos, units, begin, end, k, i, v) {
      if (k == 'transform') {
        v = {}
        for (var t in begin[i][k]) {
          v[t] = (t in end[i][k]) ? Math.round(((end[i][k][t] - begin[i][k][t]) * pos + begin[i][k][t]) * thousand) / thousand : begin[i][k][t]
        }
        return v
      } else if (typeof begin[i][k] == 'string') {
        return nextColor(pos, begin[i][k], end[i][k])
      } else {
        // round so we don't get crazy long floats
        v = Math.round(((end[i][k] - begin[i][k]) * pos + begin[i][k]) * thousand) / thousand
        // some css properties don't require a unit (like zIndex, lineHeight, opacity)
        if (!(k in unitless)) v += units[i][k] || 'px'
        return v
      }
    }

    // support for relative movement via '+=n' or '-=n'
    function by(val, start, m, r, i) {
      return (m = relVal.exec(val)) ?
        (i = parseFloat(m[2])) && (start + (m[1] == '+' ? 1 : -1) * i) :
        parseFloat(val)
    }

    /**
      * morpheus:
      * @param element(s): HTMLElement(s)
      * @param options: mixed bag between CSS Style properties & animation options
      *  - {n} CSS properties|values
      *     - value can be strings, integers,
      *     - or callback function that receives element to be animated. method must return value to be tweened
      *     - relative animations start with += or -= followed by integer
      *  - duration: time in ms - defaults to 1000(ms)
      *  - easing: a transition method - defaults to an 'easeOut' algorithm
      *  - complete: a callback method for when all elements have finished
      *  - bezier: array of arrays containing x|y coordinates that define the bezier points. defaults to none
      *     - this may also be a function that receives element to be animated. it must return a value
      */
    function morpheus(elements, options) {
      var els = elements ? (els = isFinite(elements.length) ? elements : [elements]) : [], i
        , complete = options.complete
        , duration = options.duration
        , ease = options.easing
        , points = options.bezier
        , begin = []
        , end = []
        , units = []
        , bez = []
        , originalLeft
        , originalTop

      if (points) {
        // remember the original values for top|left
        originalLeft = options.left;
        originalTop = options.top;
        delete options.right;
        delete options.bottom;
        delete options.left;
        delete options.top;
      }

      for (i = els.length; i--;) {

        // record beginning and end states to calculate positions
        begin[i] = {}
        end[i] = {}
        units[i] = {}

        // are we 'moving'?
        if (points) {

          var left = getStyle(els[i], 'left')
            , top = getStyle(els[i], 'top')
            , xy = [by(fun(originalLeft) ? originalLeft(els[i]) : originalLeft || 0, parseFloat(left)),
                    by(fun(originalTop) ? originalTop(els[i]) : originalTop || 0, parseFloat(top))]

          bez[i] = fun(points) ? points(els[i], xy) : points
          bez[i].push(xy)
          bez[i].unshift([
            parseInt(left, 10),
            parseInt(top, 10)
          ])
        }

        for (var k in options) {
          switch (k) {
          case 'complete':
          case 'duration':
          case 'easing':
          case 'bezier':
            continue
          }
          var v = getStyle(els[i], k), unit
            , tmp = fun(options[k]) ? options[k](els[i]) : options[k]
          if (typeof tmp == 'string' &&
              rgbOhex.test(tmp) &&
              !rgbOhex.test(v)) {
            delete options[k]; // remove key :(
            continue; // cannot animate colors like 'orange' or 'transparent'
                      // only #xxx, #xxxxxx, rgb(n,n,n)
          }

          begin[i][k] = k == 'transform' ? parseTransform(v) :
            typeof tmp == 'string' && rgbOhex.test(tmp) ?
              toHex(v).slice(1) :
              parseFloat(v)
          end[i][k] = k == 'transform' ? parseTransform(tmp, begin[i][k]) :
            typeof tmp == 'string' && tmp.charAt(0) == '#' ?
              toHex(tmp).slice(1) :
              by(tmp, parseFloat(v));
          // record original unit
          (typeof tmp == 'string') && (unit = tmp.match(numUnit)) && (units[i][k] = unit[1])
        }
      }
      // ONE TWEEN TO RULE THEM ALL
      return tween.apply(els, [duration, function (pos, v, xy) {
        // normally not a fan of optimizing for() loops, but we want something
        // fast for animating
        for (i = els.length; i--;) {
          if (points) {
            xy = bezier(bez[i], pos)
            els[i].style.left = xy[0] + 'px'
            els[i].style.top = xy[1] + 'px'
          }
          for (var k in options) {
            v = getTweenVal(pos, units, begin, end, k, i)
            k == 'transform' ?
              els[i].style[transform] = formatTransform(v) :
              k == 'opacity' && !opasity ?
                (els[i].style.filter = 'alpha(opacity=' + (v * 100) + ')') :
                (els[i].style[camelize(k)] = v)
          }
        }
      }, complete, ease])
    }

    // expose useful methods
    morpheus.tween = tween
    morpheus.getStyle = getStyle
    morpheus.bezier = bezier
    morpheus.transform = transform
    morpheus.parseTransform = parseTransform
    morpheus.formatTransform = formatTransform
    morpheus.easings = {}

    return morpheus

  });

  if (typeof provide == "function") provide("morpheus", module.exports);

  var morpheus = require('morpheus')
  !function ($) {
    $.ender({
      animate: function (options) {
        return morpheus(this, options)
      }
    , fadeIn: function (d, fn) {
        return morpheus(this, {
            duration: d
          , opacity: 1
          , complete: fn
        })
      }
    , fadeOut: function (d, fn) {
        return morpheus(this, {
            duration: d
          , opacity: 0
          , complete: fn
        })
      }
    }, true)
    $.ender({
      tween: morpheus.tween
    })
  }(ender)
}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  /*
      http://www.JSON.org/json2.js
      2011-02-23

      Public Domain.

      NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.

      See http://www.JSON.org/js.html


      This code should be minified before deployment.
      See http://javascript.crockford.com/jsmin.html

      USE YOUR OWN COPY. IT IS EXTREMELY UNWISE TO LOAD CODE FROM SERVERS YOU DO
      NOT CONTROL.


      This file creates a global JSON object containing two methods: stringify
      and parse.

          JSON.stringify(value, replacer, space)
              value       any JavaScript value, usually an object or array.

              replacer    an optional parameter that determines how object
                          values are stringified for objects. It can be a
                          function or an array of strings.

              space       an optional parameter that specifies the indentation
                          of nested structures. If it is omitted, the text will
                          be packed without extra whitespace. If it is a number,
                          it will specify the number of spaces to indent at each
                          level. If it is a string (such as '\t' or '&nbsp;'),
                          it contains the characters used to indent at each level.

              This method produces a JSON text from a JavaScript value.

              When an object value is found, if the object contains a toJSON
              method, its toJSON method will be called and the result will be
              stringified. A toJSON method does not serialize: it returns the
              value represented by the name/value pair that should be serialized,
              or undefined if nothing should be serialized. The toJSON method
              will be passed the key associated with the value, and this will be
              bound to the value

              For example, this would serialize Dates as ISO strings.

                  Date.prototype.toJSON = function (key) {
                      function f(n) {
                          // Format integers to have at least two digits.
                          return n < 10 ? '0' + n : n;
                      }

                      return this.getUTCFullYear()   + '-' +
                           f(this.getUTCMonth() + 1) + '-' +
                           f(this.getUTCDate())      + 'T' +
                           f(this.getUTCHours())     + ':' +
                           f(this.getUTCMinutes())   + ':' +
                           f(this.getUTCSeconds())   + 'Z';
                  };

              You can provide an optional replacer method. It will be passed the
              key and value of each member, with this bound to the containing
              object. The value that is returned from your method will be
              serialized. If your method returns undefined, then the member will
              be excluded from the serialization.

              If the replacer parameter is an array of strings, then it will be
              used to select the members to be serialized. It filters the results
              such that only members with keys listed in the replacer array are
              stringified.

              Values that do not have JSON representations, such as undefined or
              functions, will not be serialized. Such values in objects will be
              dropped; in arrays they will be replaced with null. You can use
              a replacer function to replace those with JSON values.
              JSON.stringify(undefined) returns undefined.

              The optional space parameter produces a stringification of the
              value that is filled with line breaks and indentation to make it
              easier to read.

              If the space parameter is a non-empty string, then that string will
              be used for indentation. If the space parameter is a number, then
              the indentation will be that many spaces.

              Example:

              text = JSON.stringify(['e', {pluribus: 'unum'}]);
              // text is '["e",{"pluribus":"unum"}]'


              text = JSON.stringify(['e', {pluribus: 'unum'}], null, '\t');
              // text is '[\n\t"e",\n\t{\n\t\t"pluribus": "unum"\n\t}\n]'

              text = JSON.stringify([new Date()], function (key, value) {
                  return this[key] instanceof Date ?
                      'Date(' + this[key] + ')' : value;
              });
              // text is '["Date(---current time---)"]'


          JSON.parse(text, reviver)
              This method parses a JSON text to produce an object or array.
              It can throw a SyntaxError exception.

              The optional reviver parameter is a function that can filter and
              transform the results. It receives each of the keys and values,
              and its return value is used instead of the original value.
              If it returns what it received, then the structure is not modified.
              If it returns undefined then the member is deleted.

              Example:

              // Parse the text. Values that look like ISO date strings will
              // be converted to Date objects.

              myData = JSON.parse(text, function (key, value) {
                  var a;
                  if (typeof value === 'string') {
                      a =
  /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)Z$/.exec(value);
                      if (a) {
                          return new Date(Date.UTC(+a[1], +a[2] - 1, +a[3], +a[4],
                              +a[5], +a[6]));
                      }
                  }
                  return value;
              });

              myData = JSON.parse('["Date(09/09/2001)"]', function (key, value) {
                  var d;
                  if (typeof value === 'string' &&
                          value.slice(0, 5) === 'Date(' &&
                          value.slice(-1) === ')') {
                      d = new Date(value.slice(5, -1));
                      if (d) {
                          return d;
                      }
                  }
                  return value;
              });


      This is a reference implementation. You are free to copy, modify, or
      redistribute.
  */

  /*jslint evil: true, strict: false, regexp: false */

  /*members "", "\b", "\t", "\n", "\f", "\r", "\"", JSON, "\\", apply,
      call, charCodeAt, getUTCDate, getUTCFullYear, getUTCHours,
      getUTCMinutes, getUTCMonth, getUTCSeconds, hasOwnProperty, join,
      lastIndex, length, parse, prototype, push, replace, slice, stringify,
      test, toJSON, toString, valueOf
  */


  // Create a JSON object only if one does not already exist. We create the
  // methods in a closure to avoid creating global variables.

  !function (context) {
      "use strict";

      var JSON;
      if (context.JSON) {
          return;
      } else {
          context['JSON'] = JSON = {};
      }

      function f(n) {
          // Format integers to have at least two digits.
          return n < 10 ? '0' + n : n;
      }

      if (typeof Date.prototype.toJSON !== 'function') {

          Date.prototype.toJSON = function (key) {

              return isFinite(this.valueOf()) ?
                  this.getUTCFullYear()     + '-' +
                  f(this.getUTCMonth() + 1) + '-' +
                  f(this.getUTCDate())      + 'T' +
                  f(this.getUTCHours())     + ':' +
                  f(this.getUTCMinutes())   + ':' +
                  f(this.getUTCSeconds())   + 'Z' : null;
          };

          String.prototype.toJSON      =
              Number.prototype.toJSON  =
              Boolean.prototype.toJSON = function (key) {
                  return this.valueOf();
              };
      }

      var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
          escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
          gap,
          indent,
          meta = {    // table of character substitutions
              '\b': '\\b',
              '\t': '\\t',
              '\n': '\\n',
              '\f': '\\f',
              '\r': '\\r',
              '"' : '\\"',
              '\\': '\\\\'
          },
          rep;


      function quote(string) {

  // If the string contains no control characters, no quote characters, and no
  // backslash characters, then we can safely slap some quotes around it.
  // Otherwise we must also replace the offending characters with safe escape
  // sequences.

          escapable.lastIndex = 0;
          return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
              var c = meta[a];
              return typeof c === 'string' ? c :
                  '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
          }) + '"' : '"' + string + '"';
      }


      function str(key, holder) {

  // Produce a string from holder[key].

          var i,          // The loop counter.
              k,          // The member key.
              v,          // The member value.
              length,
              mind = gap,
              partial,
              value = holder[key];

  // If the value has a toJSON method, call it to obtain a replacement value.

          if (value && typeof value === 'object' &&
                  typeof value.toJSON === 'function') {
              value = value.toJSON(key);
          }

  // If we were called with a replacer function, then call the replacer to
  // obtain a replacement value.

          if (typeof rep === 'function') {
              value = rep.call(holder, key, value);
          }

  // What happens next depends on the value's type.

          switch (typeof value) {
          case 'string':
              return quote(value);

          case 'number':

  // JSON numbers must be finite. Encode non-finite numbers as null.

              return isFinite(value) ? String(value) : 'null';

          case 'boolean':
          case 'null':

  // If the value is a boolean or null, convert it to a string. Note:
  // typeof null does not produce 'null'. The case is included here in
  // the remote chance that this gets fixed someday.

              return String(value);

  // If the type is 'object', we might be dealing with an object or an array or
  // null.

          case 'object':

  // Due to a specification blunder in ECMAScript, typeof null is 'object',
  // so watch out for that case.

              if (!value) {
                  return 'null';
              }

  // Make an array to hold the partial results of stringifying this object value.

              gap += indent;
              partial = [];

  // Is the value an array?

              if (Object.prototype.toString.apply(value) === '[object Array]') {

  // The value is an array. Stringify every element. Use null as a placeholder
  // for non-JSON values.

                  length = value.length;
                  for (i = 0; i < length; i += 1) {
                      partial[i] = str(i, value) || 'null';
                  }

  // Join all of the elements together, separated with commas, and wrap them in
  // brackets.

                  v = partial.length === 0 ? '[]' : gap ?
                      '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']' :
                      '[' + partial.join(',') + ']';
                  gap = mind;
                  return v;
              }

  // If the replacer is an array, use it to select the members to be stringified.

              if (rep && typeof rep === 'object') {
                  length = rep.length;
                  for (i = 0; i < length; i += 1) {
                      if (typeof rep[i] === 'string') {
                          k = rep[i];
                          v = str(k, value);
                          if (v) {
                              partial.push(quote(k) + (gap ? ': ' : ':') + v);
                          }
                      }
                  }
              } else {

  // Otherwise, iterate through all of the keys in the object.

                  for (k in value) {
                      if (Object.prototype.hasOwnProperty.call(value, k)) {
                          v = str(k, value);
                          if (v) {
                              partial.push(quote(k) + (gap ? ': ' : ':') + v);
                          }
                      }
                  }
              }

  // Join all of the member texts together, separated with commas,
  // and wrap them in braces.

              v = partial.length === 0 ? '{}' : gap ?
                  '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}' :
                  '{' + partial.join(',') + '}';
              gap = mind;
              return v;
          }
      }

  // If the JSON object does not yet have a stringify method, give it one.

      if (typeof JSON.stringify !== 'function') {
          JSON.stringify = function (value, replacer, space) {

  // The stringify method takes a value and an optional replacer, and an optional
  // space parameter, and returns a JSON text. The replacer can be a function
  // that can replace values, or an array of strings that will select the keys.
  // A default replacer method can be provided. Use of the space parameter can
  // produce text that is more easily readable.

              var i;
              gap = '';
              indent = '';

  // If the space parameter is a number, make an indent string containing that
  // many spaces.

              if (typeof space === 'number') {
                  for (i = 0; i < space; i += 1) {
                      indent += ' ';
                  }

  // If the space parameter is a string, it will be used as the indent string.

              } else if (typeof space === 'string') {
                  indent = space;
              }

  // If there is a replacer, it must be a function or an array.
  // Otherwise, throw an error.

              rep = replacer;
              if (replacer && typeof replacer !== 'function' &&
                      (typeof replacer !== 'object' ||
                      typeof replacer.length !== 'number')) {
                  throw new Error('JSON.stringify');
              }

  // Make a fake root object containing our value under the key of ''.
  // Return the result of stringifying the value.

              return str('', {'': value});
          };
      }


  // If the JSON object does not yet have a parse method, give it one.

      if (typeof JSON.parse !== 'function') {
          JSON.parse = function (text, reviver) {

  // The parse method takes a text and an optional reviver function, and returns
  // a JavaScript value if the text is a valid JSON text.

              var j;

              function walk(holder, key) {

  // The walk method is used to recursively walk the resulting structure so
  // that modifications can be made.

                  var k, v, value = holder[key];
                  if (value && typeof value === 'object') {
                      for (k in value) {
                          if (Object.prototype.hasOwnProperty.call(value, k)) {
                              v = walk(value, k);
                              if (v !== undefined) {
                                  value[k] = v;
                              } else {
                                  delete value[k];
                              }
                          }
                      }
                  }
                  return reviver.call(holder, key, value);
              }


  // Parsing happens in four stages. In the first stage, we replace certain
  // Unicode characters with escape sequences. JavaScript handles many characters
  // incorrectly, either silently deleting them, or treating them as line endings.

              text = String(text);
              cx.lastIndex = 0;
              if (cx.test(text)) {
                  text = text.replace(cx, function (a) {
                      return '\\u' +
                          ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                  });
              }

  // In the second stage, we run the text against regular expressions that look
  // for non-JSON patterns. We are especially concerned with '()' and 'new'
  // because they can cause invocation, and '=' because it can cause mutation.
  // But just to be safe, we want to reject all unexpected forms.

  // We split the second stage into 4 regexp operations in order to work around
  // crippling inefficiencies in IE's and Safari's regexp engines. First we
  // replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
  // replace all simple value tokens with ']' characters. Third, we delete all
  // open brackets that follow a colon or comma or that begin the text. Finally,
  // we look to see that the remaining characters are only whitespace or ']' or
  // ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

              if (/^[\],:{}\s]*$/
                      .test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')
                          .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')
                          .replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

  // In the third stage we use the eval function to compile the text into a
  // JavaScript structure. The '{' operator is subject to a syntactic ambiguity
  // in JavaScript: it can begin a block or an object literal. We wrap the text
  // in parens to eliminate the ambiguity.

                  j = eval('(' + text + ')');

  // In the optional fourth stage, we recursively walk the new structure, passing
  // each name/value pair to a reviver function for possible transformation.

                  return typeof reviver === 'function' ?
                      walk({'': j}, '') : j;
              }

  // If the text is not JSON parseable, then a SyntaxError is thrown.

              throw new SyntaxError('JSON.parse');
          };
      }
  }(this);
  if (typeof provide == "function") provide("ender-json", module.exports);

  !function($) {
      return $.ender({
          JSON: JSON
      });
  }(ender);
}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  // Generated by CoffeeScript 1.3.3
  (function() {
    var $, Formwatcher, Watcher, inputSelector,
      __slice = [].slice,
      __hasProp = {}.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

    $ = ender;

    $.ender({
      fwData: function(name, value) {
        var formwatcherAttributes;
        if (this.data("_formwatcher") == null) {
          this.data("_formwatcher", {});
        }
        if (name == null) {
          return this;
        }
        formwatcherAttributes = this.data("_formwatcher");
        if (value != null) {
          formwatcherAttributes[name] = value;
          this.data("_formwatcher", formwatcherAttributes);
          return this;
        } else {
          return formwatcherAttributes[name];
        }
      }
    }, true);

    inputSelector = "input, textarea, select, button";

    Formwatcher = {
      version: "2.1.9",
      debugging: false,
      debug: function() {
        if (this.debugging && ((typeof console !== "undefined" && console !== null ? console.debug : void 0) != null)) {
          return console.debug.apply(console, arguments);
        }
      },
      getErrorsElement: function(elements, createIfNotFound) {
        var errors, input;
        input = elements.input;
        if (input.attr("name")) {
          errors = $("#" + (input.attr('name')) + "-errors");
        }
        if (!((errors != null ? errors.length : void 0) || !input.attr("id"))) {
          errors = $("#" + (input.attr('id')) + "-errors");
        }
        if (!errors || !errors.length) {
          errors = $.create("<small />");
          if (input.attr("name")) {
            errors.attr("id", input.attr("name") + "-errors");
          }
          errors.insertAfter(input);
        }
        return errors.hide().addClass("errors").addClass("fw-errors");
      },
      deepExtend: function() {
        var extenders, key, object, other, val, _i, _len;
        object = arguments[0], extenders = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        if (object == null) {
          return {};
        }
        for (_i = 0, _len = extenders.length; _i < _len; _i++) {
          other = extenders[_i];
          for (key in other) {
            if (!__hasProp.call(other, key)) continue;
            val = other[key];
            if (!((object[key] != null) && typeof val === "object")) {
              object[key] = val;
            } else {
              object[key] = this.deepExtend(object[key], val);
            }
          }
        }
        return object;
      },
      getLabel: function(elements, automatchLabel) {
        var input, label, parent;
        input = elements.input;
        if (input.attr("id")) {
          label = $("label[for=" + input.attr("id") + "]");
          if (!label.length) {
            label = undefined;
          }
        }
        if (!label && automatchLabel) {
          parent = input.parent();
          if (parent.get(0).nodeName === "LABEL") {
            label = $("span", parent).first();
            if (label.length === 0) {
              label = void 0;
            }
          } else {
            label = input.previous();
            if (!label.length || label.get(0).nodeName !== "LABEL" || (label.attr("for") != null)) {
              label = void 0;
            }
          }
        }
        return label;
      },
      changed: function(elements, watcher) {
        var input;
        input = elements.input;
        if (!input.fwData("forceValidationOnChange") && (input.attr("type") === "checkbox" && input.fwData("previouslyChecked") === !!input[0].checked) || (input.fwData("previousValue") === input.val())) {
          return;
        }
        input.fwData("forceValidationOnChange", false);
        this.setPreviousValueToCurrentValue(elements);
        if ((input.attr("type") === "checkbox") && (input.fwData("initialyChecked") !== !!input[0].checked) || (input.attr("type") !== "checkbox") && (input.fwData("initialValue") !== input.val())) {
          Formwatcher.setChanged(elements, watcher);
        } else {
          Formwatcher.unsetChanged(elements, watcher);
        }
        if (watcher.options.validate) {
          return watcher.validateElements(elements);
        }
      },
      setChanged: function(elements, watcher) {
        var element, i, input;
        input = elements.input;
        if (input.fwData("changed")) {
          return;
        }
        for (i in elements) {
          if (!__hasProp.call(elements, i)) continue;
          element = elements[i];
          element.addClass("changed");
        }
        input.fwData("changed", true);
        if (!watcher.options.submitUnchanged) {
          Formwatcher.restoreName(elements);
        }
        if (watcher.options.submitOnChange && watcher.options.ajax) {
          return watcher.submitForm();
        }
      },
      unsetChanged: function(elements, watcher) {
        var element, i, input;
        input = elements.input;
        if (!input.fwData("changed")) {
          return;
        }
        for (i in elements) {
          if (!__hasProp.call(elements, i)) continue;
          element = elements[i];
          element.removeClass("changed");
        }
        input.fwData("changed", false);
        if (!watcher.options.submitUnchanged) {
          return Formwatcher.removeName(elements);
        }
      },
      storeInitialValue: function(elements) {
        var input;
        input = elements.input;
        if (input.attr("type") === "checkbox") {
          input.fwData("initialyChecked", !!input[0].checked);
        } else {
          input.fwData("initialValue", input.val());
        }
        return this.setPreviousValueToInitialValue(elements);
      },
      restoreInitialValue: function(elements) {
        var input;
        input = elements.input;
        if (input.attr("type") === "checkbox") {
          input.attr("checked", input.fwData("initialyChecked"));
        } else {
          input.val(input.fwData("initialValue"));
        }
        return this.setPreviousValueToInitialValue(elements);
      },
      setPreviousValueToInitialValue: function(elements) {
        var input;
        input = elements.input;
        if (input.attr("type") === "checkbox") {
          return input.fwData("previouslyChecked", input.fwData("initialyChecked"));
        } else {
          return input.fwData("previousValue", input.fwData("initialValue"));
        }
      },
      setPreviousValueToCurrentValue: function(elements) {
        var input;
        input = elements.input;
        if (input.attr("type") === "checkbox") {
          return input.fwData("previouslyChecked", !!input[0].checked);
        } else {
          return input.fwData("previousValue", input.val());
        }
      },
      removeName: function(elements) {
        var input;
        input = elements.input;
        if (input.attr("type") === "checkbox") {
          return;
        }
        if (!input.fwData("name")) {
          input.fwData("name", input.attr("name") || "");
        }
        return input.attr("name", "");
      },
      restoreName: function(elements) {
        var input;
        input = elements.input;
        if (input.attr("type") === "checkbox") {
          return;
        }
        return input.attr("name", input.fwData("name"));
      },
      decorators: [],
      decorate: function(watcher, input) {
        var dec, decorator, _i, _len, _ref;
        decorator = null;
        _ref = watcher.decorators;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dec = _ref[_i];
          if (dec.accepts(input)) {
            decorator = dec;
            break;
          }
        }
        if (decorator) {
          Formwatcher.debug("Decorator \"" + decorator.name + "\" found for input field \"" + input.attr("name") + "\".");
          return decorator.decorate(input);
        } else {
          return {
            input: input
          };
        }
      },
      validators: [],
      currentWatcherId: 0,
      watchers: [],
      add: function(watcher) {
        return this.watchers[watcher.id] = watcher;
      },
      get: function(id) {
        return this.watchers[id];
      },
      getAll: function() {
        return this.watchers;
      },
      scanDocument: function() {
        var formId, handleForm, _results,
          _this = this;
        handleForm = function(form) {
          var domOptions, formId, options;
          form = $(form);
          if (form.fwData("watcher")) {
            return;
          }
          formId = form.attr("id");
          options = (formId != null) && (Formwatcher.options[formId] != null) ? Formwatcher.options[formId] : {};
          domOptions = form.data("fw");
          if (domOptions) {
            options = _this.deepExtend(options, JSON.parse(domOptions));
          }
          return new Watcher(form, options);
        };
        $("form[data-fw]").each(function(form) {
          return handleForm(form);
        });
        _results = [];
        for (formId in Formwatcher.options) {
          _results.push(handleForm($("#" + formId)));
        }
        return _results;
      },
      watch: function(form, options) {
        return $.domReady(function() {
          return new Watcher(form, options);
        });
      }
    };

    Formwatcher._ElementWatcher = (function() {

      _ElementWatcher.prototype.name = "No name";

      _ElementWatcher.prototype.description = "No description";

      _ElementWatcher.prototype.nodeNames = null;

      _ElementWatcher.prototype.classNames = [];

      _ElementWatcher.prototype.defaultOptions = {};

      _ElementWatcher.prototype.options = null;

      function _ElementWatcher(watcher) {
        var _ref;
        this.watcher = watcher;
        this.options = Formwatcher.deepExtend({}, this.defaultOptions, (_ref = watcher.options[this.name]) != null ? _ref : {});
      }

      _ElementWatcher.prototype.accepts = function(input) {
        var className, correctClassNames, correctNodeName, inputNodeName, nodeName, _i, _j, _len, _len1, _ref, _ref1;
        if ((this.watcher.options[this.name] != null) && this.watcher.options[this.name] === false) {
          return false;
        }
        correctNodeName = false;
        inputNodeName = input.get(0).nodeName;
        _ref = this.nodeNames;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          nodeName = _ref[_i];
          if (inputNodeName === nodeName) {
            correctNodeName = true;
            break;
          }
        }
        if (!correctNodeName) {
          return false;
        }
        correctClassNames = true;
        _ref1 = this.classNames;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          className = _ref1[_j];
          if (!input.hasClass(className)) {
            correctClassNames = false;
            break;
          }
        }
        return correctClassNames;
      };

      return _ElementWatcher;

    })();

    Formwatcher.Decorator = (function(_super) {

      __extends(Decorator, _super);

      function Decorator() {
        return Decorator.__super__.constructor.apply(this, arguments);
      }

      Decorator.prototype.decorate = function(watcher, input) {
        return {
          input: input
        };
      };

      return Decorator;

    })(Formwatcher._ElementWatcher);

    Formwatcher.Validator = (function(_super) {

      __extends(Validator, _super);

      function Validator() {
        return Validator.__super__.constructor.apply(this, arguments);
      }

      Validator.prototype.nodeNames = ["INPUT", "TEXTAREA", "SELECT"];

      Validator.prototype.validate = function(sanitizedValue, input) {
        return true;
      };

      Validator.prototype.sanitize = function(value) {
        return value;
      };

      return Validator;

    })(Formwatcher._ElementWatcher);

    Formwatcher.defaultOptions = {
      ajax: false,
      ajaxMethod: null,
      validate: true,
      submitOnChange: false,
      submitUnchanged: true,
      submitFormIfAllUnchanged: false,
      resetFormAfterSubmit: false,
      automatchLabel: true,
      responseCheck: function(data) {
        return !data;
      },
      onSubmit: function() {},
      onSuccess: function(data) {},
      onError: function(data) {
        return alert(data);
      },
      onComplete: function(data) {}
    };

    Formwatcher.options = {};

    Watcher = (function() {

      function Watcher(form, options) {
        var Decorator, Validator, hiddenSubmitButtonElement, submitButtons, _i, _j, _len, _len1, _ref, _ref1, _ref2,
          _this = this;
        this.form = typeof form === "string" ? $("#" + form) : $(form);
        if (this.form.length < 1) {
          throw "Form element not found.";
        } else if (this.form.length > 1) {
          throw "More than one form was found.";
        } else if (this.form.get(0).nodeName !== "FORM") {
          throw "The element was not a form.";
        }
        this.allElements = [];
        this.id = Formwatcher.currentWatcherId++;
        Formwatcher.add(this);
        this.observers = {};
        this.form.fwData("watcher", this);
        this.form.fwData("originalAction", this.form.attr("action") || "").attr("action", "javascript:undefined;");
        this.options = Formwatcher.deepExtend({}, Formwatcher.defaultOptions, options || {});
        this.decorators = [];
        this.validators = [];
        _ref = Formwatcher.decorators;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          Decorator = _ref[_i];
          this.decorators.push(new Decorator(this));
        }
        _ref1 = Formwatcher.validators;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          Validator = _ref1[_j];
          this.validators.push(new Validator(this));
        }
        if (this.options.ajaxMethod === null) {
          this.options.ajaxMethod = (_ref2 = this.form.attr("method")) != null ? _ref2.toLowerCase() : void 0;
        }
        switch (this.options.ajaxMethod) {
          case "post":
          case "put":
          case "delete":
            break;
          default:
            this.options.ajaxMethod = "get";
        }
        this.observe("submit", this.options.onSubmit);
        this.observe("success", this.options.onSuccess);
        this.observe("error", this.options.onError);
        this.observe("complete", this.options.onComplete);
        $(inputSelector, this.form).each(function(input) {
          var element, elements, errorsElement, i, label, onchangeFunction, validateElementsFunction, validator, _k, _len2, _ref3, _results;
          input = $(input);
          if (!input.fwData("initialized")) {
            if (input.attr("type") === "hidden") {
              return input.fwData("forceSubmission", true);
            } else {
              elements = Formwatcher.decorate(_this, input);
              if (elements.input.get() !== input.get()) {
                elements.input.attr("class", input.attr("class"));
                input = elements.input;
              }
              if (!elements.label) {
                label = Formwatcher.getLabel(elements, _this.options.automatchLabel);
                if (label) {
                  elements.label = label;
                }
              }
              if (!elements.errors) {
                errorsElement = Formwatcher.getErrorsElement(elements, true);
                elements.errors = errorsElement;
              }
              _this.allElements.push(elements);
              input.fwData("validators", []);
              _ref3 = _this.validators;
              for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
                validator = _ref3[_k];
                if (validator.accepts(input, _this)) {
                  Formwatcher.debug("Validator \"" + validator.name + "\" found for input field \"" + input.attr("name") + "\".");
                  input.fwData("validators").push(validator);
                }
              }
              Formwatcher.storeInitialValue(elements);
              if (input.val() === null || !input.val()) {
                for (i in elements) {
                  element = elements[i];
                  element.addClass("empty");
                }
              }
              if (!_this.options.submitUnchanged) {
                Formwatcher.removeName(elements);
              }
              onchangeFunction = function() {
                return Formwatcher.changed(elements, _this);
              };
              validateElementsFunction = function() {
                return _this.validateElements(elements, true);
              };
              _results = [];
              for (i in elements) {
                element = elements[i];
                _results.push((function(element) {
                  var _this = this;
                  element.on("focus", function() {
                    return element.addClass("focus");
                  });
                  element.on("blur", function() {
                    return element.removeClass("focus");
                  });
                  element.on("change", onchangeFunction);
                  element.on("blur", onchangeFunction);
                  return element.on("keyup", validateElementsFunction);
                })(element));
              }
              return _results;
            }
          }
        });
        submitButtons = $("input[type=submit], button[type=''], button[type='submit'], button:not([type])", this.form);
        hiddenSubmitButtonElement = $.create('<input type="hidden" name="" value="" />');
        this.form.append(hiddenSubmitButtonElement);
        submitButtons.each(function(element) {
          element = $(element);
          return element.click(function(e) {
            var elementValue, tmpElementText, _ref3, _ref4;
            if (element[0].tagName === "BUTTON") {
              tmpElementText = element.text();
              element.text("");
              elementValue = (_ref3 = element.val()) != null ? _ref3 : "";
              element.text(tmpElementText);
            } else {
              elementValue = (_ref4 = element.val()) != null ? _ref4 : "";
            }
            hiddenSubmitButtonElement.attr("name", element.attr("name") || "").val(elementValue);
            _this.submitForm();
            return e.stopPropagation();
          });
        });
      }

      Watcher.prototype.callObservers = function() {
        var args, eventName, observer, _i, _len, _ref, _results;
        eventName = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        _ref = this.observers[eventName];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          observer = _ref[_i];
          _results.push(observer.apply(this, args));
        }
        return _results;
      };

      Watcher.prototype.observe = function(eventName, func) {
        if (this.observers[eventName] === undefined) {
          this.observers[eventName] = [];
        }
        this.observers[eventName].push(func);
        return this;
      };

      Watcher.prototype.stopObserving = function(eventName, func) {
        var observer;
        this.observers[eventName] = (function() {
          var _i, _len, _ref, _results;
          _ref = this.observers[eventName];
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            observer = _ref[_i];
            if (observer !== func) {
              _results.push(observer);
            }
          }
          return _results;
        }).call(this);
        return this;
      };

      Watcher.prototype.enableForm = function() {
        return $(inputSelector, this.form).removeAttr("disabled");
      };

      Watcher.prototype.disableForm = function() {
        return $(inputSelector, this.form).attr("disabled", "disabled");
      };

      Watcher.prototype.submitForm = function(e) {
        var _this = this;
        if (!this.options.validate || this.validateForm()) {
          this.callObservers("submit");
          this.form.addClass("submitting");
          if (this.options.ajax) {
            this.disableForm();
            return this.submitAjax();
          } else {
            this.form.attr("action", this.form.fwData("originalAction"));
            setTimeout(function() {
              _this.form.submit();
              return _this.disableForm();
            }, 1);
            return false;
          }
        }
      };

      Watcher.prototype.validateForm = function() {
        var elements, validated, _i, _len, _ref;
        validated = true;
        _ref = this.allElements;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          elements = _ref[_i];
          if (!this.validateElements(elements)) {
            validated = false;
          }
        }
        return validated;
      };

      Watcher.prototype.validateElements = function(elements, inlineValidating) {
        var element, i, input, sanitizedValue, validated, validationOutput, validator, _i, _j, _len, _len1, _ref, _ref1;
        input = elements.input;
        validated = true;
        if (input.fwData("validators").length) {
          if (!inlineValidating || !input.fwData("lastValidatedValue") || input.fwData("lastValidatedValue") !== input.val()) {
            input.fwData("lastValidatedValue", input.val());
            Formwatcher.debug("Validating input " + input.attr("name"));
            input.fwData("validationErrors", []);
            _ref = input.fwData("validators");
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              validator = _ref[_i];
              if (input.val() === "" && validator.name !== "Required") {
                Formwatcher.debug("Validating " + validator.name + ". Field was empty so continuing.");
                continue;
              }
              Formwatcher.debug("Validating " + validator.name);
              validationOutput = validator.validate(validator.sanitize(input.val()), input);
              if (validationOutput !== true) {
                validated = false;
                input.fwData("validationErrors").push(validationOutput);
                break;
              }
            }
            if (validated) {
              elements.errors.html("").hide();
              for (i in elements) {
                if (!__hasProp.call(elements, i)) continue;
                element = elements[i];
                element.addClass("validated");
                element.removeClass("error");
              }
              if (inlineValidating) {
                elements.input.fwData("forceValidationOnChange", true);
              }
            } else {
              for (i in elements) {
                if (!__hasProp.call(elements, i)) continue;
                element = elements[i];
                element.removeClass("validated");
              }
              if (!inlineValidating) {
                elements.errors.html(input.fwData("validationErrors").join("<br />")).show();
                for (i in elements) {
                  if (!__hasProp.call(elements, i)) continue;
                  element = elements[i];
                  element.addClass("error");
                }
              }
            }
          }
          if (!inlineValidating && validated) {
            sanitizedValue = input.fwData("lastValidatedValue");
            _ref1 = input.fwData("validators");
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              validator = _ref1[_j];
              sanitizedValue = validator.sanitize(sanitizedValue);
            }
            input.val(sanitizedValue);
          }
        } else {
          for (i in elements) {
            if (!__hasProp.call(elements, i)) continue;
            element = elements[i];
            element.addClass("validated");
          }
        }
        return validated;
      };

      Watcher.prototype.submitAjax = function() {
        var fieldCount, fields, i,
          _this = this;
        Formwatcher.debug("Submitting form via AJAX.");
        fields = {};
        fieldCount = 0;
        i = 0;
        $(inputSelector, this.form).each(function(input, i) {
          var attributeName, _ref;
          input = $(input);
          if (input[0].nodeName === "BUTTON" || (input[0].nodeName === "INPUT" && (input.attr("type").toLowerCase() === "submit" || input.attr("type").toLowerCase() === "button"))) {
            return;
          }
          if (input.fwData("forceSubmission") || (input.attr("type") && input.attr("type").toLowerCase() === "checkbox") || input.fwData('changed') || _this.options.submitUnchanged) {
            if (input.attr("type") !== "checkbox" || input.get(0).checked) {
              fieldCount++;
              attributeName = (_ref = input.attr("name")) != null ? _ref : "unnamedInput_" + i;
              return fields[attributeName] = input.val();
            }
          }
        });
        if (fieldCount === 0 && !this.options.submitFormIfAllUnchanged) {
          return setTimeout(function() {
            _this.enableForm();
            return _this.ajaxSuccess();
          }, 1);
        } else {
          return $.ajax({
            url: this.form.fwData("originalAction"),
            method: this.options.ajaxMethod,
            data: fields,
            type: "text",
            error: function(request) {
              return _this.callObservers("error", request.response);
            },
            success: function(request) {
              _this.enableForm();
              if (!_this.options.responseCheck(request.response)) {
                return _this.callObservers("error", request.response);
              } else {
                _this.callObservers("success", request.response);
                return _this.ajaxSuccess();
              }
            },
            complete: function(request) {
              _this.form.removeClass("submitting");
              return _this.callObservers("complete", request.response);
            }
          });
        }
      };

      Watcher.prototype.ajaxSuccess = function() {
        var element, elements, i, isEmpty, _i, _len, _ref, _results;
        _ref = this.allElements;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          elements = _ref[_i];
          Formwatcher.unsetChanged(elements, this);
          if (this.options.resetFormAfterSubmit) {
            Formwatcher.restoreInitialValue(elements);
          } else {
            Formwatcher.storeInitialValue(elements);
          }
          isEmpty = elements.input.val() === null || !elements.input.val();
          _results.push((function() {
            var _results1;
            _results1 = [];
            for (i in elements) {
              element = elements[i];
              if (isEmpty) {
                _results1.push(element.addClass("empty"));
              } else {
                _results1.push(element.removeClass("empty"));
              }
            }
            return _results1;
          })());
        }
        return _results;
      };

      return Watcher;

    })();

    if (typeof window !== "undefined" && window !== null) {
      window.Formwatcher = Formwatcher;
      window.Watcher = Watcher;
    }

    $.domReady(function() {
      return Formwatcher.scanDocument();
    });

  }).call(this);


  // Generated by CoffeeScript 1.3.3
  (function() {
    var trim,
      __hasProp = {}.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

    trim = function(string) {
      return string.replace(/^\s.*\s$/, "");
    };

    Formwatcher.validators.push((function(_super) {

      __extends(_Class, _super);

      function _Class() {
        return _Class.__super__.constructor.apply(this, arguments);
      }

      _Class.prototype.name = "Integer";

      _Class.prototype.description = "Makes sure a value is an integer";

      _Class.prototype.classNames = ["validate-integer"];

      _Class.prototype.validate = function(value) {
        if (value.replace(/\d*/, "") !== "") {
          return "Has to be a number.";
        }
        return true;
      };

      _Class.prototype.sanitize = function(value) {
        return trim(value);
      };

      return _Class;

    })(Formwatcher.Validator));

    Formwatcher.validators.push((function(_super) {

      __extends(_Class, _super);

      function _Class() {
        return _Class.__super__.constructor.apply(this, arguments);
      }

      _Class.prototype.name = "Required";

      _Class.prototype.description = "Makes sure the value is not blank (nothing or spaces).";

      _Class.prototype.classNames = ["required"];

      _Class.prototype.validate = function(value, input) {
        if ((input.attr("type") === "checkbox" && !input.is(":checked")) || !trim(value)) {
          return "Can not be blank.";
        }
        return true;
      };

      return _Class;

    })(Formwatcher.Validator));

    Formwatcher.validators.push((function(_super) {

      __extends(_Class, _super);

      function _Class() {
        return _Class.__super__.constructor.apply(this, arguments);
      }

      _Class.prototype.name = "NotZero";

      _Class.prototype.description = "Makes sure the value is not 0.";

      _Class.prototype.classNames = ["not-zero"];

      _Class.prototype.validate = function(value) {
        var intValue;
        intValue = parseInt(value);
        if (!isNaN(intValue) && intValue === 0) {
          return "Can not be 0.";
        }
        return true;
      };

      return _Class;

    })(Formwatcher.Validator));

    Formwatcher.validators.push((function(_super) {

      __extends(_Class, _super);

      function _Class() {
        return _Class.__super__.constructor.apply(this, arguments);
      }

      _Class.prototype.name = "Email";

      _Class.prototype.description = "Makes sure the value is an email.";

      _Class.prototype.classNames = ["validate-email"];

      _Class.prototype.validate = function(value) {
        var emailRegEx;
        emailRegEx = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!value.match(emailRegEx)) {
          return "Must be a valid email address.";
        }
        return true;
      };

      _Class.prototype.sanitize = function(value) {
        return trim(value);
      };

      return _Class;

    })(Formwatcher.Validator));

    Formwatcher.validators.push((function(_super) {

      __extends(_Class, _super);

      function _Class() {
        return _Class.__super__.constructor.apply(this, arguments);
      }

      _Class.prototype.name = "Float";

      _Class.prototype.description = "Makes sure a value is a float";

      _Class.prototype.classNames = ["validate-float"];

      _Class.prototype.defaultOptions = {
        decimalMark: ","
      };

      _Class.prototype.validate = function(value) {
        var regex;
        regex = new RegExp("\\d+(\\" + this.options.decimalMark + "\\d+)?");
        if (value.replace(regex, "") !== "") {
          return "Has to be a number.";
        }
        return true;
      };

      _Class.prototype.sanitize = function(value) {
        if (value.indexOf(".") >= 0 && value.indexOf(",") >= 0) {
          if (value.lastIndexOf(",") > value.lastIndexOf(".")) {
            value = value.replace(/\./g, "");
          } else {
            value = value.replace(/\,/g, "");
          }
        }
        if (value.indexOf(",") >= 0) {
          value = value.replace(/\,/g, ".");
        }
        if (value.indexOf(".") !== value.lastIndexOf(".")) {
          value = value.replace(/\./g, "");
        }
        value = value.replace(/\./g, this.options.decimalMark);
        return trim(value);
      };

      return _Class;

    })(Formwatcher.Validator));

  }).call(this);

  if (typeof provide == "function") provide("formwatcher", module.exports);
  $.ender(module.exports);
}());

(function () {

  var module = { exports: {} }, exports = module.exports;

  // Generated by CoffeeScript 1.3.3
  (function() {
    var $,
      __hasProp = {}.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

    $ = ender;

    Formwatcher.decorators.push((function(_super) {

      __extends(_Class, _super);

      function _Class() {
        return _Class.__super__.constructor.apply(this, arguments);
      }

      _Class.prototype.name = "Hint";

      _Class.prototype.description = "Displays a hint in an input field.";

      _Class.prototype.nodeNames = ["INPUT", "TEXTAREA"];

      _Class.prototype.defaultOptions = {
        auto: true,
        removeTrailingColon: true,
        color: "#aaa"
      };

      _Class.prototype.decParseInt = function(number) {
        return parseInt(number, 10);
      };

      _Class.prototype.accepts = function(input) {
        if (_Class.__super__.accepts.call(this, input)) {
          if ((input.data("hint") != null) || (this.options.auto && Formwatcher.getLabel({
            input: input
          }, this.watcher.options.automatchLabel))) {
            return true;
          }
        }
        return false;
      };

      _Class.prototype.decorate = function(input) {
        var changeFunction, delayChangeFunction, elements, fadeLength, hint, hintElement, inputOffset, label, leftPosition, nextTimeout, topPosition, wrapper,
          _this = this;
        elements = {
          input: input
        };
        hint = input.data("hint");
        if (!(hint != null) || !hint) {
          label = Formwatcher.getLabel(elements, this.watcher.options.automatchLabel);
          if (!label) {
            throw "The hint was empty, but there was no label.";
          }
          elements.label = label;
          label.hide();
          hint = label.html();
          if (this.options.removeTrailingColon) {
            hint = hint.replace(/\s*\:\s*$/, "");
          }
        }
        Formwatcher.debug("Using hint: " + hint);
        wrapper = $.create("<span style=\"display: inline-block; position: relative;\" />");
        wrapper.insertAfter(input);
        wrapper.append(input);
        inputOffset = {
          left: input[0].offsetLeft,
          top: input[0].offsetTop,
          width: input[0].offsetWidth,
          height: input[0].offsetHeight
        };
        leftPosition = this.decParseInt(input.css("paddingLeft")) + this.decParseInt(inputOffset.left) + this.decParseInt(input.css("borderLeftWidth")) + 2 + "px";
        topPosition = this.decParseInt(input.css("paddingTop")) + this.decParseInt(inputOffset.top) + this.decParseInt(input.css("borderTopWidth")) + "px";
        hintElement = $.create("<span />").html(hint).css({
          position: "absolute",
          display: "none",
          top: topPosition,
          left: leftPosition,
          fontSize: input.css("fontSize"),
          lineHeight: input.css("lineHeight"),
          fontFamily: input.css("fontFamily"),
          color: this.options.color
        }).addClass("hint").on("click", function() {
          return input[0].focus();
        }).insertAfter(input);
        fadeLength = 100;
        input.focusin(function() {
          if (input.val() === "") {
            return hintElement.animate({
              opacity: 0.4,
              duration: fadeLength
            });
          }
        });
        input.focusout(function() {
          if (input.val() === "") {
            return hintElement.animate({
              opacity: 1,
              duration: fadeLength
            });
          }
        });
        changeFunction = function() {
          if (input.val() === "") {
            return hintElement.show();
          } else {
            return hintElement.hide();
          }
        };
        input.keyup(changeFunction);
        input.keypress(function() {
          return setTimeout((function() {
            return changeFunction();
          }), 1);
        });
        input.keydown(function() {
          return setTimeout((function() {
            return changeFunction();
          }), 1);
        });
        input.change(changeFunction);
        nextTimeout = 10;
        delayChangeFunction = function() {
          changeFunction();
          setTimeout((function() {
            return delayChangeFunction();
          }), nextTimeout);
          nextTimeout = nextTimeout * 2;
          return nextTimeout = (nextTimeout > 10000 ? 10000 : nextTimeout);
        };
        delayChangeFunction();
        return elements;
      };

      return _Class;

    })(Formwatcher.Decorator));

  }).call(this);

  if (typeof provide == "function") provide("formwatcher-hint", module.exports);
  $.ender(module.exports);
}());