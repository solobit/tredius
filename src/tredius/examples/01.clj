(ns samples)

(['a 'b 'c] 1)

({:a 1 :b 2 :c 3} :b)

(defn roll
  "Roll 2 dice, has special cases of multipliers when doubles or 1,2 is rolled."
  []
  (sort
   (take 2 (repeatedly
            #(inc (rand-int 6))))))

(defn check-modifiers
  [dice]
  (case dice
    ((1 2)) '(1 1 2 2 5 5 6 6)
    ((1 1)) '(1 1 6 6)
    ((2 2)) '(2 2 5 5)
    ((3 3)) '(3 3 4 4)
    ((4 4)) '(4 4 3 3)
    ((5 5)) '(2 2 5 5)
    ((6 6)) '(6 6 1 1)
    dice))

(check-modifiers (roll))


(check-modifiers (roll))


(def my-vec ['.])
(-> my-vec
          (assoc-in [1 :a] "baz2")
          (assoc-in [1 :b] "spam2"))

(def stack1 (atom 15))



