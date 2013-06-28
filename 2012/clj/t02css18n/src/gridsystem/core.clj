(ns gridsystem.core
  "Demonstration using Garden to recreate the Semantic Grid framework.

   SEE: https://github.com/noprompt/garden
   SEE: http://semantic.gs/
   SEE: https://github.com/twigkit/semantic.gs/blob/master/stylesheets/scss/grid.scss"
  (:use [compojure.core]
        [ring.adapter.jetty])
  (:refer-clojure :exclude [+ - * /])
  (:require [taoensso.tower :as tower
             :refer (with-locale with-scope t style)]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [garden.units :as gu :refer [px em]]
            [garden.color :as gc :refer [hsl]]
            [garden.arithemetic :refer [+ - * /]]
            [garden.def :refer [defrule]]
            [garden.core :refer [css]]
            [hiccup.page :refer [html5]]))

;(tower/set-config! [:dictionary :nl :basis ] {:missing-page "Pagina niet gevonden!"})

;(println (css {:output-style :expanded} three-columns))
;;  `(map (fn [x] (~form [:h2 (str x)])) (range 0 12))
;(def foo `(max ~@(shuffle (range 10))))
;foo
;(html5 (map #(vec :h2 (str %)) (range 1 13)))



(def ^{:doc "The famous \"micro\" clearfix."}
  clearfix
  ["&"
   {:*zoom 1}
   ["&:before" "&:after"
    {:content "\"\""
     :display "table"}]
   ["&:after"
    {:clear "both"}]])

;; In Sass configuration is achieved through the use of mutable
;; variables. In Clojure we can define our default configuration as an
;; immutable *value*. Later we can refer to this value when building
;; out or grid system. Note how we can use Clojure's tagged literals
;; to make our stylesheet code look more like CSS.

;; SEE: https://github.com/twigkit/semantic.gs/blob/master/stylesheets/scss/grid.scss#L6-L8
(def grid-defaults
  {:column-width (px 80)
   :gutter-width (px 0)
   :columns 12})

;; This function has been ported directly from the SCSS code.

;; SEE: https://github.com/twigkit/semantic.gs/blob/master/stylesheets/scss/grid.scss#L11-L13
(defn grid-system-width
  [{:keys [column-width columns gutter-width]}]
  (+ (* column-width columns)
     (* gutter-width columns)))

;; Since we aren't using mutable values to configure our grid system
;; and it's behavior, we need to apply a functional approach. Instead
;; of functions which simply respond to mutable values in the
;; surrounding code, we use higher order functions to create an
;; "instance" of a grid system based upon it's input values.

;; There are four key functions which are commonly used when working
;; with grid systems: `row`, `column`, `push`, and `pull`. The
;; following higher order functions assist in creating them. Each one
;; accepts grid configuration via a map and returns an instance of one
;; of these key functions.

;; https://github.com/twigkit/semantic.gs/blob/master/stylesheets/scss/grid.scss#L46-L53
(defn row-fn
  "Creates a row function based on a grid configuration."
  [{:keys [total-width grid-width gutter-width]}]
  (fn []
    ["&"
     clearfix
     {:display "block"
      :width (* total-width
                (/ (+ gutter-width grid-width)
                   grid-width))
      :margin [0 (* total-width
                    (- (/ (* 0.5 gutter-width)
                          grid-width)))]}]))

;; https://github.com/twigkit/semantic.gs/blob/master/stylesheets/scss/grid.scss#L54-L61
(defn column-fn
  "Creates a column function based on a grid configuration."
  [{:keys [total-width grid-width column-width gutter-width]}]
  (fn [n]
    {:display "inline"
     :float "left"
     :width (* total-width
               (/ (- (* (+ gutter-width
                           column-width)
                        n)
                     gutter-width)
                  grid-width))
     :margin [0 (* total-width
                   (/ (* 0.5 gutter-width)
                      grid-width))]}))

(defn offset-margin
  "Computes the offset amount for push and pull functions."
  [{:keys [total-width grid-width column-width gutter-width]} amount]
  (+ (* total-width
        (/ (* (+ gutter-width
                 column-width)
              amount)
           grid-width))
     (* total-width
        (/ (* 0.5 gutter-width)
           grid-width))))

;; Lastly, we need a function for tying everything together.

(defn create-grid
  ([]
     ;; Make use of the default grid settings.
     (create-grid grid-defaults))
  ([grid-opts]
     (let [;; Ensure we have everything we need to generate the key
           ;; functions mentioned above.
           opts (merge grid-defaults grid-opts)
           {:keys [column-width gutter-width total-width]} opts
           ;; Calculate the grid with.
           grid-width (grid-system-width grid-opts)
           opts (assoc opts
                  :grid-width grid-width
                  :total-width (or total-width grid-width))
           ;; Partially evaluate `offset-margin` with our grid options
           ;; for our custom `push` and `pull` functions.
           offset (partial offset-margin opts)]
       ;; Return a map representing an instance of our grid system.
       {:row (row-fn opts)
        :column (column-fn opts)
        :push (fn [amount]
                {:margin-left (offset amount)})
        :pull (fn [amount]
                {:margin-right (offset amount)})})))



(defroutes app-routes
  (GET "/" []
    ;; Render the demo. Compare with the demo on the Semantic Grid
    ;; website.
    ;;
    ;; SEE: http://semantic.gs/examples/fixed/fixed.html
    (html5
     [:head
      [:style (css three-columns)]]
     [:body

      (center
       (top [:h1 "The Semantic Grid System"])
       (left [:h2 "L"])
       (middle [:h2 "M"])
       (right [:h2 "R"]))

      ]))
  (route/resources "/")
  (route/not-found (with-locale :nl (t :basis/missing-page)) ))

(def app
  (handler/site app-routes))

(defonce server (run-jetty #'app {:port 8080 :join? false}))

;(.start server)
;;(.stop server)



