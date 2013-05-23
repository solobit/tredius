
(import fs "fs")
(import path "path")
(import [first map filter take second list? seq list] "../../sequence")
(import [string? vector? object? vals keys dec re-find count
         str =] "../../runtime")
(import [join split] "../../string")
(import [symbol] "../../ast")

;; Test setup
(import [exec inode-isa resolve-dir regex-file-seq file-seq] "../filesystem")


(. console log (str "Testing " module.filename))

(assert (= (object? (exec (str "ls " module.filename))) true))
(assert (= "directory" (inode-isa ".")))
(assert (= "file" (inode-isa module.filename)))
(assert (not (= "foo" (inode-isa "."))))
(assert (= (resolve-dir ".") (resolve-dir module.filename)))
(assert (vector? (regex-file-seq #"wisp" ".")))
(defn- assert-fs-chain []
 (try
  (exec "mkdir -p /tmp/testdir/a")
  (exec ["touch /tmp/testdir/a/aaa /tmp/testdir/a/bbb" "ls /tmp/testdir/a"])
  (. console log (file-seq "/tmp/testdir/a"))
  (catch error {})
  (finally (exec ["sleep 5" "rm -rf /tmp/testdir"]))))
