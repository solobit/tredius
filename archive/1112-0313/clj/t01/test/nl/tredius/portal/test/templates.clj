(ns nl.tredius.portal.templates.test
  (:use clostache.parser)
  (:require [nl.tredius.portal.data.config :refer [cfg-site]]))

(render "Hello, {{site-name}}!" cfg-site)