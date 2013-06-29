cc = require 'coffeecup'
helpers = require 'coffeecup-helpers'

log = (args...) -> console.log args...

defaultFields = (opts = {}) ->

    a = [
        name:           "Achternaam"
        type:           'text'
        pattern:        "[A-Z]{19}"
        placeholder:    'Jansen'
        required:       'true'
        title:          'U dient deze correct in te vullen'
       ,
        name:           "Voornaam"
        type:           'text'
        pattern:        "[A-Z]{9}"
        placeholder:    'Rob'
        required:       'true'
        title:          'U dient deze correct in te vullen'
       ,
        name:           "Tussenvoegsel"
        type:           'text'
        pattern:        "[A-Z]{9}"
        placeholder:    'abcde'
        required:       'false'
        title:          'U dient deze correct in te vullen'
       ,
        name:           "Familienaam"
        type:           'text'
        pattern:        "[A-Z]{29}"
        placeholder:    'abcde'
        required:       'true'
        title:          'U dient deze correct in te vullen'
       ,
        name:           "Postcode"
        type:           'text'
        pattern:        "[0-9]{4}[A-Z]{2}" ,
        placeholder:    'abcde'
        required:       'true'
        title:          'U dient deze correct in te vullen'

    ].map (field) ->
        log field.name if field.required is 'false'
        (attr) -> attr[field]

cool = [the = 0, man = 2]
log cool

    #for field in a then for key, value of field when key is nm then log key + ' : ' + value

defaultFields('pattern')

template = ->
    form ->
        li ->
            textField 'Achternaam', class: 'small', input: { pattern: "[A-Z]{9}" }

console.log cc.render template, hardcode: helpers


###
then log ("#{key} = #{value}") for key, value of field
###