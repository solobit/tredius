
(defn- vimeo
  "Geeft een hyperlink naar de vimeo bibliotheek retour indien een 'id' gegeven wordt,
  bij geen argumenten uitzondering genereren."
   ([] (try (raise exception) (catch error (.log console error))))
   ([id] (str "http://player.vimeo.com/video/" id "?api=1&amp;player_id=VideoSpeler-" id "&amp;title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;color=e31741")))
