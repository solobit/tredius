(ns clochard)

(def board (atom (vec (repeat 24 nil))))

(defn mod-board [x] (swap! board 1))

(reverse (mod-board 2))

(mod-board 2)


(defn owned-by [x]
  (if (neg? x) :p2 :p1))


(next '(:alpha :bravo :charlie))

(map #(mod-board %) '(1 1 2 2 5 5 6 6))