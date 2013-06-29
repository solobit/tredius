
(defmacro ~> 
 [x]
 (log "blah"))

;(def --> "haha")
;(log -->)


(log module.filename)
(log __filename)

(defmacro define-fn
  [name & body]
  `(def ~name (fn ~@body)))


(defmacro import-deps
  [name & body]
  `(def ~name (require ~@body)))

(import-deps natural "natural")



(define-fn print
  [message]
  (.log console message))