
        # Style applying function. Canonical or idiomatic way of getting
        # named arguments with CoffeeScript - to use a hash map of keys
        applyStyle: ({color, columns, font, head}) ->

            # Default named argument values
            color       ?= 'Groen'

            # Created classes using stylus list comprehension over
            # the amount of semantic grid columns I have defined.
            columns     ?= 'Kolom-3'
            font        ?= 'somefont'
            head        ?= 'somehead'

            # Closure
            "#{color} #{columns}"


        ##
        # Expressies
        #

        urlencode: (str) ->

            str = (str + '').toString()

            # Tilde should be allowed unescaped in future versions, but if you want to reflect current behavior
            #, you would need to add ".replace(/~/g, '%7E');" to the following.
            return encodeURIComponent(str).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').
            replace(/\)/g, '%29').replace(/\*/g, '%2A').replace(/%20/g, '+')

        # Hier worden hulpfuncties gedefinieerd.

        # Schema.org semantische entiteiten


            # Verzamelingen van een bepaalde categorie ophalen
        docCategorie: (gewensteCategorie) ->
            resultaatVerzameling = @getCollection('documents').createChildCollection()
                .setFilter 'category', (model) ->
                    categories = model.get('menuitems')
                    return false  unless Array.isArray(categories)
                    for categorie in categories
                        if gewensteCategorie in [categorie.id, categorie.slug]
                            return true
                        return false
                .query()
            return resultaatVerzameling



    # Verzamelingen
    