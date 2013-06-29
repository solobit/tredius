(ns foo22
  (:use [clojure.contrib.seq-utils]))

(def a
  [
   {:provincie :noord-holland  :van 1000 :tot 1299}
   {:provincie :flevoland      :van 1300 :tot 1379}
   {:provincie :noord-holland  :van 1380 :tot 1383}
   {:provincie :utrecht        :van 1390 :tot 1393}
   {:provincie :noord-holland  :van 1394 :tot 1394}
   {:provincie :utrecht        :van 1396 :tot 1396}
   {:provincie :noord-holland  :van 1398 :tot 1425}
   {:provincie :utrecht        :van 1426 :tot 1427}
   {:provincie :zuid-holland   :van 1428 :tot 1429}
   {:provincie :noord-holland  :van 1430 :tot 2158}
   {:provincie :zuid-holland   :van 2159 :tot 3381}
   {:provincie :utrecht        :van 3382 :tot 3464}
   {:provincie :zuid-holland   :van 3465 :tot 3466}
   {:provincie :utrecht        :van 3467 :tot 3769}
   {:provincie :gelderland     :van 3770 :tot 3794}
   {:provincie :utrecht        :van 3795 :tot 3836}
   {:provincie :gelderland     :van 3837 :tot 3888}
   {:provincie :flevoland      :van 3890 :tot 3899}
   {:provincie :utrecht        :van 3900 :tot 3999}
   {:provincie :gelderland     :van 4000 :tot 4119}
   {:provincie :utrecht        :van 4120 :tot 4125}
   {:provincie :zuid-holland   :van 4126 :tot 4129}
   {:provincie :utrecht        :van 4130 :tot 4139}
   {:provincie :zuid-holland   :van 4140 :tot 4146}
   {:provincie :gelderland     :van 4147 :tot 4162}
   {:provincie :zuid-holland   :van 4163 :tot 4169}
   {:provincie :gelderland     :van 4170 :tot 4199}
   {:provincie :zuid-holland   :van 4200 :tot 4209}
   {:provincie :gelderland     :van 4211 :tot 4212}
   {:provincie :zuid-holland   :van 4213 :tot 4213}
   {:provincie :gelderland     :van 4214 :tot 4219}
   {:provincie :zuid-holland   :van 4220 :tot 4249}
   {:provincie :noord-brabant  :van 4250 :tot 4299}
   {:provincie :zeeland        :van 4300 :tot 4599}
   {:provincie :noord-brabant  :van 4600 :tot 4671}
   {:provincie :zeeland        :van 4672 :tot 4679}
   {:provincie :noord-brabant  :van 4680 :tot 4681}
   {:provincie :zeeland        :van 4682 :tot 4699}
   {:provincie :noord-brabant  :van 4700 :tot 5299}
   {:provincie :gelderland     :van 5300 :tot 5335}
   {:provincie :noord-brabant  :van 5340 :tot 5765}
   {:provincie :limburg        :van 5766 :tot 5817}
   {:provincie :noord-brabant  :van 5820 :tot 5846}
   {:provincie :limburg        :van 5850 :tot 6019}
   {:provincie :noord-brabant  :van 6020 :tot 6029}
   {:provincie :limburg        :van 6030 :tot 6499}
   {:provincie :gelderland     :van 6500 :tot 6584}
   {:provincie :limburg        :van 6584 :tot 6599}
   {:provincie :gelderland     :van 6600 :tot 7399}
   {:provincie :overijssel     :van 7400 :tot 7438}
   {:provincie :gelderland     :van 7439 :tot 7439}
   {:provincie :overijssel     :van 7440 :tot 7739}
   {:provincie :drenthe        :van 7740 :tot 7766}
   {:provincie :overijssel     :van 7767 :tot 7799}
   {:provincie :drenthe        :van 7800 :tot 7949}
   {:provincie :overijssel     :van 7950 :tot 7955}
   {:provincie :drenthe        :van 7956 :tot 7999}
   {:provincie :overijssel     :van 8000 :tot 8049}
   {:provincie :gelderland     :van 8050 :tot 8054}
   {:provincie :overijssel     :van 8055 :tot 8069}
   {:provincie :gelderland     :van 8070 :tot 8099}
   {:provincie :overijssel     :van 8100 :tot 8159}
   {:provincie :gelderland     :van 8160 :tot 8195}
   {:provincie :overijssel     :van 8196 :tot 8199}
   {:provincie :flevoland      :van 8200 :tot 8259}
   {:provincie :overijssel     :van 8260 :tot 8299}
   {:provincie :flevoland      :van 8300 :tot 8322}
   {:provincie :overijssel     :van 8323 :tot 8349}
   {:provincie :drenthe        :van 8350 :tot 8354}
   {:provincie :overijssel     :van 8355 :tot 8379}
   {:provincie :drenthe        :van 8380 :tot 8387}
   {:provincie :friesland      :van 8388 :tot 9299}
   {:provincie :drenthe        :van 9300 :tot 9349}
   {:provincie :groningen      :van 9350 :tot 9399}
   {:provincie :drenthe        :van 9400 :tot 9499}
   {:provincie :groningen      :van 9500 :tot 9999}])

(def b
  [
   [:noord-holland 1000 1299]
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

(find-first #(< 6555 %) (map second b))

(def lazy-van (map #(second %) b))

(map #(get-in b [% 2]) (range (count b)))

((partial first b))



(defn find-first2
         [f coll]
         (first (filter f coll)))
(find-first #(< 3333 %) (map #(second %) b))

(let [[provincie van tot] (b 6)]
  (str provincie))

(doall (filter #(> 2222 %) (map second b)))

 (find-first2 #(= % 1) [3 4 1])



(map #(name %) (map :provincie a))

(defn cfn [x]
  {:pre [(and (< x 10000) (> x 0))]}
  (find-first #(< x %) (map :tot a)))

(cfn 3456)


