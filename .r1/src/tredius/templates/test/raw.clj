(ns tredius.templates.st
   (:use clojure.test))

(create-view)
(create-view "
{% extends \"tredius/views/templates/base.html\" %}

{% block content %}

 {{navigation}}
 <div class=\"hero-unit\">
    <h1>$welcome$</h1>
    <p>$calling$</p>
    <p><a class=\"$btn$ btn-primary btn-large\" href=\"$url$\">$learn$</a></p>
 </div>

 <div class\"row\">
    <div class=\"span12\">
    {{content}}
    </div>
 </div>


{% endblock %}
")


(defn test1 []
   (let [template  "Hello $who$!"
            new-empty (create-view)
            new!empty (create-view "Some stuff")
            ;from-clp  (get-view-from-classpath "st/foo")
            from-dir  (get-view-from-dir "st/foo" "src/tredius/templates")
            allviews  [new-empty new!empty from-dir]
            _ (map #(reset-view! % template)     allviews)
            _ (map #(fill-view! % "who" "World") allviews)]
        (doseq [each allviews]
          (= "Hello World!" (render-view each)))))

 (create-view)
 (create-view "Some stuff")

 (fill-view!
  (get-view-from-dir
   "st/foo" "src/tredius/templates") "names" names)
