(import fs "fs")
(import path "path")
(import [file-seq] "./filesystem")
(import [filter] "../sequence")
(import [string? nil? re-find re-matches dictionary?] "../runtime")


(defn load-config
  "Tries to load a configuration using some sane defaults that depend on the
  type arguments provided. Give a string and it will try to read a file, objects
  are configurations and, if no arguments are provided, it will look to see if a
  (inline) default config object is present (defaults)."
  [params]
  (cond (nil? params) (if (not (nil? default-options)) defaults)
        (string? params) (try
                           (if (not (. fs existsSync params) (raise error)))
                           (catch error (.log console error))
                           (finally (. fs readFileSync params "utf-8")))
        (dictionary? params) params)))


;; so now we may have read a file, which could (or not) be a configuration, but
;; what type is it? in other words, what data format is it so we can serialize
;; the data?


;; project management tools

;; Java/Clojure offspring: ant maven leiningen

;; JavaScript Node.js: Cakefile Jakefile

;; Ruby: Gemfile Rakefile

;; GNU-autotools Makefile

;; GitHub/SVN/Mercurial and others:
;; HISTORY.md LICENSES.md README.md



(defn- conf []
  "Projectbestand bevat JSON notatie, lees deze eenvoudig uit met nconf."
  (. (require "nconf") file {:file (.join path "" "") }))
