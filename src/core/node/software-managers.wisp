(require "pkginfo")
;; Versiebeheer is een van deze zaken die van belang is voor het delen van bibliotheken zodat deze ook binnen andere programmas werkzaam en werkbaar is.

;; Het semantische versie systeem is een afspraak tussen ontwikkelaars van software. Het volgt een op conventies (overeenkomsten) gebaseerd systeem van versie-nummers: 1.0.2 -> geen grote wijzigingen, 1.1.0 -> mogelijk breekt de software, Majors 2.0.0 -> gegarandeerd problemen indien geen conversie plaats vindt.
(require "semver")

;; De laatste versies van programmas vinden kan lastig zijn, hulp is welkom.
(require "latest")
