### cson
titel:          'Vestiging Haarlem'
thing:          's:ContactPage'
naam:           'Vestigingen'
kenmerk:        'haarlem'
layout:         'standaard'
bannier:        'bg_bruin.gif'

samenvatting:   'Tredius heeft op dit moment vier vestigingen in Noord-
Holland. Alle vestigingen zijn makkelijk te bereiken met eigen of
openbaar vervoer. Zie voor de contactgegevens hieronder.'
###

text @partial 'widgets/locaties', vestiging: @org.vestigingen[@document.kenmerk]

