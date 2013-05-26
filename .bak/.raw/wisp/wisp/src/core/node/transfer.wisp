

(defn- upload-ftp []
 "Hiermee uploaden we bestanden naar een remote FTP van een server."
  (let [local    "boo.txt" ;; TODO mapping to out/ folder
        remote   "boo.remote-copy.txt"
        client   (require "ftp")]
    (do
      (.put client local remote
        (try
          (raise exception)
          (catch error (recover error))
          (finally (.end c)))
      (c.connect)))))
