### cson
titel:          'Vestiging Monnickendam'
layout:         'standaard'
naam:           'Vestigingen'
kenmerk:        'monnickendam'
bannier:        'bg_bruin.gif'

samenvatting: "Tredius heeft op dit moment vier vestigingen in Noord-
 Holland. Alle vestigingen zijn makkelijk te bereiken met eigen of
 openbaar vervoer. Zie voor de contactgegevens hieronder."
###

text @partial 'widgets/locaties', vestiging: @org.vestigingen[@document.kenmerk]

