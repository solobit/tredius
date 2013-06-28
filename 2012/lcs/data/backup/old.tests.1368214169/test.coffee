
class Ancestor
    constructor: (arguments) -> console.log "Powerrrrr"
    

# Public: ClassName

class ClassName extends Ancestor
        
    # {.constructor}
    constructor: (args) -> console.log args







# {Delegates to: .delegatedRegular}
delegatedMethod: ->

# Public: I'm being delegated to!
#
# a - A {Number}
# b - A {String}
#
# Returns a {Boolean}
delegatedRegular: (a, b) ->

# Private: {Delegates to: Another.Class@somewhere}
delegatedMethod: ->


