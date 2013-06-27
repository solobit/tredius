### cson

kenmerk:        'dbh'
naam:           'Tredius Debiteuren Abonnement'
groep:          'Debiteurenbeheer &amp; Incasso'
titel:          'Debiteurenbeheer'
subtitel:       'Geen no cure no pay, maar een Tredius abonnement'
layout:         'standaard'
bannier:        'hdr_debiteurenbeheer.png'

product:
    naam:       'Tredius Debiteuren Abonnement'
    groep:      'Financiële dienstverlening'
    prijs:      'vanaf € 100,- ex BTW per maand'
    icoon:      'debiteuren_abonnement.png'

omschrijving:   "Met een Tredius Debiteuren Abonnement bent u verzekerd
 van een duurzame relatie tot uw debiteuren."

samenvatting:   "
Tredius Debiteurenbeheer werkt niet op basis van ‘no cure no pay’. Wij
 zijn van mening dat het behoud van een goede relatie tussen u en uw
 klant prioriteit heeft."

###

h1 '.Tagline'
, "Geen no cure no pay, maar een Tredius Debiteuren Abonnement"
# ----------------------------------------------------------------------

p "Wij zijn van mening dat het behoud van een goede relatie tussen u en
 uw klant prioriteit heeft. Wij kunnen die kwaliteit alleen waarborgen
 als wij niet afhankelijk zijn van het resultaat. Daarom werken wij niet
 'no cure no pay', maar met het <strong>Tredius Debiteuren
 Abonnement</strong>: voor een vast bedrag beheren wij uw debiteuren.
 Weet u precies waar u aan toe bent."

section '.Dienstverlening', ->


    # widget » producten ══════════════════════════════════════════════╗
    section '.AanmeldenProductBijsluiter' # 3 kolommen paars           ║
    #══════════════════════════════════════════════════════════════════╝
    , -> text @partial 'widgets/producten', @


    # widget » formulieren ════════════════════════════════════════════╗
    section '.AanmeldenProductFormulier'  # 8 kolommen turquoise       ║
    #══════════════════════════════════════════════════════════════════╝
    , ->
        text @partial 'widgets/formulieren', {
            doc: @document
            txt: "Sluit hier uw #{@document.naam} af"
            cls: ".Kolom-8.Achtergrond-groen"
            uri: @getMailUri(145467, 20853)
            fld: ['anaam*','tel','email*','pc','plaats','vink', ['wis', 'zend']]
        }


# widget » visitekaartje ══════════════════════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\     nodigt uit tot actie    ║
, poc: @org.contactpersonen.linda     #  \\════════════════════════════╝
, txt: [ "Heeft u vragen over #{@document.groep} of wilt u eens sparren
 met een van onze specialisten?", "Neemt u dan contact op met:"]
# ══════════════════════════════════════════════════════════════════════
