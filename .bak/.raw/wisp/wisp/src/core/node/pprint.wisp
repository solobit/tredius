(import [dictionary? dictionary merge keys vals key-values str and char int or] "./wisp/src/runtime")

(defn pretty-print
 "Pretty print JSON data in color and with a nice tree."
  [form] (cond (dictionary? form)
          (. (require "prettyjson") render form)))

(def pretty-table
 ^{:doc "Gets a pretty-printer for tabular data."}
 (let [Table (require "cli-table")]
  (Table. {:head ["Kop 1" "Kop 2"]
           :colWidths [100 200]})))

;(pretty-table.push ["First val" "Second val"] ["Value 1" "Value 2"])
;(log (pretty-table.toString))

