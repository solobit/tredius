### cson
layout:     'standaard'
kenmerk:    'pensioenadvies'
titel:      "Risico- &amp; Pensioenadvies"
subtitel:   'Pensioenadvies'
bannier:    'bg_pensioen.jpg'
###

text @partial 'inhoud/gedeeld/pensioen'


#           ,                          __________________________1.0____
#═══-Oº°‘¨\/\widget/\/¨‘°ºO-═══════════\\══════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\   Widget: visitekaartje     ║
, poc: @org.contactpersonen.marco     #  \\════════════════════════════╝
, txt: ["Mocht u behoefte hebben aan een professioneel en gedegen
 pensioenadvies,","neemt u dan contact op met onze pensioenspecialist:"]
#═══════════════════════════════════════════════════════════════════════
