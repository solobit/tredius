(ns nl.tredius.portal.views.forms
  (:require [compojure.core :refer [defroutes GET POST ANY]]
            [compojure.handler :refer [site]]
            [ring.middleware.stacktrace :as trace]
            [ring.adapter.jetty :as jetty]
            [environ.core :refer [env]]
            [formative.core :as f]
            [formative.parse :as fp]
            [hiccup.page :as page]
            [clojure.pprint :refer [pprint]]))


(defn valideer-upload-cv
  "Valideer de upload van het bestand."
  [values]
  (let [filename (not-empty (get-in values [:voeg-je-cv-toe "filename"]))]
    (when (and filename (not (re-find #"(\.doc|\.docx|\.pdf|\.odt|\.rtf|\.pages|\.txt)$" filename)))
      {:keys [:voeg-je-cv-toe] :msg "Alleen tekstbestanden of documentopmaak
        (.doc,.docx,.pdf,.odt,.rtf,.pages,.txt)"})))

(def werken-bij-form
  {:enctype "multipart/form-data"
   :fields [{:name :h1 :type :heading :text "Solliciteren"}
            {:name :voornaam}
            {:name :achternaam}
            {:name :straatnaam}
            {:name :huisnummer}
            {:name :telefoonnummer}
            {:name :email :type :email}

            ;;{:name :spam :type :checkbox :label "Ja, neem contact met mij op."}
            ;;{:name :password :type :password}
            ;;{:name :password-confirm :type :password}

            {:name :h2 :type :heading :text "Overzicht vacatures"}
            {:name :note :type :html
             :html [:div.alert.alert-info "Aantal openstaande vacatures: 0"]}

            {:name :datum-beschikbaar :type :date-select}
            {:name :motivatie :type :checkboxes
             :options ["Ik wil meer verdienen"
                       "Ik zoek een nieuwe uitdaging"
                       "Ik wil dichterbij huis werken"
                       "Ik wil minder werken"]}

            {:name :h3 :type :heading :text "Section 3"}

            {:name :provincie :type :us-state
             :placeholder "Selecteer een provincie"}

            {:name :explanation :type :textarea
             :label "Vertel ons kort iets over jezelf of waarom je hier zou willen werken"}
            {:name :voeg-je-cv-toe :type :file :title "Voeg je CV toe:"}]

   :validations [[:required [:voornaam :achternaam
                             :telefoonnummer :email
                             :datum-beschikbaar]]

                 ;[:min-length 8 :password]
                 ;[:equal [:password :password-confirm]]
                 [:min-length 1 :motivatie "Kies minimaal 1 een motivatie"]]

   :validator valideer-upload-cv})

(def renderer-form
  {:method "get"
   :renderer :inline
   :submit-label nil
   :fields [{:name :renderer
             :type :select
             :options ["bootstrap-horizontal"
                       "bootstrap-stacked"
                       "table"]
             ;; Modify layout as this changes
             :onchange "this.form.submit()"}]})

(defn layout [& body]
  (page/html5
    [:head
     [:title "Formative Demo"]
     (page/include-css "//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.2.2/css/bootstrap.min.css")
     ;;(page/include-css "//google-code-prettify.googlecode.com/svn/trunk/src/prettify.css")
     [:style
      "body { margin: 2em; }"
      ".form-table { width: 100%; }"
      ".form-table th { text-align: left; }"
      ".form-table h3 { border-bottom: 1px solid #ddd; }"
      ".form-table .label-cell { vertical-align: top; text-align: right; padding-right: 10px; padding-top: 10px; }"
      ".form-table td { vertical-align: top; padding-top: 5px; }"
      ".form-table .checkbox-row label { display: inline; margin-left: 5px; }"
      ".form-table .checkbox-row .input-shell { margin-bottom: 10px; }"
      ".form-table .submit-row th, .form-table .submit-row td { padding: 30px 0; }"
      ".form-table .problem th, .form-table .problem td { color: #b94a48; background: #fee; }"]]
    [:body {:onload "prettyPrint()"}
     body]
    (page/include-js "//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js")
    (page/include-js "//google-code-prettify.googlecode.com/svn/trunk/src/prettify.js")
    (page/include-js "//google-code-prettify.googlecode.com/svn/trunk/src/lang-clj.js")
    (page/include-js "https://raw.github.com/grevory/bootstrap-file-input/master/bootstrap.file-input.js")))


(defn weergeven-formulier
  "Geef het formulier weer en toon deze aan de gebruiker."
  [params & {:keys [problems]}]

  (let [renderer (if (:renderer params)
                   (keyword (:renderer params))
                   :bootstrap-horizontal)
        defaults {:spam true
                  :date (java.util.Date.)}]

    (layout
     [:div.pull-right
      (f/render-form
       (assoc renderer-form :values params))]

     [:h1 "Werken bij Tredius"]

     [:div.pull-left {:style "width: 70%"}
       (f/render-form (assoc werken-bij-form
                             :renderer renderer
                             :values (merge defaults params)
                             :problems problems))])))


(defn verzenden-formulier
  "Verzend het formulier naar de server en verwerk de redirect."
  [params]
  (fp/with-fallback (partial weergeven-formulier params :problems)
    (let [values (fp/parse-params werken-bij-form params)]
      (layout
        [:h1 "Bedankt voor uw inzending!"]
        [:pre.prettyprint.lang-clj (with-out-str (pprint values))]
        [:p [:a {:href "/"} "Terug naar het formulier"]]))))

(defroutes routes
  (GET "/" [& params] (weergeven-formulier params))
  (POST "/" [& params] (verzenden-formulier params))
  (ANY "*" [] "Pagina niet gevonden!"))

(def app
  (-> #'routes trace/wrap-stacktrace site))

(defn -main [& [port]]
  (let [port (Integer. (or port (env :port) 5000))]
    (jetty/run-jetty #'app
                     {:port port :join? false})))

;; For interactive development:
;; (.stop server)
(def server (-main))
