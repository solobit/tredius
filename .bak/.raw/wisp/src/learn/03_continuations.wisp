
(import [list list? empty? count empty? first second third rest map vec
         cons conj rest concat last butlast sort] "./sequence")

(import [odd? dictionary keys nil? inc dec vector? string?
         number? boolean? object? dictionary?
         re-pattern re-matches re-find str subs char vals = ==] "./runtime")

(import [symbol? symbol keyword? keyword meta with-meta name] "./ast")

(import [split join] "./string")

;; the continuation: ability to save executation state at any point and return
;; to that point later in the program
(def program-state [])
(def another-continuation '())
(def some-contfunc (fn))
(def saved? false)


(. console log (empty? program-state))

(. console log saved?)


