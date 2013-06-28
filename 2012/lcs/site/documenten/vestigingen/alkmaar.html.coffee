### cson
titel:          'Vestiging Alkmaar'
naam:           'Vestigingen'
kenmerk:        'alkmaar'
thing:          's:ContactPage'
layout:         'standaard'
bannier:        'bg_bruin.gif'

samenvatting:   "Tredius heeft op dit moment vier vestigingen in Noord-
 Holland. Alle vestigingen zijn makkelijk te bereiken met eigen of
 openbaar vervoer. Zie voor de contactgegevens hieronder."

###

text @partial 'widgets/locaties', vestiging: @org.vestigingen[@document.kenmerk]

