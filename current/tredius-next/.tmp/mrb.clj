(ns nl.tredius.modellen.basisgegevens
  (:require [clojure.string :as string]
            [dire.core :refer [with-precondition! with-handler!]]))


;; (time (lookup-postcode "1234 AC"))
;; (time (random-postcode))
;; (time (repeatedly 4 #(rand-int 999)))
;; "Elapsed time: 84.365881 msecs"
;(time (nth data (first (positions #{"5014 LT"} (map #(first %) data)))))

;; 	"Elapsed time: 49.790093 msecs"
;(time (nth data (.indexOf (map #(first %) data) "5014 LT")))


;; (re-matches #"[1-9]\d{3}" "1234")
;; (re-matches #"([1-9]\d{3})([aA-zZ]{2})" "1234aa")

;; (take 4 "1232ab")
;; (drop 4 "1232ab")


;; Reflection hack, access just the number-reading part of Clojure's Reader:
;; (let [m (.getDeclaredMethod clojure.lang.LispReader "matchNumber" (into-array [String]))]
;;   (.setAccessible m true)
;;   (defn parse-number [s]
;;     (.invoke m clojure.lang.LispReader (into-array [s]))))


;; convert, need check
(map #(Integer/parseInt %) (drop 1 (string/split "1234" #"")))

;; patterns
(re-matches #"[1-9]\d{3}" "1234")
(re-matches #"[1-9]\d{3}[aA-zZ]{2}" "1234aa")


(defn zoek-provincie
  "Zoekt aan de hand van 4 cijfers in welke provincie de postcode zich bevindt."
  [postcode]
  (let [s (for [a (:postcode-naar-provincie gegevens)]
            (when (and (>= postcode (a 1))
                       (< postcode (inc (a 2))))
              (a 0)))
        r (last (doall (remove nil? s)))]
    r))



(defn verwerk-postcode
  [pc]
  (take 4 pc))

(verwerk-postcode "123")


(parse-number "1234")


(nil? (re-matches #"[1-9]\d{3}" "1234"))

(time (zoek-provincie 9914))



 (condp (comp seq re-seq) "12343"
   #"[1-9]\d{3}"               :>> #(vector %)
   #"[1-9]\d{3}[aA-zZ]{2}"     :>> #(vector %)
   #"(\w+)=(\S+)" :>> #(let [x (first %)]
                         [(keyword (nth x 1)) (nth x 2)]))

  (condp (comp seq re-seq) "+foo"
         #"[+](\w+)"    :>> #(vector (-> % first (nth 1) keyword) true)
         #"[-](\w+)"    :>> #(vector (-> % first (nth 1) keyword) false)
         #"(\w+)=(\S+)" :>> #(let [x (first %)]
                               [(keyword (nth x 1)) (nth x 2)]))


;; (with-precondition! #'verwerk-postcode
;;   "Voorwaarde dat een postcode uit 4-cijfer of
;;   4-cijfer en 2-lettertekens bestaat."
;;   :vier-of-zes
;;   (fn [n & args]
;;     (or (= (count n) 2)))



(def gegevens
  {:laatste-update "1 juli 2013 (gegevens zijn ouder, veelal jaar ervoor)"
   ;; Indeling postcodes naar provincie. De logica van postcodes volgt lang
   ;; niet altijd de provinciegrenzen, maar loopt in een cirkel tegen de klok
   ;; in, beginnende bij Noord-Holland.
   ;; Gegevens als matrix, vector van vectoren weergegeven, velden als:
   ;; provincie van tm
   :postcode-naar-provincie
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
    [:groningen     9500 9999]]

   :mrb-noord-holland
   [{:gewicht 1    :benzine 26  :diesel 88   :lpg3 26   :overig 99}
    {:gewicht 551  :benzine 34  :diesel 108  :lpg3 34   :overig 122}
    {:gewicht 651  :benzine 42  :diesel 127  :lpg3 42   :overig 144}
    {:gewicht 751  :benzine 55  :diesel 152  :lpg3 55   :overig 172}
    {:gewicht 851  :benzine 72  :diesel 186  :lpg3 86   :overig 200}
    {:gewicht 951  :benzine 93  :diesel 219  :lpg3 121  :overig 235}
    {:gewicht 1051 :benzine 114 :diesel 253  :lpg3 157  :overig 270}
    {:gewicht 1151 :benzine 135 :diesel 286  :lpg3 192  :overig 304}
    {:gewicht 1251 :benzine 156 :diesel 320  :lpg3 227  :overig 339}
    {:gewicht 1351 :benzine 178 :diesel 353  :lpg3 263  :overig 374}
    {:gewicht 1451 :benzine 199 :diesel 387  :lpg3 298  :overig 409}
    {:gewicht 1551 :benzine 220 :diesel 420  :lpg3 333  :overig 443}
    {:gewicht 1651 :benzine 241 :diesel 454  :lpg3 369  :overig 478}
    {:gewicht 1751 :benzine 262 :diesel 488  :lpg3 404  :overig 513}
    {:gewicht 1851 :benzine 283 :diesel 521  :lpg3 440  :overig 548}
    {:gewicht 1951 :benzine 305 :diesel 555  :lpg3 475  :overig 582}
    {:gewicht 2051 :benzine 326 :diesel 588  :lpg3 510  :overig 617}
    {:gewicht 2151 :benzine 347 :diesel 622  :lpg3 546  :overig 652}
    {:gewicht 2251 :benzine 368 :diesel 655  :lpg3 581  :overig 687}
    {:gewicht 2351 :benzine 389 :diesel 689  :lpg3 616  :overig 721}
    {:gewicht 2451 :benzine 410 :diesel 722  :lpg3 652  :overig 756}
    {:gewicht 2551 :benzine 432 :diesel 756  :lpg3 687  :overig 791}
    {:gewicht 2651 :benzine 453 :diesel 789  :lpg3 722  :overig 826}
    {:gewicht 2751 :benzine 474 :diesel 823  :lpg3 758  :overig 860}
    {:gewicht 2851 :benzine 495 :diesel 856  :lpg3 793  :overig 895}
    {:gewicht 2951 :benzine 516 :diesel 890  :lpg3 828  :overig 930}
    {:gewicht 3051 :benzine 537 :diesel 923  :lpg3 864  :overig 965}
    {:gewicht 3151 :benzine 559 :diesel 957  :lpg3 899  :overig 999}
    {:gewicht 3251 :benzine 576 :diesel 987  :lpg3 931  :overig 1030}
    {:gewicht 3351 :benzine 593 :diesel 1016 :lpg3 962  :overig 1061}
    {:gewicht 3451 :benzine 610 :diesel 1046 :lpg3 993  :overig 1092}
    {:gewicht 3551 :benzine 627 :diesel 1075 :lpg3 1025 :overig 1123}
    {:gewicht 3651 :benzine 645 :diesel 1105 :lpg3 1056 :overig 1153}
    {:gewicht 3751 :benzine 662 :diesel 1134 :lpg3 1087 :overig 1184}
    {:gewicht 3851 :benzine 679 :diesel 1164 :lpg3 1119 :overig 1215}
    {:gewicht 3951 :benzine 696 :diesel 1193 :lpg3 1150 :overig 1245}
    {:gewicht 4051 :benzine 713 :diesel 1223 :lpg3 1181 :overig 1276}
    {:gewicht 4151 :benzine 730 :diesel 1252 :lpg3 1213 :overig 1307}
    {:gewicht 4251 :benzine 747 :diesel 1282 :lpg3 1244 :overig 1338}
    {:gewicht 4351 :benzine 764 :diesel 1311 :lpg3 1275 :overig 1368}
    {:gewicht 4451 :benzine 782 :diesel 1340 :lpg3 1307 :overig 1399}
    {:gewicht 4551 :benzine 799 :diesel 1370 :lpg3 1338 :overig 1430}
    {:gewicht 4651 :benzine 816 :diesel 1399 :lpg3 1369 :overig 1460}
    {:gewicht 4751 :benzine 833 :diesel 1429 :lpg3 1400 :overig 1491}
    {:gewicht 4851 :benzine 850 :diesel 1458 :lpg3 1432 :overig 1522}
    {:gewicht 4951 :benzine 867 :diesel 1488 :lpg3 1463 :overig 1553}]

   :mrb-utrecht
   [{:gewicht 1    :benzine 26  :diesel 89   :lpg3 26   :overig 100}
    {:gewicht 551  :benzine 34  :diesel 109  :lpg3 34   :overig 123}
    {:gewicht 651  :benzine 43  :diesel 128  :lpg3 43   :overig 145}
    {:gewicht 751  :benzine 56  :diesel 153  :lpg3 56   :overig 173}
    {:gewicht 851  :benzine 73  :diesel 187  :lpg3 88   :overig 202}
    {:gewicht 951  :benzine 95  :diesel 222  :lpg3 124  :overig 237}
    {:gewicht 1051 :benzine 117 :diesel 256  :lpg3 159  :overig 272}
    {:gewicht 1151 :benzine 139 :diesel 290  :lpg3 195  :overig 308}
    {:gewicht 1251 :benzine 160 :diesel 324  :lpg3 231  :overig 343}
    {:gewicht 1351 :benzine 182 :diesel 358  :lpg3 267  :overig 378}
    {:gewicht 1451 :benzine 204 :diesel 392  :lpg3 303  :overig 413}
    {:gewicht 1551 :benzine 225 :diesel 426  :lpg3 339  :overig 449}
    {:gewicht 1651 :benzine 247 :diesel 460  :lpg3 375  :overig 484}
    {:gewicht 1751 :benzine 269 :diesel 494  :lpg3 411  :overig 519}
    {:gewicht 1851 :benzine 291 :diesel 528  :lpg3 447  :overig 555}
    {:gewicht 1951 :benzine 312 :diesel 562  :lpg3 483  :overig 590}
    {:gewicht 2051 :benzine 334 :diesel 596  :lpg3 518  :overig 625}
    {:gewicht 2151 :benzine 356 :diesel 630  :lpg3 554  :overig 661}
    {:gewicht 2251 :benzine 377 :diesel 664  :lpg3 590  :overig 696}
    {:gewicht 2351 :benzine 399 :diesel 698  :lpg3 626  :overig 731}
    {:gewicht 2451 :benzine 421 :diesel 733  :lpg3 662  :overig 766}
    {:gewicht 2551 :benzine 443 :diesel 767  :lpg3 698  :overig 802}
    {:gewicht 2651 :benzine 464 :diesel 801  :lpg3 734  :overig 837}
    {:gewicht 2751 :benzine 486 :diesel 835  :lpg3 770  :overig 872}
    {:gewicht 2851 :benzine 508 :diesel 869  :lpg3 806  :overig 908}
    {:gewicht 2951 :benzine 529 :diesel 903  :lpg3 842  :overig 943}
    {:gewicht 3051 :benzine 551 :diesel 937  :lpg3 877  :overig 978}
    {:gewicht 3151 :benzine 573 :diesel 971  :lpg3 913  :overig 1014}
    {:gewicht 3251 :benzine 591 :diesel 1001 :lpg3 946  :overig 1045}
    {:gewicht 3351 :benzine 609 :diesel 1032 :lpg3 977  :overig 1076}
    {:gewicht 3451 :benzine 626 :diesel 1062 :lpg3 1009 :overig 1108}
    {:gewicht 3551 :benzine 644 :diesel 1092 :lpg3 1041 :overig 1139}
    {:gewicht 3651 :benzine 662 :diesel 1122 :lpg3 1073 :overig 1170}
    {:gewicht 3751 :benzine 679 :diesel 1152 :lpg3 1105 :overig 1202}
    {:gewicht 3851 :benzine 697 :diesel 1182 :lpg3 1137 :overig 1233}
    {:gewicht 3951 :benzine 715 :diesel 1212 :lpg3 1169 :overig 1264}
    {:gewicht 4051 :benzine 732 :diesel 1242 :lpg3 1200 :overig 1295}
    {:gewicht 4151 :benzine 750 :diesel 1272 :lpg3 1232 :overig 1327}
    {:gewicht 4251 :benzine 768 :diesel 1302 :lpg3 1264 :overig 1358}
    {:gewicht 4351 :benzine 785 :diesel 1332 :lpg3 1296 :overig 1389}
    {:gewicht 4451 :benzine 803 :diesel 1362 :lpg3 1328 :overig 1420}
    {:gewicht 4551 :benzine 821 :diesel 1392 :lpg3 1360 :overig 1452}
    {:gewicht 4651 :benzine 838 :diesel 1422 :lpg3 1392 :overig 1483}
    {:gewicht 4751 :benzine 856 :diesel 1452 :lpg3 1423 :overig 1514}
    {:gewicht 4851 :benzine 874 :diesel 1482 :lpg3 1455 :overig 1545}
    {:gewicht 4951 :benzine 891 :diesel 1512 :lpg3 1487 :overig 1577}]

   :mrb-noord-brabant
   [{:gewicht 1    :benzine 27  :diesel 89   :lpg3 27   :overig 100}
    {:gewicht 551  :benzine 35  :diesel 109  :lpg3 35   :overig 123}
    {:gewicht 651  :benzine 43  :diesel 129  :lpg3 43   :overig 146}
    {:gewicht 751  :benzine 56  :diesel 154  :lpg3 56   :overig 174}
    {:gewicht 851  :benzine 74  :diesel 188  :lpg3 88   :overig 202}
    {:gewicht 951  :benzine 96  :diesel 222  :lpg3 124  :overig 238}
    {:gewicht 1051 :benzine 118 :diesel 257  :lpg3 160  :overig 273}
    {:gewicht 1151 :benzine 140 :diesel 291  :lpg3 196  :overig 309}
    {:gewicht 1251 :benzine 162 :diesel 325  :lpg3 233  :overig 344}
    {:gewicht 1351 :benzine 183 :diesel 359  :lpg3 269  :overig 380}
    {:gewicht 1451 :benzine 205 :diesel 394  :lpg3 305  :overig 415}
    {:gewicht 1551 :benzine 227 :diesel 428  :lpg3 341  :overig 451}
    {:gewicht 1651 :benzine 249 :diesel 462  :lpg3 377  :overig 486}
    {:gewicht 1751 :benzine 271 :diesel 496  :lpg3 413  :overig 522}
    {:gewicht 1851 :benzine 293 :diesel 531  :lpg3 449  :overig 557}
    {:gewicht 1951 :benzine 315 :diesel 565  :lpg3 485  :overig 593}
    {:gewicht 2051 :benzine 337 :diesel 599  :lpg3 521  :overig 628}
    {:gewicht 2151 :benzine 359 :diesel 633  :lpg3 557  :overig 664}
    {:gewicht 2251 :benzine 381 :diesel 668  :lpg3 593  :overig 699}
    {:gewicht 2351 :benzine 402 :diesel 702  :lpg3 629  :overig 734}
    {:gewicht 2451 :benzine 424 :diesel 736  :lpg3 666  :overig 770}
    {:gewicht 2551 :benzine 446 :diesel 770  :lpg3 702  :overig 805}
    {:gewicht 2651 :benzine 468 :diesel 805  :lpg3 738  :overig 841}
    {:gewicht 2751 :benzine 490 :diesel 839  :lpg3 774  :overig 876}
    {:gewicht 2851 :benzine 512 :diesel 873  :lpg3 810  :overig 912}
    {:gewicht 2951 :benzine 534 :diesel 907  :lpg3 846  :overig 947}
    {:gewicht 3051 :benzine 556 :diesel 942  :lpg3 882  :overig 983}
    {:gewicht 3151 :benzine 578 :diesel 976  :lpg3 918  :overig 1018}
    {:gewicht 3251 :benzine 596 :diesel 1007 :lpg3 951  :overig 1050}
    {:gewicht 3351 :benzine 614 :diesel 1037 :lpg3 983  :overig 1082}
    {:gewicht 3451 :benzine 632 :diesel 1067 :lpg3 1015 :overig 1113}
    {:gewicht 3551 :benzine 649 :diesel 1097 :lpg3 1047 :overig 1145}
    {:gewicht 3651 :benzine 667 :diesel 1127 :lpg3 1079 :overig 1176}
    {:gewicht 3751 :benzine 685 :diesel 1158 :lpg3 1111 :overig 1207}
    {:gewicht 3851 :benzine 703 :diesel 1188 :lpg3 1143 :overig 1239}
    {:gewicht 3951 :benzine 721 :diesel 1218 :lpg3 1175 :overig 1270}
    {:gewicht 4051 :benzine 739 :diesel 1248 :lpg3 1207 :overig 1302}
    {:gewicht 4151 :benzine 757 :diesel 1278 :lpg3 1239 :overig 1333}
    {:gewicht 4251 :benzine 774 :diesel 1309 :lpg3 1271 :overig 1365}
    {:gewicht 4351 :benzine 792 :diesel 1339 :lpg3 1303 :overig 1396}
    {:gewicht 4451 :benzine 810 :diesel 1369 :lpg3 1335 :overig 1428}
    {:gewicht 4551 :benzine 828 :diesel 1399 :lpg3 1367 :overig 1459}
    {:gewicht 4651 :benzine 846 :diesel 1430 :lpg3 1399 :overig 1490}
    {:gewicht 4751 :benzine 864 :diesel 1460 :lpg3 1431 :overig 1522}
    {:gewicht 4851 :benzine 882 :diesel 1490 :lpg3 1463 :overig 1553}
    {:gewicht 4951 :benzine 899 :diesel 1520 :lpg3 1495 :overig 1585}]

   :mrb-flevoland
   [{:gewicht 1    :benzine 27  :diesel 90   :lpg3 27   :overig 101}
    {:gewicht 551  :benzine 35  :diesel 109  :lpg3 35   :overig 123}
    {:gewicht 651  :benzine 43  :diesel 129  :lpg3 43   :overig 146}
    {:gewicht 751  :benzine 57  :diesel 155  :lpg3 57   :overig 175}
    {:gewicht 851  :benzine 75  :diesel 189  :lpg3 89   :overig 203}
    {:gewicht 951  :benzine 97  :diesel 223  :lpg3 125  :overig 239}
    {:gewicht 1051 :benzine 119 :diesel 258  :lpg3 162  :overig 275}
    {:gewicht 1151 :benzine 141 :diesel 292  :lpg3 198  :overig 310}
    {:gewicht 1251 :benzine 164 :diesel 327  :lpg3 234  :overig 346}
    {:gewicht 1351 :benzine 186 :diesel 362  :lpg3 271  :overig 382}
    {:gewicht 1451 :benzine 208 :diesel 396  :lpg3 307  :overig 418}
    {:gewicht 1551 :benzine 230 :diesel 431  :lpg3 344  :overig 453}
    {:gewicht 1651 :benzine 252 :diesel 465  :lpg3 380  :overig 489}
    {:gewicht 1751 :benzine 274 :diesel 500  :lpg3 416  :overig 525}
    {:gewicht 1851 :benzine 297 :diesel 534  :lpg3 453  :overig 561}
    {:gewicht 1951 :benzine 319 :diesel 569  :lpg3 489  :overig 596}
    {:gewicht 2051 :benzine 341 :diesel 603  :lpg3 525  :overig 632}
    {:gewicht 2151 :benzine 363 :diesel 638  :lpg3 562  :overig 668}
    {:gewicht 2251 :benzine 385 :diesel 672  :lpg3 598  :overig 704}
    {:gewicht 2351 :benzine 407 :diesel 707  :lpg3 635  :overig 740}
    {:gewicht 2451 :benzine 430 :diesel 741  :lpg3 671  :overig 775}
    {:gewicht 2551 :benzine 452 :diesel 776  :lpg3 707  :overig 811}
    {:gewicht 2651 :benzine 474 :diesel 810  :lpg3 744  :overig 847}
    {:gewicht 2751 :benzine 496 :diesel 845  :lpg3 780  :overig 883}
    {:gewicht 2851 :benzine 518 :diesel 880  :lpg3 816  :overig 918}
    {:gewicht 2951 :benzine 541 :diesel 914  :lpg3 853  :overig 954}
    {:gewicht 3051 :benzine 563 :diesel 949  :lpg3 889  :overig 990}
    {:gewicht 3151 :benzine 585 :diesel 983  :lpg3 925  :overig 1026}
    {:gewicht 3251 :benzine 603 :diesel 1014 :lpg3 958  :overig 1058}
    {:gewicht 3351 :benzine 622 :diesel 1045 :lpg3 991  :overig 1090}
    {:gewicht 3451 :benzine 640 :diesel 1075 :lpg3 1023 :overig 1121}
    {:gewicht 3551 :benzine 658 :diesel 1106 :lpg3 1055 :overig 1153}
    {:gewicht 3651 :benzine 676 :diesel 1136 :lpg3 1087 :overig 1185}
    {:gewicht 3751 :benzine 694 :diesel 1167 :lpg3 1120 :overig 1216}
    {:gewicht 3851 :benzine 712 :diesel 1197 :lpg3 1152 :overig 1248}
    {:gewicht 3951 :benzine 730 :diesel 1228 :lpg3 1184 :overig 1280}
    {:gewicht 4051 :benzine 749 :diesel 1258 :lpg3 1217 :overig 1312}
    {:gewicht 4151 :benzine 767 :diesel 1289 :lpg3 1249 :overig 1343}
    {:gewicht 4251 :benzine 785 :diesel 1319 :lpg3 1281 :overig 1375}
    {:gewicht 4351 :benzine 803 :diesel 1350 :lpg3 1314 :overig 1407}
    {:gewicht 4451 :benzine 821 :diesel 1380 :lpg3 1346 :overig 1439}
    {:gewicht 4551 :benzine 839 :diesel 1411 :lpg3 1378 :overig 1470}
    {:gewicht 4651 :benzine 857 :diesel 1441 :lpg3 1411 :overig 1502}
    {:gewicht 4751 :benzine 875 :diesel 1472 :lpg3 1443 :overig 1534}
    {:gewicht 4851 :benzine 894 :diesel 1502 :lpg3 1475 :overig 1565}
    {:gewicht 4951 :benzine 912 :diesel 1533 :lpg3 1508 :overig 1597}]

   :mrb-zeeland
   [{:gewicht 1    :benzine 27  :diesel 90   :lpg3 27   :overig 101}
    {:gewicht 551  :benzine 35  :diesel 110  :lpg3 35   :overig 124}
    {:gewicht 651  :benzine 44  :diesel 129  :lpg3 44   :overig 147}
    {:gewicht 751  :benzine 58  :diesel 155  :lpg3 58   :overig 175}
    {:gewicht 851  :benzine 75  :diesel 189  :lpg3 90   :overig 204}
    {:gewicht 951  :benzine 98  :diesel 224  :lpg3 126  :overig 240}
    {:gewicht 1051 :benzine 120 :diesel 259  :lpg3 163  :overig 276}
    {:gewicht 1151 :benzine 143 :diesel 294  :lpg3 199  :overig 311}
    {:gewicht 1251 :benzine 165 :diesel 328  :lpg3 236  :overig 347}
    {:gewicht 1351 :benzine 187 :diesel 363  :lpg3 272  :overig 383}
    {:gewicht 1451 :benzine 210 :diesel 398  :lpg3 309  :overig 419}
    {:gewicht 1551 :benzine 232 :diesel 433  :lpg3 346  :overig 455}
    {:gewicht 1651 :benzine 254 :diesel 467  :lpg3 382  :overig 491}
    {:gewicht 1751 :benzine 277 :diesel 502  :lpg3 419  :overig 527}
    {:gewicht 1851 :benzine 299 :diesel 537  :lpg3 455  :overig 563}
    {:gewicht 1951 :benzine 322 :diesel 571  :lpg3 492  :overig 599}
    {:gewicht 2051 :benzine 344 :diesel 606  :lpg3 528  :overig 635}
    {:gewicht 2151 :benzine 366 :diesel 641  :lpg3 565  :overig 671}
    {:gewicht 2251 :benzine 389 :diesel 676  :lpg3 602  :overig 707}
    {:gewicht 2351 :benzine 411 :diesel 710  :lpg3 638  :overig 743}
    {:gewicht 2451 :benzine 433 :diesel 745  :lpg3 675  :overig 779}
    {:gewicht 2551 :benzine 456 :diesel 780  :lpg3 711  :overig 815}
    {:gewicht 2651 :benzine 478 :diesel 815  :lpg3 748  :overig 851}
    {:gewicht 2751 :benzine 501 :diesel 849  :lpg3 784  :overig 887}
    {:gewicht 2851 :benzine 523 :diesel 884  :lpg3 821  :overig 923}
    {:gewicht 2951 :benzine 545 :diesel 919  :lpg3 857  :overig 959}
    {:gewicht 3051 :benzine 568 :diesel 954  :lpg3 894  :overig 995}
    {:gewicht 3151 :benzine 590 :diesel 988  :lpg3 931  :overig 1031}
    {:gewicht 3251 :benzine 609 :diesel 1019 :lpg3 964  :overig 1063}
    {:gewicht 3351 :benzine 627 :diesel 1050 :lpg3 996  :overig 1095}
    {:gewicht 3451 :benzine 645 :diesel 1081 :lpg3 1029 :overig 1127}
    {:gewicht 3551 :benzine 664 :diesel 1111 :lpg3 1061 :overig 1159}
    {:gewicht 3651 :benzine 682 :diesel 1142 :lpg3 1094 :overig 1191}
    {:gewicht 3751 :benzine 700 :diesel 1173 :lpg3 1126 :overig 1223}
    {:gewicht 3851 :benzine 719 :diesel 1204 :lpg3 1159 :overig 1255}
    {:gewicht 3951 :benzine 737 :diesel 1234 :lpg3 1191 :overig 1287}
    {:gewicht 4051 :benzine 755 :diesel 1265 :lpg3 1224 :overig 1319}
    {:gewicht 4151 :benzine 774 :diesel 1296 :lpg3 1256 :overig 1350}
    {:gewicht 4251 :benzine 792 :diesel 1326 :lpg3 1289 :overig 1382}
    {:gewicht 4351 :benzine 810 :diesel 1357 :lpg3 1321 :overig 1414}
    {:gewicht 4451 :benzine 829 :diesel 1388 :lpg3 1354 :overig 1446}
    {:gewicht 4551 :benzine 847 :diesel 1418 :lpg3 1386 :overig 1478}
    {:gewicht 4651 :benzine 865 :diesel 1449 :lpg3 1419 :overig 1510}
    {:gewicht 4751 :benzine 884 :diesel 1480 :lpg3 1451 :overig 1542}
    {:gewicht 4851 :benzine 902 :diesel 1511 :lpg3 1484 :overig 1574}
    {:gewicht 4951 :benzine 920 :diesel 1541 :lpg3 1516 :overig 1606}]

   :mrb-limburg
   [{:gewicht 1    :benzine 28  :diesel 90   :lpg3 28   :overig 101}
    {:gewicht 551  :benzine 36  :diesel 110  :lpg3 36   :overig 124}
    {:gewicht 651  :benzine 44  :diesel 130  :lpg3 44   :overig 147}
    {:gewicht 751  :benzine 58  :diesel 155  :lpg3 58   :overig 175}
    {:gewicht 851  :benzine 76  :diesel 190  :lpg3 90   :overig 204}
    {:gewicht 951  :benzine 98  :diesel 225  :lpg3 127  :overig 240}
    {:gewicht 1051 :benzine 121 :diesel 260  :lpg3 164  :overig 276}
    {:gewicht 1151 :benzine 143 :diesel 295  :lpg3 200  :overig 312}
    {:gewicht 1251 :benzine 166 :diesel 329  :lpg3 237  :overig 349}
    {:gewicht 1351 :benzine 189 :diesel 364  :lpg3 274  :overig 385}
    {:gewicht 1451 :benzine 211 :diesel 399  :lpg3 310  :overig 421}
    {:gewicht 1551 :benzine 234 :diesel 434  :lpg3 347  :overig 457}
    {:gewicht 1651 :benzine 256 :diesel 469  :lpg3 384  :overig 493}
    {:gewicht 1751 :benzine 279 :diesel 504  :lpg3 421  :overig 529}
    {:gewicht 1851 :benzine 301 :diesel 539  :lpg3 457  :overig 565}
    {:gewicht 1951 :benzine 324 :diesel 574  :lpg3 494  :overig 601}
    {:gewicht 2051 :benzine 346 :diesel 609  :lpg3 531  :overig 638}
    {:gewicht 2151 :benzine 369 :diesel 644  :lpg3 568  :overig 674}
    {:gewicht 2251 :benzine 391 :diesel 678  :lpg3 604  :overig 710}
    {:gewicht 2351 :benzine 414 :diesel 713  :lpg3 641  :overig 746}
    {:gewicht 2451 :benzine 436 :diesel 748  :lpg3 678  :overig 782}
    {:gewicht 2551 :benzine 459 :diesel 783  :lpg3 714  :overig 818}
    {:gewicht 2651 :benzine 482 :diesel 818  :lpg3 751  :overig 854}
    {:gewicht 2751 :benzine 504 :diesel 853  :lpg3 788  :overig 891}
    {:gewicht 2851 :benzine 527 :diesel 888  :lpg3 825  :overig 927}
    {:gewicht 2951 :benzine 549 :diesel 923  :lpg3 861  :overig 963}
    {:gewicht 3051 :benzine 572 :diesel 958  :lpg3 898  :overig 999}
    {:gewicht 3151 :benzine 594 :diesel 993  :lpg3 935  :overig 1035}
    {:gewicht 3251 :benzine 613 :diesel 1024 :lpg3 968  :overig 1068}
    {:gewicht 3351 :benzine 632 :diesel 1055 :lpg3 1001 :overig 1100}
    {:gewicht 3451 :benzine 650 :diesel 1086 :lpg3 1033 :overig 1132}
    {:gewicht 3551 :benzine 669 :diesel 1116 :lpg3 1066 :overig 1164}
    {:gewicht 3651 :benzine 687 :diesel 1147 :lpg3 1099 :overig 1196}
    {:gewicht 3751 :benzine 706 :diesel 1178 :lpg3 1131 :overig 1228}
    {:gewicht 3851 :benzine 724 :diesel 1209 :lpg3 1164 :overig 1260}
    {:gewicht 3951 :benzine 743 :diesel 1240 :lpg3 1197 :overig 1292}
    {:gewicht 4051 :benzine 761 :diesel 1271 :lpg3 1229 :overig 1324}
    {:gewicht 4151 :benzine 780 :diesel 1302 :lpg3 1262 :overig 1356}
    {:gewicht 4251 :benzine 798 :diesel 1332 :lpg3 1295 :overig 1388}
    {:gewicht 4351 :benzine 817 :diesel 1363 :lpg3 1328 :overig 1421}
    {:gewicht 4451 :benzine 835 :diesel 1394 :lpg3 1360 :overig 1453}
    {:gewicht 4551 :benzine 854 :diesel 1425 :lpg3 1393 :overig 1485}
    {:gewicht 4651 :benzine 872 :diesel 1456 :lpg3 1426 :overig 1517}
    {:gewicht 4751 :benzine 891 :diesel 1487 :lpg3 1458 :overig 1549}
    {:gewicht 4851 :benzine 909 :diesel 1518 :lpg3 1491 :overig 1581}
    {:gewicht 4951 :benzine 928 :diesel 1548 :lpg3 1524 :overig 1613}]

   :mrb-overijssel
   [{:gewicht 1    :benzine 28  :diesel 90   :lpg3 28   :overig 101}
    {:gewicht 551  :benzine 36  :diesel 110  :lpg3 36   :overig 124}
    {:gewicht 651  :benzine 44  :diesel 130  :lpg3 44   :overig 147}
    {:gewicht 751  :benzine 58  :diesel 155  :lpg3 58   :overig 175}
    {:gewicht 851  :benzine 76  :diesel 190  :lpg3 90   :overig 204}
    {:gewicht 951  :benzine 99  :diesel 225  :lpg3 127  :overig 240}
    {:gewicht 1051 :benzine 121 :diesel 260  :lpg3 164  :overig 276}
    {:gewicht 1151 :benzine 144 :diesel 295  :lpg3 200  :overig 313}
    {:gewicht 1251 :benzine 166 :diesel 330  :lpg3 237  :overig 349}
    {:gewicht 1351 :benzine 189 :diesel 365  :lpg3 274  :overig 385}
    {:gewicht 1451 :benzine 211 :diesel 399  :lpg3 311  :overig 421}
    {:gewicht 1551 :benzine 234 :diesel 434  :lpg3 347  :overig 457}
    {:gewicht 1651 :benzine 256 :diesel 469  :lpg3 384  :overig 493}
    {:gewicht 1751 :benzine 279 :diesel 504  :lpg3 421  :overig 530}
    {:gewicht 1851 :benzine 302 :diesel 539  :lpg3 458  :overig 566}
    {:gewicht 1951 :benzine 324 :diesel 574  :lpg3 494  :overig 602}
    {:gewicht 2051 :benzine 347 :diesel 609  :lpg3 531  :overig 638}
    {:gewicht 2151 :benzine 369 :diesel 644  :lpg3 568  :overig 674}
    {:gewicht 2251 :benzine 392 :diesel 679  :lpg3 605  :overig 710}
    {:gewicht 2351 :benzine 414 :diesel 714  :lpg3 641  :overig 746}
    {:gewicht 2451 :benzine 437 :diesel 749  :lpg3 678  :overig 783}
    {:gewicht 2551 :benzine 460 :diesel 784  :lpg3 715  :overig 819}
    {:gewicht 2651 :benzine 482 :diesel 819  :lpg3 752  :overig 855}
    {:gewicht 2751 :benzine 505 :diesel 853  :lpg3 788  :overig 891}
    {:gewicht 2851 :benzine 527 :diesel 888  :lpg3 825  :overig 927}
    {:gewicht 2951 :benzine 550 :diesel 923  :lpg3 862  :overig 963}
    {:gewicht 3051 :benzine 572 :diesel 958  :lpg3 899  :overig 999}
    {:gewicht 3151 :benzine 595 :diesel 993  :lpg3 935  :overig 1036}
    {:gewicht 3251 :benzine 614 :diesel 1024 :lpg3 969  :overig 1068}
    {:gewicht 3351 :benzine 632 :diesel 1055 :lpg3 1001 :overig 1100}
    {:gewicht 3451 :benzine 651 :diesel 1086 :lpg3 1034 :overig 1132}
    {:gewicht 3551 :benzine 669 :diesel 1117 :lpg3 1067 :overig 1164}
    {:gewicht 3651 :benzine 688 :diesel 1148 :lpg3 1099 :overig 1197}
    {:gewicht 3751 :benzine 706 :diesel 1179 :lpg3 1132 :overig 1229}
    {:gewicht 3851 :benzine 725 :diesel 1210 :lpg3 1165 :overig 1261}
    {:gewicht 3951 :benzine 743 :diesel 1241 :lpg3 1198 :overig 1293}
    {:gewicht 4051 :benzine 762 :diesel 1271 :lpg3 1230 :overig 1325}
    {:gewicht 4151 :benzine 781 :diesel 1302 :lpg3 1263 :overig 1357}
    {:gewicht 4251 :benzine 799 :diesel 1333 :lpg3 1296 :overig 1389}
    {:gewicht 4351 :benzine 818 :diesel 1364 :lpg3 1328 :overig 1421}
    {:gewicht 4451 :benzine 836 :diesel 1395 :lpg3 1361 :overig 1454}
    {:gewicht 4551 :benzine 855 :diesel 1426 :lpg3 1394 :overig 1486}
    {:gewicht 4651 :benzine 873 :diesel 1457 :lpg3 1427 :overig 1518}
    {:gewicht 4751 :benzine 892 :diesel 1488 :lpg3 1459 :overig 1550}
    {:gewicht 4851 :benzine 910 :diesel 1519 :lpg3 1492 :overig 1582}
    {:gewicht 4951 :benzine 929 :diesel 1549 :lpg3 1525 :overig 1614}]

   :mrb-gelderland
   [{:gewicht 1    :benzine 28  :diesel 91   :lpg3 28   :overig 102}
    {:gewicht 551  :benzine 37  :diesel 111  :lpg3 37   :overig 125}
    {:gewicht 651  :benzine 45  :diesel 131  :lpg3 45   :overig 148}
    {:gewicht 751  :benzine 59  :diesel 157  :lpg3 59   :overig 177}
    {:gewicht 851  :benzine 78  :diesel 192  :lpg3 92   :overig 206}
    {:gewicht 951  :benzine 101 :diesel 227  :lpg3 129  :overig 243}
    {:gewicht 1051 :benzine 124 :diesel 263  :lpg3 167  :overig 279}
    {:gewicht 1151 :benzine 147 :diesel 298  :lpg3 204  :overig 316}
    {:gewicht 1251 :benzine 170 :diesel 334  :lpg3 241  :overig 353}
    {:gewicht 1351 :benzine 193 :diesel 369  :lpg3 279  :overig 390}
    {:gewicht 1451 :benzine 217 :diesel 405  :lpg3 316  :overig 426}
    {:gewicht 1551 :benzine 240 :diesel 440  :lpg3 353  :overig 463}
    {:gewicht 1651 :benzine 263 :diesel 476  :lpg3 391  :overig 500}
    {:gewicht 1751 :benzine 286 :diesel 511  :lpg3 428  :overig 537}
    {:gewicht 1851 :benzine 309 :diesel 547  :lpg3 465  :overig 573}
    {:gewicht 1951 :benzine 332 :diesel 582  :lpg3 503  :overig 610}
    {:gewicht 2051 :benzine 356 :diesel 618  :lpg3 540  :overig 647}
    {:gewicht 2151 :benzine 379 :diesel 653  :lpg3 577  :overig 684}
    {:gewicht 2251 :benzine 402 :diesel 689  :lpg3 615  :overig 720}
    {:gewicht 2351 :benzine 425 :diesel 724  :lpg3 652  :overig 757}
    {:gewicht 2451 :benzine 448 :diesel 760  :lpg3 689  :overig 794}
    {:gewicht 2551 :benzine 471 :diesel 795  :lpg3 727  :overig 831}
    {:gewicht 2651 :benzine 495 :diesel 831  :lpg3 764  :overig 867}
    {:gewicht 2751 :benzine 518 :diesel 867  :lpg3 801  :overig 904}
    {:gewicht 2851 :benzine 541 :diesel 902  :lpg3 839  :overig 941}
    {:gewicht 2951 :benzine 564 :diesel 938  :lpg3 876  :overig 978}
    {:gewicht 3051 :benzine 587 :diesel 973  :lpg3 914  :overig 1014}
    {:gewicht 3151 :benzine 610 :diesel 1009 :lpg3 951  :overig 1051}
    {:gewicht 3251 :benzine 630 :diesel 1040 :lpg3 985  :overig 1084}
    {:gewicht 3351 :benzine 649 :diesel 1072 :lpg3 1018 :overig 1117}
    {:gewicht 3451 :benzine 668 :diesel 1103 :lpg3 1051 :overig 1150}
    {:gewicht 3551 :benzine 687 :diesel 1135 :lpg3 1085 :overig 1182}
    {:gewicht 3651 :benzine 706 :diesel 1166 :lpg3 1118 :overig 1215}
    {:gewicht 3751 :benzine 725 :diesel 1198 :lpg3 1151 :overig 1248}
    {:gewicht 3851 :benzine 745 :diesel 1229 :lpg3 1184 :overig 1280}
    {:gewicht 3951 :benzine 764 :diesel 1261 :lpg3 1218 :overig 1313}
    {:gewicht 4051 :benzine 783 :diesel 1292 :lpg3 1251 :overig 1346}
    {:gewicht 4151 :benzine 802 :diesel 1324 :lpg3 1284 :overig 1379}
    {:gewicht 4251 :benzine 821 :diesel 1355 :lpg3 1318 :overig 1411}
    {:gewicht 4351 :benzine 840 :diesel 1387 :lpg3 1351 :overig 1444}
    {:gewicht 4451 :benzine 859 :diesel 1418 :lpg3 1384 :overig 1477}
    {:gewicht 4551 :benzine 878 :diesel 1450 :lpg3 1418 :overig 1509}
    {:gewicht 4651 :benzine 897 :diesel 1481 :lpg3 1451 :overig 1542}
    {:gewicht 4751 :benzine 917 :diesel 1513 :lpg3 1484 :overig 1575}
    {:gewicht 4851 :benzine 936 :diesel 1544 :lpg3 1518 :overig 1608}
    {:gewicht 4951 :benzine 955 :diesel 1576 :lpg3 1551 :overig 1640}]

   :mrb-groningen
   [{:gewicht 1    :benzine 28  :diesel 91   :lpg3 28   :overig 102}
    {:gewicht 551  :benzine 37  :diesel 111  :lpg3 37   :overig 125}
    {:gewicht 651  :benzine 45  :diesel 131  :lpg3 45   :overig 148}
    {:gewicht 751  :benzine 59  :diesel 157  :lpg3 59   :overig 177}
    {:gewicht 851  :benzine 78  :diesel 192  :lpg3 92   :overig 206}
    {:gewicht 951  :benzine 101 :diesel 227  :lpg3 129  :overig 243}
    {:gewicht 1051 :benzine 124 :diesel 263  :lpg3 167  :overig 279}
    {:gewicht 1151 :benzine 147 :diesel 298  :lpg3 204  :overig 316}
    {:gewicht 1251 :benzine 170 :diesel 334  :lpg3 241  :overig 353}
    {:gewicht 1351 :benzine 194 :diesel 369  :lpg3 279  :overig 390}
    {:gewicht 1451 :benzine 217 :diesel 405  :lpg3 316  :overig 426}
    {:gewicht 1551 :benzine 240 :diesel 440  :lpg3 353  :overig 463}
    {:gewicht 1651 :benzine 263 :diesel 476  :lpg3 391  :overig 500}
    {:gewicht 1751 :benzine 286 :diesel 511  :lpg3 428  :overig 537}
    {:gewicht 1851 :benzine 309 :diesel 547  :lpg3 466  :overig 574}
    {:gewicht 1951 :benzine 333 :diesel 583  :lpg3 503  :overig 610}
    {:gewicht 2051 :benzine 356 :diesel 618  :lpg3 540  :overig 647}
    {:gewicht 2151 :benzine 379 :diesel 654  :lpg3 578  :overig 684}
    {:gewicht 2251 :benzine 402 :diesel 689  :lpg3 615  :overig 721}
    {:gewicht 2351 :benzine 425 :diesel 725  :lpg3 652  :overig 757}
    {:gewicht 2451 :benzine 448 :diesel 760  :lpg3 690  :overig 794}
    {:gewicht 2551 :benzine 472 :diesel 796  :lpg3 727  :overig 831}
    {:gewicht 2651 :benzine 495 :diesel 831  :lpg3 764  :overig 868}
    {:gewicht 2751 :benzine 518 :diesel 867  :lpg3 802  :overig 904}
    {:gewicht 2851 :benzine 541 :diesel 902  :lpg3 839  :overig 941}
    {:gewicht 2951 :benzine 564 :diesel 938  :lpg3 876  :overig 978}
    {:gewicht 3051 :benzine 587 :diesel 973  :lpg3 914  :overig 1015}
    {:gewicht 3151 :benzine 611 :diesel 1009 :lpg3 951  :overig 1051}
    {:gewicht 3251 :benzine 630 :diesel 1041 :lpg3 985  :overig 1085}
    {:gewicht 3351 :benzine 649 :diesel 1072 :lpg3 1018 :overig 1117}
    {:gewicht 3451 :benzine 668 :diesel 1104 :lpg3 1052 :overig 1150}
    {:gewicht 3551 :benzine 688 :diesel 1135 :lpg3 1085 :overig 1183}
    {:gewicht 3651 :benzine 707 :diesel 1167 :lpg3 1118 :overig 1215}
    {:gewicht 3751 :benzine 726 :diesel 1198 :lpg3 1152 :overig 1248}
    {:gewicht 3851 :benzine 745 :diesel 1230 :lpg3 1185 :overig 1281}
    {:gewicht 3951 :benzine 764 :diesel 1261 :lpg3 1218 :overig 1314}
    {:gewicht 4051 :benzine 783 :diesel 1293 :lpg3 1251 :overig 1346}
    {:gewicht 4151 :benzine 802 :diesel 1324 :lpg3 1285 :overig 1379}
    {:gewicht 4251 :benzine 821 :diesel 1356 :lpg3 1318 :overig 1412}
    {:gewicht 4351 :benzine 841 :diesel 1387 :lpg3 1351 :overig 1444}
    {:gewicht 4451 :benzine 860 :diesel 1419 :lpg3 1385 :overig 1477}
    {:gewicht 4551 :benzine 879 :diesel 1450 :lpg3 1418 :overig 1510}
    {:gewicht 4651 :benzine 898 :diesel 1482 :lpg3 1451 :overig 1543}
    {:gewicht 4751 :benzine 917 :diesel 1513 :lpg3 1485 :overig 1575}
    {:gewicht 4851 :benzine 936 :diesel 1545 :lpg3 1518 :overig 1608}
    {:gewicht 4951 :benzine 955 :diesel 1576 :lpg3 1551 :overig 1641}]

   :mrb-drenthe
   [{:gewicht 1    :benzine 28  :diesel 91   :lpg3 28   :overig 102}
    {:gewicht 551  :benzine 37  :diesel 111  :lpg3 37   :overig 125}
    {:gewicht 651  :benzine 45  :diesel 131  :lpg3 45   :overig 148}
    {:gewicht 751  :benzine 60  :diesel 157  :lpg3 60   :overig 177}
    {:gewicht 851  :benzine 78  :diesel 192  :lpg3 92   :overig 206}
    {:gewicht 951  :benzine 102 :diesel 228  :lpg3 130  :overig 243}
    {:gewicht 1051 :benzine 125 :diesel 264  :lpg3 167  :overig 280}
    {:gewicht 1151 :benzine 148 :diesel 299  :lpg3 205  :overig 317}
    {:gewicht 1251 :benzine 172 :diesel 335  :lpg3 242  :overig 354}
    {:gewicht 1351 :benzine 195 :diesel 371  :lpg3 280  :overig 391}
    {:gewicht 1451 :benzine 218 :diesel 406  :lpg3 318  :overig 428}
    {:gewicht 1551 :benzine 242 :diesel 442  :lpg3 355  :overig 465}
    {:gewicht 1651 :benzine 265 :diesel 478  :lpg3 393  :overig 502}
    {:gewicht 1751 :benzine 288 :diesel 513  :lpg3 430  :overig 539}
    {:gewicht 1851 :benzine 312 :diesel 549  :lpg3 468  :overig 576}
    {:gewicht 1951 :benzine 335 :diesel 585  :lpg3 505  :overig 613}
    {:gewicht 2051 :benzine 358 :diesel 621  :lpg3 543  :overig 649}
    {:gewicht 2151 :benzine 382 :diesel 656  :lpg3 580  :overig 686}
    {:gewicht 2251 :benzine 405 :diesel 692  :lpg3 618  :overig 723}
    {:gewicht 2351 :benzine 428 :diesel 728  :lpg3 655  :overig 760}
    {:gewicht 2451 :benzine 452 :diesel 763  :lpg3 693  :overig 797}
    {:gewicht 2551 :benzine 475 :diesel 799  :lpg3 730  :overig 834}
    {:gewicht 2651 :benzine 498 :diesel 835  :lpg3 768  :overig 871}
    {:gewicht 2751 :benzine 522 :diesel 870  :lpg3 805  :overig 908}
    {:gewicht 2851 :benzine 545 :diesel 906  :lpg3 843  :overig 945}
    {:gewicht 2951 :benzine 568 :diesel 942  :lpg3 880  :overig 982}
    {:gewicht 3051 :benzine 592 :diesel 977  :lpg3 918  :overig 1019}
    {:gewicht 3151 :benzine 615 :diesel 1013 :lpg3 955  :overig 1056}
    {:gewicht 3251 :benzine 635 :diesel 1045 :lpg3 989  :overig 1089}
    {:gewicht 3351 :benzine 654 :diesel 1077 :lpg3 1023 :overig 1122}
    {:gewicht 3451 :benzine 673 :diesel 1109 :lpg3 1056 :overig 1155}
    {:gewicht 3551 :benzine 692 :diesel 1140 :lpg3 1090 :overig 1188}
    {:gewicht 3651 :benzine 712 :diesel 1172 :lpg3 1123 :overig 1220}
    {:gewicht 3751 :benzine 731 :diesel 1203 :lpg3 1157 :overig 1253}
    {:gewicht 3851 :benzine 750 :diesel 1235 :lpg3 1190 :overig 1286}
    {:gewicht 3951 :benzine 770 :diesel 1267 :lpg3 1224 :overig 1319}
    {:gewicht 4051 :benzine 789 :diesel 1298 :lpg3 1257 :overig 1352}
    {:gewicht 4151 :benzine 808 :diesel 1330 :lpg3 1291 :overig 1385}
    {:gewicht 4251 :benzine 827 :diesel 1362 :lpg3 1324 :overig 1418}
    {:gewicht 4351 :benzine 847 :diesel 1393 :lpg3 1358 :overig 1451}
    {:gewicht 4451 :benzine 866 :diesel 1425 :lpg3 1391 :overig 1484}
    {:gewicht 4551 :benzine 885 :diesel 1457 :lpg3 1425 :overig 1516}
    {:gewicht 4651 :benzine 905 :diesel 1488 :lpg3 1458 :overig 1549}
    {:gewicht 4751 :benzine 924 :diesel 1520 :lpg3 1492 :overig 1582}
    {:gewicht 4851 :benzine 943 :diesel 1552 :lpg3 1525 :overig 1615}
    {:gewicht 4951 :benzine 963 :diesel 1583 :lpg3 1559 :overig 1648}]

   :mrb-friesland
   [{:gewicht 1    :benzine 29  :diesel 91   :lpg3 29   :overig 102}
    {:gewicht 551  :benzine 37  :diesel 111  :lpg3 37   :overig 125}
    {:gewicht 651  :benzine 45  :diesel 131  :lpg3 45   :overig 148}
    {:gewicht 751  :benzine 60  :diesel 157  :lpg3 60   :overig 177}
    {:gewicht 851  :benzine 78  :diesel 192  :lpg3 92   :overig 206}
    {:gewicht 951  :benzine 102 :diesel 228  :lpg3 130  :overig 243}
    {:gewicht 1051 :benzine 125 :diesel 264  :lpg3 167  :overig 280}
    {:gewicht 1151 :benzine 148 :diesel 299  :lpg3 205  :overig 317}
    {:gewicht 1251 :benzine 172 :diesel 335  :lpg3 243  :overig 354}
    {:gewicht 1351 :benzine 195 :diesel 371  :lpg3 280  :overig 391}
    {:gewicht 1451 :benzine 218 :diesel 406  :lpg3 318  :overig 428}
    {:gewicht 1551 :benzine 242 :diesel 442  :lpg3 355  :overig 465}
    {:gewicht 1651 :benzine 265 :diesel 478  :lpg3 393  :overig 502}
    {:gewicht 1751 :benzine 288 :diesel 514  :lpg3 430  :overig 539}
    {:gewicht 1851 :benzine 312 :diesel 549  :lpg3 468  :overig 576}
    {:gewicht 1951 :benzine 335 :diesel 585  :lpg3 505  :overig 613}
    {:gewicht 2051 :benzine 358 :diesel 621  :lpg3 543  :overig 650}
    {:gewicht 2151 :benzine 382 :diesel 656  :lpg3 580  :overig 687}
    {:gewicht 2251 :benzine 405 :diesel 692  :lpg3 618  :overig 724}
    {:gewicht 2351 :benzine 428 :diesel 728  :lpg3 655  :overig 760}
    {:gewicht 2451 :benzine 452 :diesel 764  :lpg3 693  :overig 797}
    {:gewicht 2551 :benzine 475 :diesel 799  :lpg3 731  :overig 834}
    {:gewicht 2651 :benzine 498 :diesel 835  :lpg3 768  :overig 871}
    {:gewicht 2751 :benzine 522 :diesel 871  :lpg3 806  :overig 908}
    {:gewicht 2851 :benzine 545 :diesel 906  :lpg3 843  :overig 945}
    {:gewicht 2951 :benzine 568 :diesel 942  :lpg3 881  :overig 982}
    {:gewicht 3051 :benzine 592 :diesel 978  :lpg3 918  :overig 1019}
    {:gewicht 3151 :benzine 615 :diesel 1013 :lpg3 956  :overig 1056}
    {:gewicht 3251 :benzine 635 :diesel 1046 :lpg3 990  :overig 1089}
    {:gewicht 3351 :benzine 654 :diesel 1077 :lpg3 1023 :overig 1122}
    {:gewicht 3451 :benzine 673 :diesel 1109 :lpg3 1057 :overig 1155}
    {:gewicht 3551 :benzine 693 :diesel 1141 :lpg3 1090 :overig 1188}
    {:gewicht 3651 :benzine 712 :diesel 1172 :lpg3 1124 :overig 1221}
    {:gewicht 3751 :benzine 731 :diesel 1204 :lpg3 1157 :overig 1254}
    {:gewicht 3851 :benzine 751 :diesel 1235 :lpg3 1191 :overig 1287}
    {:gewicht 3951 :benzine 770 :diesel 1267 :lpg3 1224 :overig 1319}
    {:gewicht 4051 :benzine 789 :diesel 1299 :lpg3 1258 :overig 1352}
    {:gewicht 4151 :benzine 809 :diesel 1330 :lpg3 1291 :overig 1385}
    {:gewicht 4251 :benzine 828 :diesel 1362 :lpg3 1325 :overig 1418}
    {:gewicht 4351 :benzine 847 :diesel 1394 :lpg3 1358 :overig 1451}
    {:gewicht 4451 :benzine 867 :diesel 1425 :lpg3 1392 :overig 1484}
    {:gewicht 4551 :benzine 886 :diesel 1457 :lpg3 1425 :overig 1517}
    {:gewicht 4651 :benzine 905 :diesel 1489 :lpg3 1459 :overig 1550}
    {:gewicht 4751 :benzine 924 :diesel 1520 :lpg3 1492 :overig 1583}
    {:gewicht 4851 :benzine 944 :diesel 1552 :lpg3 1526 :overig 1616}
    {:gewicht 4951 :benzine 963 :diesel 1584 :lpg3 1559 :overig 1648}]

   :mrb-zuid-holland
   [{:gewicht 1    :benzine 30   :diesel 92   :lpg3 30   :overig 103}
    {:gewicht 551  :benzine 38   :diesel 112  :lpg3 38   :overig 126}
    {:gewicht 651  :benzine 47   :diesel 133  :lpg3 47   :overig 150}
    {:gewicht 751  :benzine 62   :diesel 160  :lpg3 62   :overig 179}
    {:gewicht 851  :benzine 81   :diesel 195  :lpg3 95   :overig 209}
    {:gewicht 951  :benzine 105  :diesel 232  :lpg3 134  :overig 247}
    {:gewicht 1051 :benzine 130  :diesel 268  :lpg3 172  :overig 285}
    {:gewicht 1151 :benzine 154  :diesel 305  :lpg3 211  :overig 323}
    {:gewicht 1251 :benzine 178  :diesel 342  :lpg3 249  :overig 361}
    {:gewicht 1351 :benzine 203  :diesel 379  :lpg3 288  :overig 399}
    {:gewicht 1451 :benzine 227  :diesel 415  :lpg3 326  :overig 437}
    {:gewicht 1551 :benzine 251  :diesel 452  :lpg3 365  :overig 475}
    {:gewicht 1651 :benzine 276  :diesel 489  :lpg3 403  :overig 513}
    {:gewicht 1751 :benzine 300  :diesel 525  :lpg3 442  :overig 551}
    {:gewicht 1851 :benzine 324  :diesel 562  :lpg3 480  :overig 588}
    {:gewicht 1951 :benzine 349  :diesel 599  :lpg3 519  :overig 626}
    {:gewicht 2051 :benzine 373  :diesel 635  :lpg3 557  :overig 664}
    {:gewicht 2151 :benzine 397  :diesel 672  :lpg3 596  :overig 702}
    {:gewicht 2251 :benzine 422  :diesel 709  :lpg3 635  :overig 740}
    {:gewicht 2351 :benzine 446  :diesel 745  :lpg3 673  :overig 778}
    {:gewicht 2451 :benzine 470  :diesel 782  :lpg3 712  :overig 816}
    {:gewicht 2551 :benzine 495  :diesel 819  :lpg3 750  :overig 854}
    {:gewicht 2651 :benzine 519  :diesel 855  :lpg3 789  :overig 892}
    {:gewicht 2751 :benzine 543  :diesel 892  :lpg3 827  :overig 930}
    {:gewicht 2851 :benzine 568  :diesel 929  :lpg3 866  :overig 968}
    {:gewicht 2951 :benzine 592  :diesel 966  :lpg3 904  :overig 1006}
    {:gewicht 3051 :benzine 616  :diesel 1002 :lpg3 943  :overig 1043}
    {:gewicht 3151 :benzine 641  :diesel 1039 :lpg3 981  :overig 1081}
    {:gewicht 3251 :benzine 661  :diesel 1072 :lpg3 1016 :overig 1116}
    {:gewicht 3351 :benzine 682  :diesel 1105 :lpg3 1051 :overig 1150}
    {:gewicht 3451 :benzine 702  :diesel 1137 :lpg3 1085 :overig 1183}
    {:gewicht 3551 :benzine 722  :diesel 1170 :lpg3 1119 :overig 1217}
    {:gewicht 3651 :benzine 742  :diesel 1203 :lpg3 1154 :overig 1251}
    {:gewicht 3751 :benzine 763  :diesel 1235 :lpg3 1188 :overig 1285}
    {:gewicht 3851 :benzine 783  :diesel 1268 :lpg3 1223 :overig 1319}
    {:gewicht 3951 :benzine 803  :diesel 1300 :lpg3 1257 :overig 1353}
    {:gewicht 4051 :benzine 824  :diesel 1333 :lpg3 1292 :overig 1387}
    {:gewicht 4151 :benzine 844  :diesel 1366 :lpg3 1326 :overig 1421}
    {:gewicht 4251 :benzine 864  :diesel 1398 :lpg3 1361 :overig 1454}
    {:gewicht 4351 :benzine 884  :diesel 1431 :lpg3 1395 :overig 1488}
    {:gewicht 4451 :benzine 905  :diesel 1464 :lpg3 1430 :overig 1522}
    {:gewicht 4551 :benzine 925  :diesel 1496 :lpg3 1464 :overig 1556}
    {:gewicht 4651 :benzine 945  :diesel 1529 :lpg3 1499 :overig 1590}
    {:gewicht 4751 :benzine 966  :diesel 1562 :lpg3 1533 :overig 1624}
    {:gewicht 4851 :benzine 986  :diesel 1594 :lpg3 1568 :overig 1658}
    {:gewicht 4951 :benzine 1006 :diesel 1627 :lpg3 1602 :overig 1692}]})



;; (defn zoek-belasting
;;   [postcode gewicht brandstof]
;;   (if-let [provincie (zoek-provincie postcode)]
;;     (if-let [opcenten (provincie data2)]
;;       (for [x opcenten]
;;         (when (< (:gewicht x) gewicht)
;;           (doall x))))))

;(zoek-belasting 5014 4333 :lpg3)
