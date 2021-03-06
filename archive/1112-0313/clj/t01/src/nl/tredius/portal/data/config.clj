(ns nl.tredius.portal.data.config
  (:require [cheshire.core :refer :all]
            [clojure.string :as string]))

;; static
(def cfg-site
  {:customer "Tredius BV"
   :site-name "Tredius"
   :base-url "http://www.tredius.nl"
   :domain "Tredius.nl"
   :description "U onderneemt, Tredius doet de rest."})

(defn- ucfirst [^String s]
  (str (Character/toUpperCase (.charAt s 0)) (subs s 1)))


(defn geef-label
  "Bepaalt wat voor veldnaam te gebruiken. Gebruikt :label indien aanwezig,
  anders de :name als een string bijv. :wie-zijn-wij? => Wie zijn wij?"
  [field]
  (if (contains? field :label)
    (if (string? (:label field))
      (ucfirst (:label field))
      (:label field))
    (-> (:name field)
      name
      (string/replace #"[_-]" " ")
      (string/replace #"\bid\b" "ID")
      ucfirst)))



(comment "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures. - Alan Perlis")



(def ^:private data

  {:account {:customer {:name "Tredius" :contact "info@tredius.nl"}
             :googleanalytics "UA-39413290-1"}

   :packages {:name "tredius-corporate"
              :version "0.0.5"
              :description "Tredius corporate web site"
              :main "docpad.coffee"
              :private true
              :preferGlobal false}

   :taxonomy {:keywords ["accountancy" "belastingen" "pensioen" "adviseurs" "detachering" "loonadminstratie" "juridische" "diensten"]}

   :directories {:site {:root "./" :public "publiek" :image-root "media/afbeeldingen"}
                 :node {:bin "bin" :lib "lib" :doc "doc" :man "doc/man" :example "doc/samples"}}

   :website  {:domains {:portal {:name "Tredius.nl" :url "http://www.tredius.nl"}
                        :static {:name "Static files" :url "http://static.tredius.nl"}}

              :development "http//solobit.github.io/tredius" :author "Solobit &amp; Edberry Creative" :copyright "2013 © Tredius.nl"
              :mission "Tredius verleent financiële-, fiscale-, juridische-, personele- en bedrijfsadministratieve diensten aan het MKB van Nederland"
              :vision "Bij Tredius hebben we de behoeftef om het MKB landschap te veranderen Vrijheid, Onafhankelijkheid en Zelfstandigheid, voor iedere ondernemer."
              :support {:maintenance "Solobit" :emailadres "rob.jentzema@gmail.com" :servicenumber "013-5906677"}
              :culture {:country "nl" :xmllang "nl"}

              :technology "Clojure, Node.js, JSON/SMILE, Docpad, jQuery, Semantic Grid, Stylus, Jade, CoffeeScript, Markdown, Accessible Rich Internet Applications (WAI-ARIA)"
              :disclaimer "De informatie zoals opgenomen in bovenstaand artikel is uitsluitend bestemd voor algemene informatiedoeleinden. Derhalve dienen op grond van deze informatie geen handelingen te worden verricht zonder voorafgaand deskundig advies. Voor een toelichting kunt u uiteraard contact opnemen met een van onze kantoren."

              :vocabulary {"xmlns:s" "http://schema.org/" "xmlns:foaf" "http://xmlns.com/foaf/0.1/" "xmlns:xsd" "http://www.w3.org/2001/XMLSchema#" "xmlns:v" "http://rdf.data-vocabulary.org/#" "xmlns:pto" "http://www.productontology.org/id/" "xmlns:wn" "http://xmlns.com/wordnet/1.6/"}

              :frontend {:engines {:templating {:html ["Clabango" "Hiccup" "Coffeekup"]} :preprocessors {:css "Stylus"} :transpilers {:js "Coffeescript"}}
                         :component ["component/dropload" "*" "component/upload" "*" "component/file" "*" "component/pillbox" "*" "component/classes" "*" "component/model" "*" "component/histogram" "*" "component/progress" "*" "component/thumb" "*" "component/enumerable" "0.3.1" "component/dom" "0.6.0"]
                         :styling {:filesystem {:input "index.styl" :output "algemeen.css" :paths ["documenten/stijlen/lib/cultivus"]}
                                   :typography {:primary ["Open Sans" "400italic" "600italic" "700italic" "400" "600" "700"]
                                                 :alternative ["Dosis" "400" "500" "600"]}
                                   :base   {:companylogo "bedrijfslogo.jpg" :favicons "favicon.png"}
                                   :grid   {:name "Semantic Grid" :columns 12 :type "fixed" :min-width 300 :max-width 960 :viewports false}
                                   :colors {:named {:orange "#F2A34F" :white "#ffffff" :black "#363636"
                                                    :yellow "#7A6A42" :gold "#b88d74"
                                                    :green "#7FC028" :turquoise "#6CBBB8"
                                                    :brown "#6b4c39" :light-brown "#b88c74"
                                                    :purple "#47427A" :light-purple "#6664a0"
                                                    :blue "#0183b5" :light-blue "#0183b5" :dark-blue "#403e6b"
                                                    :gray "#e0e0e0" :light-gray "#f8f8f8" :dark-gray "#919191"
                                                    :rood "#e31741" :light-red "#6b4c39"}}}



    :organisation  {:name "Tredius"

                    :address {:visiting {:street "Zijlweg 146" :postcode "2015 BH" :place "Haarlem" :country "Nederland"}
                              :postal   {:po-box "Postbus 992" :postcode "2003 RZ" :place "Haarlem" :country "Nederland"}}

                    :contact {:landphone "023 551 30 55" :fax "023 551 30 35" :email "info@tredius.nl"}

                    :commerce {:entity "Besloten Venootschap (BV)" :chambernr "3782878" :taxnr "NL8124.72.792.B01"}

                    ;; if they need to be mentioned on the site
                    :contacts {:marco   {:name "Marco Krijger" :title "MB FB" :foa "Dhr." :position "Partner Tredius Fiscalisten" :email "m.krijger@tredius.nl"}
                               :linda   {:name "Linda Honig" :foa "Mevr." :telephone "023 551 30 55" :email ""}
                               :lennard {:name "Lennard Honig" :aanhef "Dhr." :titel "" :telephone "023 551 30 55" :email ""}
                               :luuk    {:name "Luuk Oosting" :aanhef "Dhr." :titel "" :telephone "0299 651 987" :email ""}
                               :wil     {:name "Wil Buffing" :titel "Mevr." :telephone "0299 411 345" :email ""}}

                    :locations {:purmerend {:address {:visiting {:street "Wielingenstraat 119" :postcode "1441 ZN" :place "Purmerend" :region "Noord-Holland" :country "Nederland"}
                                            :postal  {:po-box "Postbus 258" :postcode "1440 AG" :place "Purmerend"}}
                                            :geocode ["52.503605" "4.958375"] :rest "geocode=Cc9PzZeFjzXfFYEnIQMdp59LACmPF3Re0AbGRzF_fLmc8BNprg&amp;sll=52.504454,4.956079&amp;sspn=0.009065,0.019054&amp;mra=pd&amp;t=m&amp;spn=0.0064,0.013282"
                                            :telephone "0299 411 345" :fax "0299 411 348" :email "info@tredius.nl"}

                                :monnickendam {:address {:visiting {:street "Haringburgwal 17" :postcode "1141 AT" :place "Monnickendam" :region "Noord-Holland" :country "Nederland"}
                                                         :postal {:po-box "Postbus 48" :postcode "1140 AA" :place "Monnickendam"}}
                                               :geocode ["52.462874" "5.035343"] :rest "geocode=CXRphrBe0kPwFRuFIAMdStVMACln1vctrAXGRzHfFo4FDFJsxg&amp;aq=&amp;sll=52.505806,4.827991&amp;sspn=0.269159,0.835648&amp;mra=pd&amp;spn=0.006406,0.013282"
                                               :telephone "0299 651 987" :fax "0299 653 004" :email "info@tredius.nl"}

                                :alkmaar {:address {:visiting {:street "Professor van der Waalsstraat 3K" :postcode "1821 BT" :place "Alkmaar" :region "Noord-Holland" :country "Nederland"}
                                                    :postadres {:street "Professor van der Waalsstraat 3K" :postcode "1821 BT" :country "Alkmaar"}}
                                          :geocode ["52.625092" "4.770384"] :rest "spn=0.006382,0.013282"
                                          :telephone "072 564 4203" :fax "072 564 3019" :email "info@tredius.nl"}

                                :haarlem {:address {:visiting { :street "Zijlweg 146" :postcode "2015 BH" :place "Haarlem" :region "Noord-Holland" :country "Nederland"}
                                                    :postal {:street "Postbus 992" :postcode "2003 RZ" :place "Haarlem"}}
                                          :geocode ["52.386457" "4.620631"] :rest "geocode=CWxUaXo29tzfFddYHwMdWoFGACkH_TJiEO_FRzHom-tyuYRbow&amp;sll=52.386457,4.620631&amp;sspn=0.008434,0.026114&amp;mra=iwd&amp;spn=0.006417,0.013282"

                                          :telephone "023 551 30 55" :fax "023 551 30 35" :email "info@tredius.nl"}}}})