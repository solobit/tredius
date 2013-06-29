
; http://stackoverflow.com/a/5117172

; Since ECMA-/Javascript is all about Objects and Contexts (which, are also
; somekind of Object), every variable is stored in a such called Variable- (or
; in case of a Function, Activation Object).

; var a = 1,
;     b = 2,
;     c = 3;

; In the Global scope (= NO function context), you implicitly write those
; variables into the Global object (= window in a browser).

; So if you create variables like this

; Met rekenen, aritmetica, cijferkunst, rekenkunde worden een aantal
; bewerkingen, ook wel operaties genoemd, aangeduid die op getallen worden
; uitgevoerd. Deze bewerkingen zijn: optellen - aftrekken - vermenigvuldigen -
; delen - machtsverheffen - worteltrekken. Rekenen is een proces waarin een
; realiteit (of een abstractie daarvan) wordt geordend of herordend met behulp
; van op inzicht berustende denkhandelingen, welke ordening in principe is te
; kwantificeren en die toelaat om er (logische) operaties op uit te voeren dan
; wel uit af te leiden.

(defn optellen
  [x & rest]
  "De som van alle argumenten terug geven."
  (rest.reduce (fn [sum x] (+ sum x)) x))

(.log console (optellen 1 2 3 4 5 6 7 8))

(defn aftrekken
  [x & rest]
  "De rest van x aftrekken tot niets meer over is."
  (rest.reduce (fn [sum x] (- sum x)) x))

(.log console (aftrekken 200 1 2 3 4 5 6 7 8))

(defn schrijf [x] (.log console x))

(schrijf [1 2 3])

; Code is made up of lists representing expressions. The first item in the
; expression is a function, being invoked with rest items as arguments.

(schrijf (optellen 1 2 3 4))
;(def pwnage [me & the-rest] (require ))


(def natural (require "natural"))
;(schrijf natural)
;; BINGO! Alleen wel engels :(

; Een object maken
(def outer {})
(schrijf (typeof outer))

(schrijf outer) ; => {}

(def Mr {:hallo :alweer :een :beer})


(schrijf 

(schrijf Mr)
(defn zeg [bericht] (.log console bericht))
(set! bar)
(zeg { "foo" bar :beep-bop "bop" 1 2 })
;(zeg this)
; (defn module? []
;     ^{:doc      "Voorspelling dat het wel of geen module is."
;       :auteur:  "R. Jentzema"}
;       (isa module require.main))

;(.zeg James require.main)
(typeof zeg)
;(zeg "hallo")

(.log console (<= 5 2 3))

(.log console (typeof "hello"))



