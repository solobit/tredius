(ns nl.tredius.lab.into)

;; Clojure poogt een aantal essentiele stukken fundamentrot op te lossen en ondervangen.

;; Imperative programming is a programming paradigm that describes computation in terms
;; of statements that change a program state. In much the same way that imperative mood
;; in natural languages expresses commands to take action, e.g. "walk here", "do that",
;; imperative programs define sequences of commands for the computer to perform.

;; The term is used in opposition to declarative programming, which expresses what the
;; program should accomplish without prescribing how to do it in terms of sequences
;; of actions to be taken.

;; Procedural programming is imperative programming in which the program is built from
;; one or more procedures (also known as subroutines or functions).

;; Heavily procedural programming, in which state changes are localized to procedures
;; or restricted to explicit arguments and returns from procedures, is known as structured
;; programming.

;; From the 1960s onwards, structured programming and modular programming in general have
;; been promoted as techniques to improve the maintainability and overall quality of
;; imperative programs. Object-oriented programming extends this approach.




;; Clojure is gebasseerd op Java, in Java is code georganiseerd als volgt:

;; - >> Packages (bundel software bibliotheken/programmas)
;;      bv. `incanter` te gebruiken als o.a. (ns incanter) of (ns foo (:require [incanter core]))

;; - - >> Namespaces (organisatie van code in logische hoofdcomponenten)
;;        bv. `incanter.core` of `incanter.processing`

;; Code = data (in Lisp'n)

;; - - - >> Functies, variabelen, macros

;; Uiteindelijk kan alles opgebouwd worden uit 6,7 elementaire bouwstenen

;; Dit is alleen onhandig, derhalve o.a. Macros.

;(def een-variabele "is in principe niet meer te wijzigen, bekend onder de naam als immutable")

