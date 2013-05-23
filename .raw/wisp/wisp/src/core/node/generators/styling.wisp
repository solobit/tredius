








(def color (require "colors"))

 (defmacro mkcolors
   [name & params]
    `(def ~name color ~@params))
; ;instance: (defineer-kleur paars "#123456")

(mkcolors purple "#363636")
(. console log purple)

;; (def kleur (require "color"))
;; ;; Set or get the values for individual channels with alpha, red, green, blue, hue, saturation (hsl), saturationv (hsv), lightness, cyan, magenta, yellow, black
;; ;; Get a hash of the rgb values with rgb(), similarly for hsl(), hsv(), and cmyk()

;; ;; Different CSS String formats for the color are on hexString, rgbString,
;; ;; percentString, hslString, and keyword (undefined if it's not a keyword color). "rgba" and "hsla" are used if the current alpha value of the color isn't 1.
;; ;; color.luminosity();  // 0.412
;; ;; (. console log (. (kleur "#363636") luminosity))

;; (defn- generate-styles [options]
;;   "Stylus is a next-gen style pre-processor language that combines JavaScript
;;   with CSS in a comfortable DSL."
;;   (let [stylus    (require "stylus")]
;;    (cond (not or (string? options)
;;              (


;;     (. stylus render stijlblad opties
;;        (fn [exception css]
;;          (try
;;           (raise exception)
;;           (catch error (recover error))
;;           (finally (.error console css)))
;;           ;; TODO uitvoeren naar bestand
;;          ))))

;; (defn- lijst-componenten [] ())

;; ;;opties    {:filename gegevens.stijl.uitvoer
;; ;;:paths    [mappen (. path join mappen "i18n")]} ]

;; (defn reduce
;;   [f & params]
;;   (let [has-initial (>= (count params) 2)
;;         initial (if has-initial (first params))
;;         sequence (if has-initial (second params) (first params))]
;;     (cond (nil? sequence) initial
;;           (vector? sequence) (if has-initial
;;                               (.reduce sequence f initial)
;;                               (.reduce sequence f))
;;           (list? sequence) (if has-initial
;;                             (reduce-list f initial sequence)
;;                             (reduce-list f (first sequence) (rest sequence)))
;;           :else (reduce f initial (seq sequence)))))

;; (defmacro defineer-kleur
;;   [name & obj]
;;   (let [kleur (require "colors")]
;;   `(def ~name (kleur ~@obj))))
;; ;instance: (defineer-kleur paars "#123456")
;; ;function: .rgbArray|hslArray|hsvArray|cmykArray|hexString|rgbaString|percentString|hslString|hslaString|keyword
;; ; luminosity|contrast|light|negate|lighten|darken|saturate|desaturate|greyscale|clearer|opaquer|rotate|mix
;; ;property: .-rgb|hsl|hsv|cmyk|alpha|red|green|blue|hue|saturation|value|cyan|magenta|yellow|black|

