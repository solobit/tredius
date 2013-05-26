(import [str inc dec nil? even? odd? vals key-values keys =] "./runtime")
(import [cons conj list list? seq vec empty? count first second third rest last butlast
         take drop concat reverse sort map filter reduce] "./sequence")

(def gegevens {
  ;; Kleuren lichter, donkerder, transformeren van en naar CSS.
  :kleuren {:oranje "#F2A34F"
            :wit    "#ffffff"    :zwart       "#363636"
            :geel   "#7A6A42"    :goud        "#b88d74"
            :groen  "#7FC028"    :turquoise   "#6CBBB8"
            :bruin  "#6b4c39"    :licht-bruin "#b88c74"
            :paars  "#47427A"    :licht-paars "#6664a0"
            :blaauw "#0183b5"    :licht-blauw "#0183b5"   :donker-blauw "#403e6b"
            :grijs  "#e0e0e0"    :licht-grijs "#f8f8f8"   :donker-grijs "#919191"
            :rood   "#e31741"    :licht-rood  "#6b4c39"}

})
(.log console (map #(* 2 %1) [2 3 4]))
;(.log console (map (partial * 0.01) [5000 100 50]))


;(def component (require "component"))
;(. console log component)
(def x {:testr {:some {:foo "abc"
                      :bar "def"
                      :baz (fn [] (. console log this.foo))}}})

(x.testr.some.baz)

(.exit process 1)

;(log (map ["#363636" "orange" [255,255,255]] (. (kleur c) luminosity)  )))
;(log (. (kleur "#363636") luminosity))
;(log (map-dictionary {:a 2 :b 4} +))

;(log (gegevens.vormgeving.kleuren.paars.hexString))

;(. console log (dictionary? palet))
; (. console log (JSON.stringify palet))
; (. console log (merge {:a "aa"} {b: "bb"}))
 ;;(filter (== ))
 ;;(kleur )
;;   (log (.rgb palet.paars))
;;   (log (.rgbArray palet.paars))
;;   (log (palet.oranje.rgbArray))
;;   (log (palet.oranje.hslString))


 ;; (loop [kl gegevens.vormgeving.kleuren]
 ;;  (let [exemplaar (require "colors")
 ;;        sleutel   (keys kl)
 ;;        waarde    (vals kl)]
 ;;  (log sleutel)
 ;;  (log waarde)
 ;;  ;`(def ~(symbol sleutel) (. exemplaar ~@waarde))
 ;;  )))


(def archy (require "archy"))

(def s (archy {
  :label  "beep",
  :nodes  [
    "ity",
    {
      :label  "boop",
      :nodes  [
        {
          :label  "o_O",
          :nodes  [
            {
              :label  "oh",
              :nodes  [ "hello", "puny" ]
            },
            "human"
          ]
        },
        "party\ntime!"
      ]
    }
  ]
}))
(. console log s)



;(defn pretty-print []
;"https://github.com/vkiryukhin/pretty-data"

;; pd.xml(data ) ;; pretty print XML;
;; pd.json(data) ;; pretty print JSON;
;; pd.css(data ) ;; pretty print CSS;
;; pd.sql(data ) ;; pretty print SQL;
;; pd.xmlmin(data [, preserveComments]) ;; minify XML;
;; pd.jsonmin(data) ;; minify JSON text;
;; pd.cssmin(data [, preserveComments] ) ;; minify CSS text;
;; pd.sqlmin(data) ;; minify JSON text;

(defn run-docpad [kvs]
 "Run a docpad instance, optionally with your own configuration"
 (let [instance (. (require "docpad") createInstance kvs)]
  (. console log instance)))


;(def kleur (. (require "color")("#363636")))


(import path "path")



;(run-docpad {})

(. console log (try (raise exception)))
