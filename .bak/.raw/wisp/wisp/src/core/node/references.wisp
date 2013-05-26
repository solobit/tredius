(defn- site [bestand]
  "Vaak zullen we een referentie tot de sitemap op moeten geven."
  (str (. path join "" "" bestand)))

(defn- afb [bestand]
  "Geef de locatie (map) van afbeeldingen per server, domein, onderdeel of map."
   (str (. path join "" bestand)))
