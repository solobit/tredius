(ns nl.tredius.mailer.cwtest
  (:use clojure.test
        clojurewerkz.mailer.core))

(delivery-mode! :test)

(use-fixtures :each reset-deliveries!)

;;
;; Unknown delivery modes
;;

(deftest test-attempt-to-use-unknown-delivery-mode
  (is (thrown? IllegalArgumentException
               (with-delivery-mode :magic-fairies
                 (deliver-email {:from "baal@ares.domain.tld" :to "susy <susy@ares.domain.tld>"}
                                "templates/hello.mustache" {:name "susy"})))))


;;
;; Rendering
;;

(deftest test-rendering-of-resource-template
  (is (= "Hello, baal!" (render "templates/hello.mustache" {:name "baal"}))))

(deftest test-rendering-of-resource-template-with-conditions
  (is (= "Hello, baal!\n" (render "templates/conditional_hello.mustache" {:person {:name "baal"}}))))



;;
;; Building
;;

(deftest test-building-messages
  (let [d        { :cc ["baz@bar.dom" "Quux <quux@bar.dom>"] }
        expected-hdr {:from "fee@bar.dom"
                      :to "Foo Bar <foo@bar.dom>"
                      :cc ["baz@bar.dom" "Quux <quux@bar.dom>"]
                      :subject "Hello"}
        expected-content "Hello, baal!"
        expected-type "text/plain"]
    (with-delivery-mode :test
      (with-defaults d
        (let [email (build-email {:from    "fee@bar.dom"
                                  :to      "Foo Bar <foo@bar.dom>"
                                  :subject "Hello"}
                                 "templates/hello.mustache" {:name "baal"}
                                 :text/plain)
              content (:content (first (:body email)))
              type (:type (first (:body email)))]
          (doseq [[k v] expected-hdr]
            (is (= v (k email))))
          (is (= content expected-content))
          (is (= type expected-type)))))))


;;
;; Test Delivery
;;

(deftest test-test-delivery-mode
  (is (= 0 (count @deliveries)))
  (with-delivery-mode :test
    (deliver-email {:from "baal@ares.domain.tld" :to "susy <susy@ares.domain.tld>"}
                   "templates/hello.mustache" {:name "susy"})
    (deliver-email {:from "susy <susy@ares.domain.tld>" :to "baal@ares.domain.tld"}
                   "templates/hello.mustache" {:name "baal"}))
  (is (= 2 (count @deliveries))))

(deftest test-reset-deliveries
  (is (= 0 (count @deliveries)))
  (with-delivery-mode :test
    (deliver-email {:from "baal@ares.domain.tld" :to "susy <susy@ares.domain.tld>"}
                   "templates/hello.mustache" {:name "susy"})
    (deliver-email {:from "susy <susy@ares.domain.tld>" :to "baal@ares.domain.tld"}
                   "templates/hello.mustache" {:name "baal"}))
  (is (= 2 (count @deliveries)))
  (reset-deliveries!)
  (is (= 0 (count @deliveries))))


;;
;; SMTP Delivery
;;

;; TBD


;;
;; Sendmail Delivery
;;

;; TBD
