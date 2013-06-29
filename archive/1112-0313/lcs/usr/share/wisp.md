
# You don't know what you don't know

And you don't know which questions to ask, so how can you ever find the answer?

* RTFM
* j er[1kjqwb ed&532
* lol
* Google

Let's walk by those bullets for a short moment and review. Read 

;; Modules are cached after the first time they are loaded. Among
;; others, every call to require('foo') will get exactly the same
;; object returned, **if it would resolve to the same file**.



; >>> Folder
 
 ;; (isPredicate [] predicate?)
 ;; (isConvention [] convention?)
 ;; (log (== 1 1))
 ;; (log (typeof module))
 ;; (log (typeof Null))     ;=> undefined
 ;; (log (typeof null))     ;=> object
 ;; (log (typeof true))     ;=> boolean
 
 ;; (log (typeof backslash-w))       ;=> string
 ; /usr/local/lib/node_modules/wisp/lib/reader.js:120
 ; return (function() { throw error; })();
 ; SyntaxError: Unexpected unicode escape backslash-w

 ;; (log (typeof "str"))    ;=> string
 ;; (log (typeof 1))        ;=> number

 ;(log (module? module))
 ;(log module)

 ;; (log (obj? null))
 ;; (log (bool? true))
 ;; (log (str? a))
 ;; (log (str? "welcome"))
 ;; (log (num? 6))
 ;; (log (obj? module))

 ;;["a" "b"]
 ;(log (nil? nil nil))
