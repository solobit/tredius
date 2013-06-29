(ns nl.tredius.modellen.basisgegevens.postcodes)



(def postcodes-per-provincie
 [{:van 1000 :tot 1299 :provincie "Noord-Holland"}
  {:van 1300 :tot 1379 :provincie "Flevoland"}
  {:van 1380 :tot 1383 :provincie "Noord-Holland"}
  {:van 1390 :tot 1393 :provincie "Utrecht"}
  {:van 1394           :provincie "Noord-Holland"}
  {:van 1396           :provincie "Utrecht"}
  {:van 1398 :tot 1425 :provincie "Noord-Holland"}
  {:van 1426 :tot 1427 :provincie "Utrecht"}
  {:van 1428 :tot 1429 :provincie "Zuid-Holland"}
  {:van 1430 :tot 2158 :provincie "Noord-Holland"}
  {:van 2159 :tot 3381 :provincie "Zuid-Holland"}
  {:van 3382 :tot 3464 :provincie "Utrecht"}
  {:van 3465 :tot 3466 :provincie "Zuid-Holland"}
  {:van 3467 :tot 3769 :provincie "Utrecht"}
  {:van 3770 :tot 3794 :provincie "Gelderland"}
  {:van 3795 :tot 3836 :provincie "Utrecht"}
  {:van 3837 :tot 3888 :provincie "Gelderland"}
  {:van 3890 :tot 3899 :provincie "Flevoland"}
  {:van 3900 :tot 3999 :provincie "Utrecht"}
  {:van 4000 :tot 4119 :provincie "Gelderland"}
  {:van 4120 :tot 4125 :provincie "Utrecht"}
  {:van 4126 :tot 4129 :provincie "Zuid-Holland"}
  {:van 4130 :tot 4139 :provincie "Utrecht"}
  {:van 4140 :tot 4146 :provincie "Zuid-Holland"}
  {:van 4147 :tot 4162 :provincie "Gelderland"}
  {:van 4163 :tot 4169 :provincie "Zuid-Holland"}
  {:van 4170 :tot 4199 :provincie "Gelderland"}
  {:van 4200 :tot 4209 :provincie "Zuid-Holland"}
  {:van 4211 :tot 4212 :provincie "Gelderland"}
  {:van 4213 :tot 4213 :provincie "Zuid-Holland"}
  {:van 4214 :tot 4219 :provincie "Gelderland"}
  {:van 4220 :tot 4249 :provincie "Zuid-Holland"}
  {:van 4250 :tot 4299 :provincie "Noord-Brabant"}
  {:van 4300 :tot 4599 :provincie "Zeeland"}
  {:van 4600 :tot 4671 :provincie "Noord-Brabant"}
  {:van 4672 :tot 4679 :provincie "Zeeland"}
  {:van 4680 :tot 4681 :provincie "Noord-Brabant"}
  {:van 4682 :tot 4699 :provincie "Zeeland"}
  {:van 4700 :tot 5299 :provincie "Noord-Brabant"}
  {:van 5300 :tot 5335 :provincie "Gelderland"}
  {:van 5340 :tot 5765 :provincie "Noord-Brabant"}
  {:van 5766 :tot 5817 :provincie "Limburg"}
  {:van 5820 :tot 5846 :provincie "Noord-Brabant"}
  {:van 5850 :tot 6019 :provincie "Limburg"}
  {:van 6020 :tot 6029 :provincie "Noord-Brabant"}
  {:van 6030 :tot 6499 :provincie "Limburg"}
  {:van 6500 :tot 6584 :provincie "Gelderland"}
  {:van 6584 :tot 6599 :provincie "Limburg"}
  {:van 6600 :tot 7399 :provincie "Gelderland"}
  {:van 7400 :tot 7438 :provincie "Overijssel"}
  {:van 7439           :provincie "Gelderland"}
  {:van 7440 :tot 7739 :provincie "Overijssel"}
  {:van 7740 :tot 7766 :provincie "Drenthe"}
  {:van 7767 :tot 7799 :provincie "Overijssel"}
  {:van 7800 :tot 7949 :provincie "Drenthe"}
  {:van 7950 :tot 7955 :provincie "Overijssel"}
  {:van 7956 :tot 7999 :provincie "Drenthe"}
  {:van 8000 :tot 8049 :provincie "Overijssel"}
  {:van 8050 :tot 8054 :provincie "Gelderland"}
  {:van 8055 :tot 8069 :provincie "Overijssel"}
  {:van 8070 :tot 8099 :provincie "Gelderland"}
  {:van 8100 :tot 8159 :provincie "Overijssel"}
  {:van 8160 :tot 8195 :provincie "Gelderland"}
  {:van 8196 :tot 8199 :provincie "Overijssel"}
  {:van 8200 :tot 8259 :provincie "Flevoland"}
  {:van 8260 :tot 8299 :provincie "Overijssel"}
  {:van 8300 :tot 8322 :provincie "Flevoland"}
  {:van 8323 :tot 8349 :provincie "Overijssel"}
  {:van 8350 :tot 8354 :provincie "Drenthe"}
  {:van 8355 :tot 8379 :provincie "Overijssel"}
  {:van 8380 :tot 8387 :provincie "Drenthe"}
  {:van 8388 :tot 9299 :provincie "Friesland"}
  {:van 9300 :tot 9349 :provincie "Drenthe"}
  {:van 9350 :tot 9399 :provincie "Groningen"}
  {:van 9400 :tot 9499 :provincie "Drenthe"}
  {:van 9500 :tot 9999 :provincie "Groningen"}])

(sorted-map-by < 5000 (map :van postcodes-per-provincie))

(apply merge-with concat (for [m postcodes-per-provincie [k v] m] {k [v]}))

(let [results postcodes-per-provincie]
  (into (sorted-map-by (fn [key1 key2]
                         (compare [(get results key2) key2]
                                  [(get results key1) key1])))
        results))


(compare "abcdd" "abcd")

(defn cfn [x]
  {:pre [(and (< x 10000) (> x 0))]})

(cfn 0)


(defn char-range
  "Returns a lazy seq of chars from start to end
  (inclusive), by step, where start defaults to Character/MIN_VALUE,
  step to 1, and end to Character/MAX_VALUE."
  ([] (char-range (Character/MIN_VALUE) (Character/MAX_VALUE) 1))
  ([end] (char-range (Character/MIN_VALUE) end 1))
  ([start end] (char-range start end 1))
  ([start end step]
     (map char (range (int start) (inc (int end)) step))))

(concat (char-range \a \z) (char-range \A \Z))




(:van (postcodes-per-provincie 5))
(:tot (postcodes-per-provincie 5))

(defn xy [z] (doall (map #(< z %) (pmap :van postcodes-per-provincie))))

(.indexOf (mapv :van postcodes-per-provincie) (second (mapv :van postcodes-per-provincie)))

(defn match
  [pc]
  (let [v (map :van postcodes-per-provincie)]
    v))

(defn zoeken [v]
  (loop [i 0
         n (count v)
         result []]
    (if (<= i (/ n i))
      (if (zero? (rem n i))
        (recur i (/ n i) (conj result i))
        (recur (inc i) n result))
      (if (> n 1)
        (conj result n)
        result))))

(defn geldig?
  [x]
  (let [v (doall (map :tot postcodes-per-provincie))]
    (< x (first (reverse (sort v))))
    ))

(geldig? 2)