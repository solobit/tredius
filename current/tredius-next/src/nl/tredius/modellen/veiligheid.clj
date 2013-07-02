(ns nl.tredius.modellen.veiligheid)

;; Iedere gebruikersinvoer met gevaarlijke characters (in formulieren, sqlinjections etc)
;; Iedere verdachte URI HTTP Get, Post, Update
;; --> Log IP
;; ---> monitor every step closely
;; ----> alarm