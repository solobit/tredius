(ns tredius.templates.st
  (:import org.antlr.stringtemplate.StringTemplateGroup)
  (:import org.antlr.stringtemplate.StringTemplate))



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

(defn create-view "Return new view template - useful as mentioned here:
  http://hardlikesoftware.com/weblog/2006/12/12/using-json-with-stringtemplate/"
  ([]
    (StringTemplate.))
  ([^String template]
    (StringTemplate. template)))


(defn get-view-from-classpath "Return the view template from classpath"
  [^String view-name]
  (let [st-group (StringTemplateGroup. "default")]
    (.getInstanceOf st-group view-name)))


(defn get-view-from-dir "Return the view template from specified directory"
  [^String view-name ^String root-dir]
  (let [st-group (StringTemplateGroup. "default" root-dir)]
    (.getInstanceOf st-group view-name)))

(defn reset-view! "Reset view template with supplied content"
  [^StringTemplate view ^String template]
  (.setTemplate view template))


(defn fill-view! "Fill view template with key/value pairs"
  ;;;
  ;; Fill template with key and value
  ([^StringTemplate template k v]
    (.setAttribute template (stringify k) (each-kv-to-sv v))
      template)
  ;;;
  ;; Fill template with key/value from map
  ([^StringTemplate template kv-map] ;;  ^Map kv-map
    (.setAttributes template (kv-to-sv kv-map))
    template))

(defn render-view "Return rendered view for the template"
  [^StringTemplate template]
  (.toString template))

(defn enumerate [li coll]
     (let [delim (System/getProperty "line.separator")]
       (interpose delim (map #(str li % delim) coll))))

;(-> (template-group) (.getInstanceOf tmpl-name))