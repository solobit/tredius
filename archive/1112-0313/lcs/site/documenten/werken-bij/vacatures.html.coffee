### cson
voetmenu:       2
naam:           'Vacatures'
titel:          'Werken bij Tredius'
subtitel:       'Vacatures'
layout:         'standaard'
kenmerk:        'vacatures'
bannier:        'bg_bruin.gif'

samenvatting:   "Op deze pagina vind je al onze openstaande vacatures.
 Staan er geen vacatures of geen vacature die bij jou past, stuur ons dan
 een open sollicitatie. Wij zijn altijd op zoek goede mensen en komen
 graag met je in contact."

###

h1 '.Tagline', 'Solliciteren'
p 'Op deze pagina vind je al onze openstaande vacatures. Staan er geen
 vacatures of geen vacature die bij jou past, stuur ons dan een open
 sollicitatie. Wij zijn altijd op zoek goede mensen en komen graag met je
 in contact.'

h2 '.Steunlijn', 'Overzicht vacatures'
p 'Aantal openstaande vacatures: 0'
p 'Helaas, er staan momenteel geen vacatures gepubliceerd. Kom later nog
 eens terug of gebruik het onderstaande formulier om een open
 sollicitatie in te zenden.'

h2 '.Steunlijn.wbt-form-titel', 'Kom met ons in contact!'
form method: "post", action: '', method: "post"
, enctype: "text/plain", ->

###
  section
    ul
      li
        label(for: 'col1') Voornaam
          span *
        input '.invoer', (id: 'col1', type: 'text', placeholder: 'Voornaam', name: 'col1')
      li
        label(for: 'col2') Achternaam
          span *
        input '.invoer', (id: 'col2', type: 'text', placeholder: 'Achternaam', name: 'col2')
      li
        label(for: 'col9') Straat en huisnr
          span *
        input '.invoer', (id: 'col9', type: 'text', placeholder: 'Straatnaam + huisnummer', name: 'col9')
      li
        label(for: 'col13') Postcode
          span *
        input '.invoer', (id: 'col13', type: 'text', placeholder: 'Postcode', name: 'col13')
      li
        label(for: 'col11') Woonplaats
          span *
        input '.invoer', (id: 'col11', type: 'text', placeholder: 'Woonplaats', name: 'col11')
      li
        label(for: 'email') E-mail
          span *
        input '.invoer', (id: 'email', type: 'email', placeholder: 'jouw@email '.com', ', name: 'email')
      li
        label(for: 'col6') Telefoon
          span *
        input '.invoer', (id: 'col6', type: 'tel', placeholder: '010 123 45 67', name: 'col6')
      li
        span *
          p Verplichte velden


  section
    ul
      li
        textarea(id: 'col20', rows: '7', cols: '24', placeholder: 'Opmerkingen...', name: 'col20')
      li
        input(type: 'radio', name: 'col21', id: 'salaris', value: 'Ik wil meer verdienen')
        label '.radio', (for: 'salaris') Ik wil meer verdienen
      li
        input(type: 'radio', name: 'col21', id: 'uitdaging', value: 'Ik zoek een nieuwe uitdaging')
        label '.radio', (for: 'uitdaging') Ik zoek een nieuwe uitdaging
      li
        input(type: 'radio', name: 'col21', id: 'reisafstand', value: 'Ik wil dichterbij huis werken')
        label '.radio', (for: 'reisafstand') Ik wil dichterbij huis werken
      li
        input(type: 'radio', name: 'col21', id: 'arbeidstijd', value: 'Ik wil minder werken')
        label '.radio', (for: 'arbeidstijd') Ik wil minder werken
      li
        label(for: 'cv') Voeg je CV toe
        #bestand
          input(type: 'text', id: 'upload', placeholder: 'bladeren')
          input(type: 'file', id: 'cv')
      li
        input '.verzenden', (id: 'verzenden', type: "submit", value: 'Verzenden &raquo;')

###