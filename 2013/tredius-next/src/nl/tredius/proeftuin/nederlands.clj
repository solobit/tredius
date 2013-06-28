(ns nl.tredius.proeftuin.nederlands)

(defmacro synoniem [s s′]
  (list 'defmacro s′ (str s) '[& rest]
     (list 'cons (list 'quote s) 'rest)))

(synoniem if indien)
(synoniem if-not indien-niet)
(synoniem some sommige)
(synoniem take neem)
(synoniem take-nth neem-de)

(def een 1)
(def eerste first)

(def twee 2)
(def drie 3)
(def vier 4)
(def vijf 5)
(def zes 6)
(def zeven 7)
(def acht 8)
(def negen 9)
(def tien 10)




(def waar true)
(def onwaar false)
(def aan true)
(def uit false)

(indien waar "dan is het goed"
        #_anders "je spreekt niet de waarheid")

(indien-niet waar "dan is het niet goed"
             #_anders "spreek je toch wel de waarheid")

(indien-niet onwaar "dan heb je niet gelogen" "anders wel")

(indien waar "dan wel")

(indien-niet waar "dan niet" 'nee)