

(defn- start-docpad []
  "Start een docpad site generator exemplaar op."
  (. (require "docpad") createInstance {} ))
