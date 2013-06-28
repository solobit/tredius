
;;
;; Import modules
;;

(import [sqrt factorial average square abs square] "./math")
(import [upper-case lower-case capitalize split join] "./string")
(import [list] "./sequence")
(import [str =] "./runtime")
(import [nil? vector? fn? number? string? dictionary?
         key-values str dec inc merge] "./runtime")

(defn println [msg] (.log console msg))

(println (= [""] (split "" #"\s")))
(println (= ["hello"] (split "hello" #"world")))
(println (= ["q" "w" "e" "r" "t" "y" "u" "i" "o" "p"]
           (split "q1w2e3r4t5y6u7i8o9p" #"\d+")))

(println (join "-" [1 2 3 4]))
(println (join "-" "hollo"))
(println (upper-case "hello"))
(println (split "q1w2e3r4t5y6u7i8o9p0" #"\d+" 5))





;;(.log console (upper-case (nil? nil)))

(.log console "\n\nAll tests passed!")