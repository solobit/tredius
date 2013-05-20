
(import [read-from-string] "./reader")
(import [meta with-meta symbol? symbol keyword? keyword namespace
         unquote? unquote-splicing? quote? syntax-quote? name gensym pr-str] "./ast")
(import [empty? count list? list first second third rest cons conj
         reverse reduce vec last
         map filter take concat] "./sequence")
(import [odd? dictionary? dictionary merge keys vals contains-vector?
         map-dictionary string? number? vector? boolean? subs re-find
         true? false? nil? re-pattern? inc dec str char int = ==] "./runtime")
(import [split join upper-case replace] "./string")

(def version "0.0.1")
(def isMaster (== true (require "cluster")))
(def num-cpus (:length (.cpus (require "os"))))
(def filetypes {:litcoffee ".litcoffee .coffee.md" :coffee ".coffee"
                :wisp ".wisp":json ".json" :cson "cson"})



; (. (require "docpad") createInstance {})

(defn http-server
 "Create a basic HTTP server as demonstrated by Node.js example. Accepts a
 single argument port to listen on or throws an error."
 [port]
 ;; local binding forms to the lexical scope (member vars)
 (let [ body "Connection successful!"]

  ;; object method accessor
  (. (. (require "http") createServer
    (fn [req res] (. console log (join ["request for: " req.url "\n"]))
    (. res writeHead 200 {:Content-Length (.-length body)})
    (. res end body)))
   listen port)))


(http-server)

(defmacro chain
  ([x form] (list '. x form))
  ([x form & more] (concat (list 'chain (list '. x form)) more)))

