
(import path "path")


;; Wisp reader
(import [breaking-whitespace? whitespace? read read-lambda
         lambda-params-hash newline? numeric? comment-prefix? number-literal?
         read-from-string] "../reader")

;; Wisp Abstract Syntax Tree
(import [meta with-meta symbol? symbol keyword? keyword namespace
         unquote? unquote-splicing? quote? syntax-quote? name gensym pr-str] "../ast")

;; TODO JavaScript reader, parser

(import [empty? count list? list first second third rest cons conj
         reverse butlast reduce reduce-list vec last map-list lazy-seq
         map take butlast sort  drop filter seq take sort concat] "../sequence")

(import [odd? even? dictionary? dictionary merge keys vals key-values contains-vector?
         map-dictionary string? object? fn? number? vector? boolean? subs re-find
         true? false? nil? re-pattern? inc dec str and char int
         or = == > >= < <= + - / *] "../runtime")

(import [split join upper-case replace] "../string")

(def company {:id "Tredius BV"})




(defn create-log-writer
  "Creates a new Winston logger instance with optionally multiple transports
  storage mediums, custom messages and much more."
  ^{:origin "https://github.com/flatiron/winston/tree/master/examples"}
 [options]
 (let [winston (require "winston")
       paths   {:base "./logs"}
       files   {:exceptions (.join path paths.base "exceptions.log")
                :all (.join path paths.base "system.log")}
       levels  {:base -0 :info 1 :verbose 2 :data 3 :done 4 :warn 5 :debug 6 :error 7}
       colors  {:base "magenta" :info "blue" :verbose "cyan" :data "grey"
                :done "green" :warn "yellow" :debug "blue" :error "red"}]

    (. winston log "info" lang.init.nl company.id)
    (. winston log "info" lang.setfs.nl (vals files))

                ))

(defn normalize [n len]
   (loop [ns (str n)]
     (if (< (count ns) len)
       (recur (str "0" ns))
       ns)))

;;(defn x [& args]
 ;;(.log console (first args) (recur (rest args))))

;;(x :a :c :e)

(create-log-writer)
;; winston.handleExceptions(new winston.transports.Console(
                            ;;{ colorize: true, json: true }))

;(defn foo [x] (+ x 1))
;(defn log [x] (. console log x))

;(. console log (read-from-string (require "stylus")))
;(. console log (require "stylus"))
;(def stylus (require "stylus")) ;; real [functions]
;(log (JSON.stringify stylus)) ;; str [Function]
;(defn src (get-file-contents "cultures.wisp"))
