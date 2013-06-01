
 (ns tredius.templates.st
   (:use clojure.test))

 (def names ["Eugenia" "Matt" "Derek"])

(defn load-htmlmail []
  (let [tpl (get-view-from-dir "htmail/layout" "src/tredius/templates")])
  (. tpl setAttribute "title" "Test123")
  (println (. tpl toString)))



(def  "src/tredius/templates/htmail/devices.stg"))











 (def email (StringTemplate. "
    From Address $from_addr$
    To Address $to_addr$
    Dear $to$,
        Permit me to inform you of my desire of going into business relationship with you. I have
        the believe you are a reputable and responsible and trustworthy person I can do business
        with from the little information so far I gathered about you during my search for a partner
        and by matter of trust I must not hesitate to confide in you for this simple and sincere business
    . ...
    Best Regards, $from$
    "))

 (. email setAttribute "customer" "Frank")
 (println email)

;; Example 1: Some objects don't have a useful toString()
(def objectParamater (Object.))
(def template (StringTemplate. "Hello $param$ !"))
(. template setAttribute "param" objectParamater)

(println template)

 ;(fill-view!
  ;(get-view-from-dir
   ;"email/layout" "src/tredius/templates/html") "names" names)
