### cson
voetmenu:   1
layout:     'standaard'
naam:       'Pensioen'
titel:      'Belasting'
subtitel:   'Pensioen'
kenmerk:    'pensioen'
bannier:    'bg_belastingadvies.jpg'

###

text @partial 'inhoud/gedeeld/pensioen'


#           ,                          __________________________1.0____
#═══-Oº°‘¨\/\widget/\/¨‘°ºO-═══════════\\══════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\   Widget: visitekaartje     ║
, poc: @org.contactpersonen.marco     #  \\════════════════════════════╝
, txt: ["Mocht u behoefte hebben aan een professioneel en gedegen
 pensioenadvies,","neemt u dan contact op met onze pensioenspecialist:"]
#═══════════════════════════════════════════════════════════════════════
