(ns nl.tredius.vertalingen)

(def foo
  {:dev-mode?      true
   :default-locale :nl
   :dictionary
   {:en         {:example {:foo       ":en :example/foo text"
                           :foo_note  "Hello translator, please do x"
                           :bar {:baz ":en :example.bar/baz text"}
                           :greeting  "Hello {0}, how are you?"
                           :with-markdown "<tag>**strong**</tag>"
                           :with-exclaim! "<tag>**strong**</tag>"
                           :greeting-alias :example/greeting
                           :baz-alias      :example.bar/baz}
                 :missing  "<Translation missing: {0}>"}
    :en-US      {:example {:foo ":en-US :example/foo text"}}
    :en-US-var1 {:example {:foo ":en-US-var1 :example/foo text"}}
    :nl         {:example {:foo       ":nl :example/foo tekst"
                           :foo_note  "Hallo vertaler, maak aub x"
                           :bar {:baz ":nl :example.bar/baz tekst"}
                           :greeting  "Hallo {0}, hoe gaat het?"
                           :with-markdown "<tag>**strong**</tag>"
                           :with-exclaim! "<tag>**strong**</tag>"
                           :greeting-alias :example/greeting
                           :baz-alias      :example.bar/baz}
                 :missing  "<Translation missing: {0}>"}}})

 ;:log-missing-translation!-fn (fn [{:keys [dev-mode? locale k-or-ks]}] ...)}