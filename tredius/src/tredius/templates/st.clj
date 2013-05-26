(ns tredius.templates
  (:require [tredius.utils.stringtemplate]))

(def *template (load-st "src/tredius/templates/" "sql")) ;;

(render-st *template {"column" "name" "table" "students"})

(def *demplate (update-st *template {"table" "employees"}))

(render-st *demplate {"column" "name"})

(render-st *demplate {"column" "name" "table" "students"})

(update-st *demplate {"column" "bar, foo"})
(update-st *demplate {"column" "foo"})