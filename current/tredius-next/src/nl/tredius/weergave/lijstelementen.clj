
(defn keuzelijst-brandstoffen
  "Selecteer 1 van de 4 mogelijke brandstoffen als keuze element HTML select."
  [] (html
      [:select
       [:option {:value :benzine} "Benzine"]
       [:option {:value :diesel} "Diesel"]
       [:option {:value :lpg3} "LPG3/Aardgas"]
       [:option {:value :overig} "LPG/Overig"]]))

(defn keuzelijst-gewicht
  "Maakt een hiccup HTML select/option element door de hash-map van
  de belastingdienst te doorlopen."
  [provincie]
  (let [prov (naar-sleutelwoord provincie)]
    (html
     [:select
      (for [x (map #(val (first %)) (prov opcenten-tabel))]
        [:option {:value x} x])])))
