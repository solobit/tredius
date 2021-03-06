### cson
voetmenu:       3
layout:         'standaard'
titel:          'Contact'
naam:           'Contactformulier'
kenmerk:        'contactfrm'
tags:           ['formulier','contact','menu']
bannier:        'bg_bruin.gif'

samenvatting:   "Geef uzelf meer de ruimte om te doen waar u goed in
 bent. Bespaar tijd en kosten. Maak nu een afspraak voor een vrijblijvend
 intakegesprek. U maakt dan kennis met uw mogelijk vaste contactpersoon.
 En wij met uw onderneming, plannen, doelen en de aard van uw
 werkzaamheden."
###

h1 '.Tagline',
'Wanneer u dit formulier invult nemen wij direct contact met u op'

form name: 'form_api', method: 'post', action: '', ''

section ->

    ul ->

        li ->
            label for: 'bedrijfsnaam','Bedrijfsnaam'
            span '*'
            input '.valideer', id: 'bedrijfsnaam', type: 'text'
            , placeholder: 'Uw bedrijfsnaam', name: 'col4'
        li ->
            label for: 'contactpersoon','Contactpersoon'
            span '*'
            input '.valideer', id: 'contactpersoon', type: 'text'
            , placeholder: 'Contactpersoon', name: 'contactpersoon'
        li ->
            label for:'adres', 'Straat'
            span '*'
            input '.valideer', id:'adres', type:'text'
            , placeholder:'Straatnaam + huisnummer', name:'col9'
        li ->
            label for:'postcode', 'Postcode'
            span '*'
            input '.valideer', id:'postcode', type:'text'
            , placeholder: 'Postcode', name: 'col13'
        li ->
            label for: 'plaats', 'Vestigingsplaats'
            span '*'
            input '.valideer', id: 'plaats', type: 'text'
            , placeholder: 'Vestigingsplaats', name: 'col11'
        li ->
            label for: 'email', 'E-mail'
            span '*'
            input '.valideer', id: 'email', type: 'email'
            , placeholder: 'E-mailadres', name: 'email'
        li ->
            label for: 'telefoon', 'Telefoon'
            span '*'
            input '.valideer', id: 'telefoon', type: 'tel'
            , placeholder: 'Uw telefoonnummer', name: 'col6'
        li ->
            span '*'
            p 'Verplichte velden'
            span '.bericht'


section ->

    ul ->

        li ->
            textarea id: 'opmerkingen', rows: '7', cols: '24', placeholder: 'Uw opmerkingen...', name: 'col21', ''
        li ->
            input id: 'kennismaking', type: 'radio', name: 'col22', value: 'kennismakingsgesprek', ''
            label '.radio', for: 'kennismaking', 'Ik wil een vrijblijvend kennismakingsgesprek'
        li ->
            input id: 'intake', type: 'radio', name: 'col22', value: 'intakegesprek', ''
            label '.radio', for: 'intake', 'Ik wil meteen een intakegesprek'
        li ->
            input id: 'bellen', type: 'radio', name: 'col22', value: 'gebeld worden', ''
            label '.radio', for: 'bellen', 'Ik wil eerst gebeld worden'
        li ->
            input id: 'aanmelden', type: 'radio', name: 'col22', value: 'aanmelden t-time', ''
            label '.radio', for: 'aanmelden', 'Ik meld mij aan voor T-Time,<br /> de e-mailnieuwsbrief van Tredius'
        li ->
            a '.knop.versturen', id: 'zend_contact', 'Verzenden &raquo;'






