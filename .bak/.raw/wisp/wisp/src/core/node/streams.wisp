

;; TODO inspect own root and any paths given to us

(defn stream-json []
  (let [request (require "request")
        JSONStream (require "JSONStream")
        es (require "event-stream")
        parser (JSONStream.parse ["rows" true "docs"])
        req (request {:url "http://isaacs.couchone.com/registry/_all_docs"})
        logger (es.mapSync (fn [data] (console.error data) data))]
    (req.pipe parser)
    (parser.pipe logger)))

(stream-json)









;; (defineer-kleur paars palet.paars)
;; (log (paars.luminosity))

;; (loop [p palet]
;;  (log p))

;; (log paars)

;; (def color (require "color"))
;; (object? color) ;=> false
;; (log (object? (color "#363636")))
;;
;; (log (pretty-print (dump-prototype (color "#232323"))))
;; (log (inc 1))
;; (log (map inc [1 2 3 4])) ;; map is a higher-order function (HOF)

;; (defn a [x & rest]
;;   (rest.reduce (fn [sum x] (+ sum x)) x))

;; (log (a 2 3 4))

;; (defn xx [] (require "color"))
;; ;(log (. ((require "color") "#363636") toString)))
;; (log (JSON.stringify ((require "color") "#363636"))))

;; ;(loop [d gegevens.vormgeving.kleuren] (log (keys d)));;`(def ~@(keys d) ~@(vals d)))


;; (defn normalize [n len]
;;   (loop [ns (str n)]
;;     (if (< (count ns) len)
;;       (recur (str "0" ns))
;;       ns)))

;(log (map-dictionary gegevens.vormgeving.kleuren )))

;(defn [x] (. (kleur x) luminosity)



;; (defn- dirp [pad extensie]
;;   "Doorloop recursief een mappenstructuur en
;;   geef een stream API van bestanden retour."
;;   (let [readdirp (require "readdirp")
;;         es       (require "event-stream")
;;         options  {:root pad :fileFilter extensie}
;;         stream   (readdirp options)]
;;      (. stream on "warn" (fn [error] (try (raise exception) (catch error (.warn console (str "Non-fatal error: " error))))))
;;      (. stream on "error" (fn [error] (try (raise exception) (catch error (.error console (str "Fatal: " error))))))
;;      (. stream pipe (es.mapSync (fn [entry] {:path entry.path :size entry.stat.size})))
;;      (. stream es.stringify)
;;      (. stream pipe (.stdout process))))
;;
;; (dirp "./" "*.wisp")
