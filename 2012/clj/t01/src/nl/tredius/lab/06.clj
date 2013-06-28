;;
;; 06 SVG Map drawing using Incanter and Processing
;; Thanks @ http://nakkaya.com/2010/03/09/visualizing-maps-using-incanter/
;;

(ns nl.tredius.lab.06
  (:use [incanter core processing]))

;; Data for 2009
(def pop-taken
  [{:id 1 :name "Marmara" :population 582771}
   {:id 2 :name "Iç Anadolu" :population 297919}
   {:id 3 :name "Ege" :population 164896}
   {:id 4 :name "Akdeniz" :population 188441}
   {:id 5 :name "Karadeniz" :population 256654}
   {:id 6 :name "Güneydoğu Anadolu" :population 171910}
   {:id 7 :name "Doğu Anadolu" :population 214082}])

(def pop-given
  [{:id 1 :name "Marmara" :population 677395}
   {:id 2 :name "Iç Anadolu" :population 310293}
   {:id 3 :name "Ege" :population 181459}
   {:id 4 :name "Akdeniz" :population 193231}
   {:id 5 :name "Karadeniz" :population 247397}
   {:id 6 :name "Güneydoğu Anadolu" :population 118611}
   {:id 7 :name "Doğu Anadolu" :population 148287}])

;; Turkey is divided in to seven geographical regions, pop-taken represents
;; how many people moved in to that particular region and pop-given represents
;; how many people moved out of that region during 2009.

(defn region-color
  [val min max]
  (lerp-color (color 0xffd120)
              (color 0x920903)
              (norm val min max)))

;; In order to paint the map like a heat map, we need to assign colors using
;; the amount of people moved in or out of a region, given a min, max and a
;; value in between norm will normalize a value to exist between 0 and 1,
;; lerp-color on the other hand will calculate a color between the given range
;; using the normalized value. So our map will go from yellow to dark red
;; depending on the people moved.

(defn map-region-color
  [regions]
  (let [min (apply min (map #(:population %) regions))
        max (apply max (map #(:population %) regions))]
    (map #(vector (:id %) (region-color (:population %) min max)) regions)))

;; Now all we need to do is calculate min and max values in the data set,
;; iterate over the data set and return a sequence of [id color] pairs.

(defn sktch [regions]
  (sketch
   (setup [])
   (draw
    []
    (let [tr-map (load-shape this "MapTurkishProvincesNumbers.svg")]
      (.shape this tr-map 0 0)
      (doseq [region (map-region-color regions)]
        (let [[id color] region
              child (.getChild tr-map (str id))]
          (.disableStyle child)
          (.fill this color)
          (.noStroke this)
          (.shape this child 0 0)
          no-loop))))))
