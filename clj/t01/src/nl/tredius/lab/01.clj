;;
;; Slurp, zip, mod tree, spit
;;

(ns nl.tredius.lab.01
  (:refer-clojure :exclude [class or and not])
  (:require [clojure.string :as string]
            [clojure.zip :as zip]
            [clojure.pprint :refer [pprint print-table]]
            [clj-http.client :as client])
  (:use     [hiccup.core]
            [hickory core select zip])
  (:import [java.net URL]
           [java.lang StringBuilder]
           [java.io BufferedReader InputStreamReader]
           [java.io StringReader StringWriter]
           [javax.xml.transform TransformerFactory OutputKeys]
           [javax.xml.transform.stream StreamSource StreamResult]))




(defn ppxml
  "Accepts an XML string with no newline formatting and returns the
  same XML with pretty-print formatting, as described by Nurullah Akaya
  in [this post](http://goo.gl/Y9OVO)."
  [xml-str]
  (let [in  (StreamSource. (StringReader. xml-str))
        out (StreamResult. (StringWriter.))
        transformer (.newTransformer
                     (TransformerFactory/newInstance))]
    (doseq [[prop val] {OutputKeys/INDENT "yes"
                        OutputKeys/METHOD "xml"
                        "{http://xml.apache.org/xslt}indent-amount" "2"}]
      (.setOutputProperty transformer prop val))
    (.transform transformer in out)
    (str (.getWriter out))))


(defn fetch-url
  "Return the web page as a string."
  [address]
  (let [url (URL. address)]
    (with-open [stream (. url (openStream))]
      (let [buf (BufferedReader. (InputStreamReader. stream))]
        (apply str (line-seq buf))))))


;;(clojure.repl/dir clojure.zip)
;(def org [\☐\☑\☒])
;(def root-loc (zip/seq-zip (seq org)))
;; zip/down moves to the leftmost child of the current loc and returns that child’s loc.
;; zip/node gives you the subtree of the original tree corresponding to its loc argument.
;(-> root-loc zip/down zip/right zip/right)

;-----------------------------

(defn scrape
  "Provide a web site URL and parse its HTML as a hickory tree."
  [target] (-> (client/get target) :body parse as-hickory))

(def parsed-frag (parse-fragment "<a href=\"foo\">foo</a> <a href=\"bar\">bar</a>"))

(def ^:dynamic *uri-slurp* "http://www.tredius.nl/index.html")

;(fetch-url *uri-slurp*)

;(as-hiccup parsed-frag) ; it cannot be directly used - you MUST walk the tree after parsing

;(defmacro some-one [a b] `('~a "who" ~b))
;(macroexpand '(some-one println "foo"))
;(some-one println "I don't like")


(defn hiccup-parsed-doc
  []
  (hiccup-zip (as-hiccup (parse (slurp *uri-slurp*)))))

(defn hickory-parsed-doc
  []
  (hickory-zip (as-hickory (parse (slurp *uri-slurp*)))))

; (defn save-file [s] (spit "foo.html" s))

;; (-> (hickory-parsed-doc)
;;     zip/down
;;     zip/right
;;     zip/node
;;     hickory-to-html
;;     ;ppxml
;;     (save-file))


;; (-> (hiccup-parsed-doc)
;;     zip/node)

;; (-> (hiccup-parsed-doc)
;;     zip/next
;;     zip/node)

;; (-> (hiccup-parsed-doc)
;;     zip/next
;;     zip/next
;;     zip/node)

;; (-> (hiccup-parsed-doc)
;;     zip/next
;;     zip/next
;;     (zip/replace [:head {:id "a"}])
;;     zip/node)

;; (-> (hiccup-parsed-doc)
;;     zip/next
;;     zip/next
;;     (zip/replace [:head {:id "a"}])
;;     zip/root)

;; (def *1 (-> (hickory-parsed-doc)
;;             zip/next
;;             zip/next
;;             (zip/replace {:type :element
;;                           :tag :head
;;                           :attrs {:id "a"}
;;                           :content nil})
;;             zip/root))

;; (hickory-to-html *1)