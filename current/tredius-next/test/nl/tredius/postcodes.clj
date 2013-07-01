(ns nl.tredius.postcodes-test)

(defn willekeurige-postcode
  []
  (let [nums (apply str (repeatedly 4 #(inc (rand-int 9))))
        ltrs (apply str (repeatedly 2 (fn [] (rand-nth (map #(char %) (range 65 91))))))]
    (str nums " " ltrs)))
