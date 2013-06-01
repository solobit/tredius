(ns tredius.templates.st
   (:use clojure.test))


(def who "Miguel")
(def names ["Eugenia" "Matt" "Derek"])

(defn !nil? "Tells whether an object is not-nil" [obj] (not (nil? obj)))

(defn fail "Fails a test with message" [msg] (println msg) (is false))

(defmacro fail-on-exception [& body]
  `(try ~@body
    (catch Exception ~'nee
      (.printStackTrace ~'nee)
      (fail (.getMessage ~'nee)))))

(defmacro now-testing [label & body]
  (println "Now testing: " label)
  `(testing ~label ~@body))


(deftest test-create-view
  (now-testing "Get new view"
    (fail-on-exception
      (let [new-empty (create-view)
            new-templ (create-view "Hello $who$!")
            _         (fill-view! new-templ "who" "World")
            newtemp-r (render-view new-templ)]
        (is (!nil? new-empty))
        (is (!nil? new-templ))
        (is (= "Hello World!" newtemp-r))))))


(deftest test-get-view-from-classpath
  (now-testing "Load view from classpath"
    (fail-on-exception
      (let [hello (get-view-from-classpath "hello")
            foo   (get-view-from-classpath "st/foo")]
        (is (!nil? hello))
        (is (!nil? foo))))))


(deftest test-get-view-from-dir
  (now-testing "Load view from directory"
    (fail-on-exception
      (let [hello (get-view-from-dir "hello"  "src/test/clj")
            foo   (get-view-from-dir "st/foo" "src/test/clj")]
        (is (!nil? hello))
        (is (!nil? foo))))))


(deftest test-reset-view
  (now-testing "Reset view"
    (fail-on-exception
      (let [template  "Hello $who$!"
            new-empty (create-view)
            new!empty (create-view "Some stuff")
            from-clp  (get-view-from-classpath "st/foo")
            from-dir  (get-view-from-dir "st/foo" "src/test/clj")
            allviews  [new-empty new!empty from-clp from-dir]
            _ (map #(reset-view! % template)     allviews)
            _ (map #(fill-view! % "who" "World") allviews)]
        (doseq [each allviews]
          (= "Hello World!" (render-view each)))))))


(deftest test-populate-attr-values-in-view
  (now-testing "Populate attribute key-values in view"
    (fail-on-exception
      (let [hello (get-view-from-classpath "hello")
            _ (fill-view! hello "who" who)
            foo   (get-view-from-classpath "st/foo")
            _ (fill-view! foo "names" names)]
        (is (!nil? hello))
        (is (!nil? foo)))))
  (now-testing "Populate attribute key/value map in view"
    (fail-on-exception
      (let [hello (get-view-from-classpath "hello")
            _ (fill-view! hello {"who" who})
            foo   (get-view-from-classpath "st/foo")
            _ (fill-view! foo {"names" names})]
        (is (!nil? hello))
        (is (!nil? foo))))))


(deftest test-render-view
  (now-testing "Render view"
    (fail-on-exception
      (let [hello   (get-view-from-classpath "hello")
            _       (fill-view! hello "who" who)
            hello-r (render-view hello)
            foo     (get-view-from-classpath "st/foo")
            _       (fill-view! foo "names" names)
            foo-r   (render-view foo)
            delim   (System/getProperty "line.separator")]
        (is (= hello-r (str "hello " who "!")))
        (is (= foo-r (apply str "foobar "
                       (interpose delim (map #(str "baz " % delim) names)))))))))

(deftest test-kv-to-sv
  (now-testing "Transform Keyword-key/Value map to String-key/value map"
    (is (= {"a" 10 "b" 20 "c" 30}
          (kv-to-sv {:a 10 :b 20 :c 30})))
    (is (= {"a" 10 "b" 20 "c" 30}
          (kv-to-sv {:a 10 "b" 20 :c 30})))))

(defn test-ns-hook []
  (test-kv-to-sv)
  (test-get-view-from-classpath)
  (test-get-view-from-dir)
  (test-populate-attr-values-in-view)
  (test-render-view)
  (test-create-view)
  (test-reset-view))

