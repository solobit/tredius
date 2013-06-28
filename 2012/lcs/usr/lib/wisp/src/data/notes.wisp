  ;`(def ~name (fn ~@body)))


;; (defn create-server
;;   [port]
;;   (let [  http    (require "http")
;;           log     (fn [msg] (console.log msg))
;;           connect (fn [request response]
;;                     (fn [] (.writeHead response 200))
;;                     (fn [] (.end response "hello")) )

;;           server  (.createServer http connect)
;;           ]
;;         listen (.listen server port)))

;;(.log console (create-server 8000))

;; (defn- dpad [cfg fn]
;;     (let [dpkg (require "docpad")
;;           cnfg (nil? cfg {})
;;           nums 1]
;;           (.log console "hello")))

;;.createInstance dpkg cnfg , (fn err docpadInstance) ->
;;  console.log err.stack  if err

;; renderOpts =
;;   path: "/some/file.html.md"
;;   renderSingleExtensions: true
;;
;; docpadInstance.action "render", renderOpts, (err, result) ->
;;   console.log result
;;
;; document = docpadInstance.createDocument(data, options)
;; database = docpadInstance.getDatabase()
;; resultCollection = undefined
;; resultModel = undefined
;; resultCollection = docpadInstance.getFiles(query, sorting, paging)
;; resultModel = docpadInstance.getFile(query, sorting, paging)
;; resultCollection = docpadInstance.getFilesAtPath(path, sorting, paging)
;; resultModel = docpadInstance.getFileAtPath(path, sorting, paging)


;; (defn- docpad
;;   "Hook up multiple docpads using the API as defined by Bevry."
;;   ^{:author "R. Jentzema"
;;     :since "1.0"}
;;   [cfg qty]
;;     (let [dp (require "docpad")
;;           cf (nil? cfg {})
;;           qt (nil? qty 1)]
;;         (.createInstance dp cf)))


;; (defn dp
;;   "Public docpad"
;;   {:version "1.0"}
;;   ([] 0)
;;   ([x] x)
;;   ([x y] (+ x y))
;;   ([x & more] (more.reduce (fn [x y] (+ x y)) x)))


