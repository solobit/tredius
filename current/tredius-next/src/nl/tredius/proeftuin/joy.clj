(ns fah
  (:use [opennlp.nlp]
        [opennlp.treebank]
        [opennlp.tools.filters])
  (:require [clojure.string :as string]
            [dire.core :refer [with-handler! with-finally!
                               with-precondition!]]))


(def get-sentences (make-sentence-detector "/media/data/models/nl-sent.bin"))
(def tokenize (make-tokenizer "/media/data/models/nl-token.bin"))
(def detokenize (make-detokenizer "/media/data/models/nl-detokenizer.xml"))
(def pos-tag (make-pos-tagger "/media/data/models/nl-pos-maxent.bin"))
(def name-find (make-name-finder "/media/data/models/nl-ner-person.bin"))
;(def perceptron (make-treebank-chunker "/media/data/models/nl-chunker.bin"))

(defn- mindist
  "Give the minimum distance from the first arg to any value in the second arg."
  [n ns]
  (apply min (map #(Math/abs (- n %)) ns)))

(defn- score-word
  "Score the index-term based on it's distance from any intex-term in the given
  search list. Use the base score to boost matches from 1 up to another value."
  [iword iterms base]
  (let [dist (mindist (first iword) iterms)
        score (if (zero? dist)
                base
                (/ base (* 2 dist)))]
    (if (> dist 2) 0 score)))

(defn score-words
  "Score a list of words linearly based on how far they are from the
  term.  Base score is optional and is 1 by default.  Case sensitive."
  ([term words] (score-words term words 1))
  ([term words base]
     (let [iwords (map vector (iterate inc 0) words)
           iterms (map first (filter (fn [e] (= (second e) term)) iwords))]
       (if (= 0 (count iterms))
         (map #(vector % 0) words)
         (map #(vector (second %) (score-word % iterms base)) iwords)))))

(score-words "geld" ["Hoeveel" "geld" "heeft" "Jan" "geleend" "van" "Piet?"] 2)
(categorize (compact long-document))


(defn plus-een [n]
  (inc n))

(defn delen [a b]
  (/ a b))

(def onder-voorwaarde! with-precondition!)

(onder-voorwaarde! #'plus-een
  "Mag niet op 2 toegepast worden."
  :geen-twee
  (fn [n & args] (not= n 2)))

(def serie seq)
(def serie? seq?)
(def reeks range)
(def lijst list)
(lijst 1 2 3 4)
(serie [1 2 3 4 5])
(reeks 0 100)



(if (= (last (last (string/split "Kom terug!" #" "))) \!) true false)
(string/lower-case (string/replace "Komt terug?" #" " "-"))

(with-handler! #'plus-een
  {:precondition :geen-twee}
  (fn [e & args]
    (apply str "Fout! Randvoorwaarde niet voldaan: " [args])))

(with-handler! #'delen
  "Here's an optional docstring about the handler."
  java.lang.ArithmeticException
  (fn [e & args]
    (str "Fout! Kan " (first args) " niet door 0 delen.")))

(def a 1)
(def b a)

(with-meta 'with-handler! {:voorwaarde "foo"})




(delen 10 0)
(delen 20 10)
(plus-een 2)









(def baselist (list :barnabas :adam))
(def l1 (cons :willie baselist))
(def l2 (cons :mack baselist))

(def s1 [[:a 1 2][:b 2 4][:c 5 8][:d 10 12]])

(get s1 2)

(defn recursive-reverse [coll]
  (loop [coll coll
         acc  (empty coll)]
        (if (empty? coll)
            acc
            (recur (rest coll) (cons (first coll) acc)))))

(recursive-reverse [1 2 3 4 5 6 67])

;; (defn parse-int [s]
;;    (if (string? s)
;;      (if (= (count s) 4)
;;        (Integer. (re-find  #"\d{4}" s ))
;;        (if (= count s 6)))))

(def s2 (seq [[:noord-holland 1000 2000][:noord-brabant 2000 3000]]))

(defn postcode?
  [c]
  {:pre [(and (< c 9999)
              (> c 1))]}
  (cond
   (string? c) (Integer. (re-find  #"\d{4}" c))
   (number? c) (str c)))





(def b
  [[:noord-holland 1000 1299]
   [:flevoland     1300 1379]
   [:noord-holland 1380 1383]
   [:utrecht       1390 1393]
   [:noord-holland 1394 1394]
   [:utrecht       1396 1396]
   [:noord-holland 1398 1425]
   [:utrecht       1426 1427]
   [:zuid-holland  1428 1429]
   [:noord-holland 1430 2158]
   [:zuid-holland  2159 3381]
   [:utrecht       3382 3464]
   [:zuid-holland  3465 3466]
   [:utrecht       3467 3769]
   [:gelderland    3770 3794]
   [:utrecht       3795 3836]
   [:gelderland    3837 3888]
   [:flevoland     3890 3899]
   [:utrecht       3900 3999]
   [:gelderland    4000 4119]
   [:utrecht       4120 4125]
   [:zuid-holland  4126 4129]
   [:utrecht       4130 4139]
   [:zuid-holland  4140 4146]
   [:gelderland    4147 4162]
   [:zuid-holland  4163 4169]
   [:gelderland    4170 4199]
   [:zuid-holland  4200 4209]
   [:gelderland    4211 4212]
   [:zuid-holland  4213 4213]
   [:gelderland    4214 4219]
   [:zuid-holland  4220 4249]
   [:noord-brabant 4250 4299]
   [:zeeland       4300 4599]
   [:noord-brabant 4600 4671]
   [:zeeland       4672 4679]
   [:noord-brabant 4680 4681]
   [:zeeland       4682 4699]
   [:noord-brabant 4700 5299]
   [:gelderland    5300 5335]
   [:noord-brabant 5340 5765]
   [:limburg       5766 5817]
   [:noord-brabant 5820 5846]
   [:limburg       5850 6019]
   [:noord-brabant 6020 6029]
   [:limburg       6030 6499]
   [:gelderland    6500 6584]
   [:limburg       6584 6599]
   [:gelderland    6600 7399]
   [:overijssel    7400 7438]
   [:gelderland    7439 7439]
   [:overijssel    7440 7739]
   [:drenthe       7740 7766]
   [:overijssel    7767 7799]
   [:drenthe       7800 7949]
   [:overijssel    7950 7955]
   [:drenthe       7956 7999]
   [:overijssel    8000 8049]
   [:gelderland    8050 8054]
   [:overijssel    8055 8069]
   [:gelderland    8070 8099]
   [:overijssel    8100 8159]
   [:gelderland    8160 8195]
   [:overijssel    8196 8199]
   [:flevoland     8200 8259]
   [:overijssel    8260 8299]
   [:flevoland     8300 8322]
   [:overijssel    8323 8349]
   [:drenthe       8350 8354]
   [:overijssel    8355 8379]
   [:drenthe       8380 8387]
   [:friesland     8388 9299]
   [:drenthe       9300 9349]
   [:groningen     9350 9399]
   [:drenthe       9400 9499]
   [:groningen     9500 9999]])

(seq b)


