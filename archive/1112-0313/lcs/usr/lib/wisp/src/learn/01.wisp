

(import [str inc dec even? odd? vals key-values keys =] "./runtime")
(import [cons conj list list? seq vec empty? count first second third
         rest last butlast take drop count concat reverse sort map filter
         reduce] "./sequence")

(require "http")
(.-static (require "send"))
(.-programs (require "send"))
;(. (require "send") sendResponse "")
(.log console (require "send")))
