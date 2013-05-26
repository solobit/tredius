
(try (. (require "fs") writeFileSync "/root/a.txt" "foo"
  (raise exception)
  (catch error (recover error))
  (finally (.log console "That was a close one!"))))

;; https://github.com/rvagg/node-errno
(defn recover [err]
  (let [msg   "Error: "
        errno (require "errno")]
  ;; if it's a libuv error then get the description from errno
   (if (get errno.errno (err.errno))
     (set! msg (str msg (get errno.errno (.-err errno) description))
     (set! msg (str msg err.message))
    ;; if it's a `fs` error then it'll have a 'path' property
    (if (err.path) (set! msg (str msg err.path)))
    msg))))

