
Top most inner level (scope) of this document / web site. Either we run inside
terminal, or we are being processed by meta-program or we run inside browser,
or desktop environment, clojure what not: this column 0 is markdown and column
4 starts coffee

    log = console.log
    root = exports ? this

Unique identifiers for (exemplaar) types, here a type of Collection, is defined
inside the constructors

    class Collection

        constructor: (@id = new Date().getSeconds()
                    , @created = @id) ->


    class Bookshelf extends Collection
        constructor: (@collection = []) ->

        this.fill: (books) -> 


    class Book


Constructional methods (constructor, destructor, garbage collectors, fallback,
compatibility checks, sanity checks, error checking)

        constructor: (@name, args...) ->

Static properties, static properties are easily defined as the `this` keyword
refers to it, instead of the instance `@`.

        this.name = (name) ->
        this.find = (name) ->
        this.kind = (book) ->
        this.copy = (book) ->
        this.grab = (book) ->




Feed a class instance identifier name first, then hash object @info with some
patterns in it for fun

    class Customer
        instance = null
        constructor: (@name , @info = {

            site: "(http|s)?#{@name}.nl"

            type: "#{typeof @}"

            mail: "(info)@#{@name}"
            }

        ) ->
            console.log @info

Doesnt work

        @name: -> "Nieuwe klant" unless Customer.name?

    class Project
        description: "Some description"

    class privateCoffeebook
        constructor: (@message) ->
        echo: -> @message

    class CoffeeBook

        instance = null
        constructor: () ->

        documentation: {
            types: ['reference', 'manual', 'guide', 'service manual', 'api']
        }

        @get: (message) -> instance ?= new protectedCoffeeBook(message)




    document = {
        instance: this
        type: 'Obligatory; First use;'
        file: ['README', '.md']
        getFile: do -> console.log 'abc'

    }

    locale = (str) -> console.log str
    title = (strInter) -> console.log strInter

    customer = new Customer("Tredius")

    locHash =
        _lang: "[english][en] | [dutch][nl]"
        lang: process.env.LANG


    locale locHash.lang

    title "#{customer.name} :: #{Project.description}"

    #subtitle "#{readme.purpose}"

