
cc = require 'coffeecup'

tpl = ->

    div '.test', ->
        ul ->
            li -> 'hhehehe'



helpers =

    fields: [
        'achternaam'
        'voornaam'
        'email'
        'telefoonnummer'
        'woonplaats'
        'postcode'
    ],
    achternaam: {
        required:   true
        length:     20
        },
    postcode: {
        pattern: "[0-9]{4}[A-Z]{2}"
    }



#cc.render tpl, title: 'contact', hardcode: helpers