(ns nl.tredius.mailer.postal
  (:use postal.core))

(send-message {:from "foo"
               :to ["maildumpert@gmail.com"]
               :cc ""
               :subject "Nooooooooo."
               :body "Test."
               :X-Tra "Something else"})



