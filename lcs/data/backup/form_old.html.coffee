# resolve fiekd:

# input: hash key of 'field' (input + label)
# with hash of attributes for browser side validation
# augmented with javascript, wia-aria, and semantic tags

# we must allow for synoniems or translations
# of field

# Often the name is used by a API and cannot always be changed
# Also, we need to have defaults somewhere. If we use a lot of forms
# on our site, this makes sense
# ((todo)) extract out, abstraction of config settings


###
someHashObj = {
    keyFieldName:
    Note you can use spaces like 'Last known address'
    You should really rename this to your localization imho
    Or we can work with synonyms

        synonym:    This will be a list of other keys to trigger results upon
        apiname:    Often api's for mail forms require input tag names to match
        numchar:    Amount of characters in the input field (browser side)
        pattern:    HTML5 API browser-side validation regex
        default:    Value of the field (may be reset using HTML)
        example:    The placehold value or reassign if you like
        respond:    The title field composed of truthy/falsey statements
        istruth:    Affirmative form in any language since this may vary in structure
        isfalse:    So we can also deny our forms or statements

        # events
        oninput:    While typing input trigger this js
        invalid:    When invalid trigger this
}

###

### TODO abstract away to a function in docpad.coffee
# check for product in document instance, if exists
groen = 'green'
styler = @.stylus
styler.render """
.myself
  color #{groen}
""", (err, css) -> 
###


formulier = @.document.meta.formulier

getField: (field) ->

    hash = {
        achternaam:
            apiname:    'col2'
            numchar:    24
            pattern:    '[a-zA-Z]{3,23}'
            default:    ''
            example:    "Uw #{field}"
            synonym:    ['lastname', 'last name', 'surname' , 'family name', 'naam' ]
            respond:    "Uw #{field} bestaat #{isfalse} uit alleen maar letters."
            istruth:    ""
            isfalse:    "niet"
            oninput:    ->
            invalid:    ->
        bedrijfsnaam:
            numchar:    24
            pattern:    '[a-zA-Z]{3,23}'
            default:    ''
            apiname:   'col4'
            example:    "Uw #{field}"
            synonym:    ['business', 'company name', 'company' , 'bedrijf', 'organisatie' ]
            respond:    "Uw #{field} bestaat #{isfalse} uit alleen maar letters."
            istruth:    ""
            isfalse:    "niet"
            oninput:    ->
            invalid:    ->
        telefoon:
            numchar:    13
            pattern:    '\d{10,13}'
            default:    ''
            apiname:   'col'
            example:    "0123456789"
            synonym:    ['phone', 'phone number', 'home phone', 'phone business hours', 'telefoon nummer', 'tel']
            respond:    "Uw #{field}nummer bestaat #{istruth} uit #{isfalse} 10 tot 13 cijfers"
            istruth:    "exact"
            isfalse:    "niet"
            oninput:    ->
            invalid:    ->
        mobiel:
            numchar:    13
            pattern:    '\d{10,13}'
            default:    ''
            apiname:   'col'
            example:    "Uw #{field} nummer"
            synonym:    ['cell-phone', 'mobile', 'cellular phone', 'mobile phone', 'mobile number', 'gsm', 'mobiele telefoon', 'mobiel nummer']
            respond:    "Uw #{field}nummer bestaat #{isfalse} uit #{istruth} 10 tot 13 cijfers"
            istruth:    "exact"
            isfalse:    "niet"
            oninput:    ->
            invalid:    ->
        email:
            apiname:   'Email'
            numchar:    25
            pattern:    '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'
            default:    ''
            synonym:    ['e-mail', 'mail address', 'mail', 'e-mailadres', 'email address', 'mailadres', 'email adres']
            example:    "voorbeeld@email.nl"
            respond:    "Uw #{field} #{isfalse} uit #{istruth} de juiste tekens"
            istruth:    "een reeks van geheel"
            isfalse:    "bestaat niet"
            oninput:    ->
            invalid:    ->
        postcode:
            apiname:   'col13'
            numchar:    8
            pattern:    ''
            default:    ''
            synonym:    ['post-code', 'post code', 'postal code', 'post number', 'postnummer', 'postadres']
            example:    '1234 AB'
            respond:    "Uw #{field} #{isfalse} #{istruth} de juiste tekens"
            istruth:    ""
            isfalse:    "bestaat niet uit"
            oninput:    ->
            invalid:    ->
        woonplaats:
            apiname:   'col11'
            numchar:    30
            pattern:    '[a-zA-Z]+'
            default:    ''
            synonym:    ['vestigingsplaats', 'plaats', 'stad', 'city', 'municipality']
            example:    "Uw #{field}"
            respond:    "Uw #{field} #{isfalse} #{istruth} uit 30 tekens van A tot Z."
            istruth:    "bestaat geheel"
            isfalse:    "bestaat niet"
            oninput:    ->
            invalid:    ->
        straat:
            apiname:   'col9'
            numchar:    30
            pattern:    '[a-zA-Z]+'
            default:    ''
            synonym:    ['address', 'straat', 'adres']
            example:    ''
            respond:    "Uw #{field} #{isfalse} #{istruth} de juiste tekens"
            istruth:    ""
            isfalse:    "bestaat niet uit"
            oninput:    ->
            invalid:    ->
    }

    console.log key for key in hash


    #return hash[veld]

@getField('achternaam')

# Build-time

# Let op! Gebruik van 'fat arrow'
# voor bewaren van de context
printRij = (veld) =>

    li '.FormulierRij', ->

        switch veld

            when "achternaam" or "bedrijfsnaam"

                label for:      veld            ,
                                veld
                input id:       veld
                , name:         ''
                , type:         'text'
                , size:         '23'
                , oninput:      ''
                , placeholder:  "Uw #{veld}?"
                , pattern:      "[a-zA-Z]{3,23}"
                , title:        "Uw #{veld} mag alleen uit letters bestaan."
                , oninvalid:    "this.setCustomValidity('Ongeldige #{veld}!')"
                , required:      'required'
                , 'aria-required': 'true'

            when "telefoon"

                label for:      veld            ,
                                veld
                input id:       veld
                , name:         ''
                , size:         '20'
                , type:         'tel'
                , pattern:      "\d{10,13}"
                , oninput:      'javascript:function() {};'
                , placeholder:  '010 123 45 67'
                , title:        "Uw telefoonnummer bestaat uit 10 tot 13 cijfers, 
                                 bijvoorbeeld 012345679"
                , oninvalid:    "this.setCustomValidity('Ongeldig telefoonnummer!')"
                , required:     'required'
                , 'aria-required': 'true'

            when "email"

                label(for: veld, veld)
                input id:  veld, type: veld
                , name:         'Email'
                , size:         '20'
                , placeholder:  'uw.naam@email.com'
                , pattern:      "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}"
                , oninput:      'javascript:function() {};'
                , title:        "Geef hier een geldig e-mailadres op."
                , oninvalid:    "this.setCustomValidity('Ongeldig e-mailadres!')"
                , required:     'required'
                , 'aria-required': 'true'

            ## ## FIX ## ##

            when "adres"

                label for:      veld ,
                                veld
                input id:       veld
                , name:         ''
                , size:         '30'
                , type:         'text'
                , placeholder:  'Uw straat + huisnr'
                , pattern:      "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}"
                , oninput:      'javascript:function() {};'
                , oninvalid:    "this.setCustomValidity('Ongeldig #{veld}!')"
                , title:        "Uw woonplaats bestaat uit alleen letters."
                , required:     'required'
                , 'aria-required': 'true'

            when "postcode"

                label for:      veld ,
                                veld
                input id:       veld
                , name:         ''
                , size:         '8'
                , type:         'text'
                , oninput:      'javascript:function() {};'
                , oninvalid:    "this.setCustomValidity('Ongeldige postcode!')"
                , placeholder:  '1234 AB'
                , pattern:      "[0-9]{4}[A-Z]{2}"
                , title:        "Uw postcode bestaat uit 4 cijfers en 2 letters."
                , required:     'required'
                , 'aria-required': 'true'

            when "woonplaats" or "vestigingsplaats"

                input id:       veld
                , name:         ''
                , size:         '30'
                , type:         'text'
                , placeholder:  'Woonplaats'
                , pattern:      "[a-zA-Z]+"
                , oninput:      'javascript:function() {};'
                , oninvalid:    "this.setCustomValidity('Ongeldige #{veld}!')"
                , title:        "Uw #{veld} bestaat uit alleen letters."
                , required:     'required'
                , 'aria-required': 'true'

            when "bevestigen"

                input type: 'checkbox'
                , checked:  'checked'
                , id:       'akkoord'
                , name:     'col21'

                label       '.FormulierVoorwaarden'
                , for:      'akkoord'
                , "Ja, ik ga akkoord met de <a href=/overige/voorwaarden.html>voorwaarden</a> van Tredius"

            when "knoppen"

                for knop in formulier.buttons

                    switch knop

                        when "verzenden"
                            input       '.Formulier-knop'
                            , type:     'submit'
                            , value:    'Verzenden »'

                        when "wissen"
                            input       '.Formulier-knop'
                            , type:     'reset'
                            , value:    'Annuleren ✘'

# Ook hier context nodig voor velden
encoding = () =>

    if (formulier.fields.indexOf('bestand') != -1)
        return 'multipart/form-data'
    else
        return 'application/x-www-form-urlencoded'

# Browser-side
#coffeescript ->

    #$.domReady () ->



# FORMULIER
#

form id:   formulier.id
, class:   'FormulierElement ' + formulier.classes
, action:  formulier.uri
, name:    formulier.name
, method:  formulier.method
, enctype:  encoding()
, lang:     'nl', ->

    # Titeltekst boven het formulier
    h3 '.FormulierElement-titel', formulier.title

    # Velden afdrukken als lijst met rijen
    ul '.FormulierLijst', -> printRij(veld) for veld in formulier.fields



