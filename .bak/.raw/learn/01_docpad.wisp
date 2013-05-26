
(import transpile "./engine/node")

(. (require "docpad") createInstance {})


;; Ook andere talen zijn mogelijk te gebruiken, een bekende taal die naar JavaScript transcompileert is CoffeeScript:
(require "coffee-script")

;; Ook de taal die ik gebruik is er een die naar een 'schone' functionele stijl van JavaScript compileert (zie rechtervlak) en welke gebaseerd is op de taal. Clojure gemaakt door Rich Hickey. Wisp is een taal die schone "Homoiconic JS with clojure syntax, s-expressions & macros" naar het web brengt. In tegenstelling tot ClojureScript die een oerwoud aan Google Closure Library code genereert.
(require "wisp")

;; Wat wisp doet: transpileren (transformeren/compileren) naar JavaScript
;;(.log console (transpile "(. console log \"thisthat\")"))
;(map #(* 0.01 %1) [5000 100 50]) ;=> [50 1 0.5]

;; JavaScript is een scripttaal die veel gebruikt wordt om webpagina's interactief te maken en webapplicaties te ontwikkelen. JavaScript kan ook gebruikt worden voor server-side scripting. De laatste jaren maakt node.js een grote opgang.

;; Node.js projecten worden, indien gewenst ingelezen door het 'npm' programma en kan hier uit diverse gegevens over afhankelijke software, auteurs(rechten), onderhoud, downloads, en dergelijke meta-gegevens uitlezen. De `./` verwijst naar de bronmap.

;;(defmacro define-fn
;;  [name & body]
;;  `(def ~name (fn ~@body)))

;; Gebruik: (genereer-stijlblad "huisstijl.css")
;; TODO parameters........v
;; Main routines
;; =============

;; Web site
;; Momenteel is de site omschreven in CoffeeScript HTML. De variabelen bevinden zich in een centraal docpad config bestand. Daarnaast is er meta-data omschreven in de koppen


;; Stijlen
;; -------


;; Verbeterde static server
;; #(foo %2 bar %)       ; (fn [a b] (foo b bar a))
;; The #() syntax is intended for very short functions being passed as arguments. It takes parameters named %, %2, %3, %n ... %&.
;; #(* 4 %2 2 %)
