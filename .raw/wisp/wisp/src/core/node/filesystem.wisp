
(import fs "fs")
(import path "path")
(import [first map filter take second list? seq list] "../sequence")
(import [string? vector? object? vals keys dec re-find count
         str =] "../runtime")
(import [join split] "../string")
(import [symbol] "../ast")

;; ~~~~~~~~~~~~~~~~
;; Functions
;; ~~~~~~~~~~~~~~~~

(defn exec [cmds]
 "Execute terminal commands, optionally in sequence, with arguments parsed
 and out of the box proper pipes to stdin, -out, -err & exit code"
 ^{:usage "(exec \"cmd -args\")
           (exec [\"cmd1\" \"next-cmd\" \"cmd-n\"])"}
  (let [execute (require "executive")]
    (execute cmds (fn [err out code] out))))

(defn inode-isa [path]
 "Returns a string representation of the type of filesystem object (inode):
 directory, file, block- or character-device or symbolic link, FIFO or
 a Unix socket."
 (if (string? path)
  (try
    (let [inode (. fs lstatSync path)]
      (cond (.directory? inode) "directory"
            (.file? inode) "file"
            (.block-device? inode) "block device"
            (.character-device? inode) "character device"
            (.symbolic-link? inode) "symbolic link"
            (.FIFO? inode) "FIFO"
            (.socket? inode) "socket"))
  (catch error (.error console error.message)))))

(defn resolve-dir
 "Resolves the path of the directory. Since paths are references to inodes and,
 in return those may be of any kind (dir, link, file, device, socket, fifo)."
  [x]
  (try
   (cond (.directory? (fs.lstatSync x)) (. path resolve x)
            (.file? (fs.lstatSync x)) (. path dirname (. path resolve x)))
   (catch error (. console log error.message))))

(defn file-seq
 "Perform a synchronous walk of a directory tree."
  [path]
  (let [walk (require "walkdir")]
    (try (. walk sync path)
     (catch error (. console error {error: error})))))

(defn regex-file-seq
 "Lazily filter a directory based on a regex."
  [re dir]
  (try
    (filter #(re-find re %) (file-seq dir))
    (catch error (.error console error.message))))

(defn assert-fs-chain []
 (try
  (exec "mkdir -p /tmp/testdir/a")
  (exec ["touch /tmp/testdir/a/aaa /tmp/testdir/a/bbb" "ls /tmp/testdir/a"])
  (. console log (file-seq "/tmp/testdir/a"))
  (catch error {})
  (finally (exec ["sleep 5" "rm -rf /tmp/testdir"]))))



;; ~~~~~~~~~~~~~
;; Todo / Tofix
;; ~~~~~~~~~~~~~

 ; FIXME (used to work :())
 ;(defmacro inode [form p]
 ; `(let [f (fs.lstatSync ~p)] (f.~form)))

 ;(inode directory? ".")


 ;; todo
 ;; (defn- archiveer ;; stub
 ;;   "Maakt een nieuw archief in .zip, .tar of .tgz (gzip)"
 ;;   [soort & bestanden]
 ;;   (fn))

