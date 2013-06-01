(ns tredius.templates.st4
  (:import (org.stringtemplate.v4 ST STGroup STGroupFile STGroupDir)))



;(def group (STGroup.))
(def groupdir (STGroupDir. "/media/data/tredius/src/tredius/templates/htmail"))

(def file (STGroupFile. "/media/data/tredius/src/tredius/templates/test/foo.stg"))
;(def group (STGroupDir. "src/tredius/templates/htmail/devices/"))
 ;(def st (. ST ))
(println (. groupdir toString))

;(def st (. groupdir getInstanceOf "htmail"))
;(def result (. st render))




;(. groupdir loadTemplate "body.st")


(defn- stringify [any]
  (if (keyword? any)
    (name any)
    (str any)))


(declare kv-to-sv)
(declare scan-kv-to-sv)


(defn- each-kv-to-sv "If element is a collection type, do deep transformation"
  [each]
  (if (map? each)
    (kv-to-sv each)
    (if (or (vector? each) (list? each) (seq? each) (set? each))
      (scan-kv-to-sv each)
      each)))


(defn- scan-kv-to-sv
  "Scans a collection and turns any contained map within from kv to sv"
  [coll]
  (map each-kv-to-sv coll))


(defn- kv-to-sv
  "Transforms keyword-value map {:a 10 :b 20 :c 30}
   to string-value map {\"a\" 10 \"b\" 20 \"c\" 30}"
  [mp]
  (let [m (into {} mp)
        k (keys m)
        v (vals m)]
    (zipmap
      (map stringify k)
      (scan-kv-to-sv v))))


(defn get-view-from-dir "Return the view template from specified directory"
  [^String view-name ^String root-dir]
  (let [st-group (STGroupDir. (str "/media/data/tredius/src/tredius/" root-dir))]
    (.getInstanceOf st-group view-name)))

(def a (get-view-from-dir "body.st" "templates/htmail"))
;(. a render)


(defn reset-view! "Reset view template with supplied content"
  [^ST view ^String template]
  (.setTemplate view template))



(defn fill-view! "Fill view template with key/value pairs"
  ;;;
  ;; Fill template with key and value
  ([^ST template k v]
    (.add template (stringify k) (each-kv-to-sv v))
    template)
  ;;;
  ;; Fill template with key/value from map
  ([^ST template kv-map]
    (.add template (kv-to-sv kv-map))
    template))


(defn render-view "Return rendered view for the template"
  [^ST template]
  (.render template))


;(. groupdir getInstanceOf "queries")