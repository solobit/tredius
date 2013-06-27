;;
;; Clojure OpenNLP Dutch
;;
(ns nl.tredius.lab.04
  (:use [clojure.pprint] ; just for this documentation
        [opennlp.nlp]
        [opennlp.treebank])) ; treebank chunking, parsing and linking lives here

(defn model-path [x] (str "src/resources/opennlp/models/" "nl-" x))

(def get-sentences (make-sentence-detector (model-path "sent.bin")))
(def tokenize (make-tokenizer (model-path "token.bin")))
;(def detokenize (make-detokenizer (model-path "detokenizer.xml")))
(def pos-tag (make-pos-tagger (model-path "pos-maxent.bin")))
(def name-find (make-name-finder (model-path "ner-person.bin")))
;(def chunker (make-treebank-chunker (model-path "chunker.bin")))

(def zinnen ["De eerste zin. Een tweede zin? Neen! Een vierde, geen derde zin. Enzovoorts... Dus dan, hoeveel zinnen?"
             "Jack gaf aan John een tientje voor het wassen van zijn spiksplinternieuwe auto."
             "De manier waarop de aarde verandert, heeft een enorme impact op de mensheid, zegt de Amerikaanse president Barack Obama."
             ])

;(pprint (get-sentences (zinnen 0)))

;(pprint (pos-tag (zinnen 1)))

;(name-find (zinnen 1))

;(meta (name-find ["My" "name" "is" "John"]))

;; We therefore distinguish between
;; (non-volitional and volitional) content,
;; epistemic and speechact relations,
;; as illustrated by the constructed examples in (1)-(4) below.

;; (1) Non-volitional content
;; The temperature rose quickly because the sun was shining.

;; (2) Volitional content
;; We went out in the garden because the sun was shining.

;; (3) Epistemic
;; The temperature is probably going to rise, because the sun is shining.

;; (4) Speech act
;; Let’s have dinner in the garden, because the sun is shining
