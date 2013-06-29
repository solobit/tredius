


coffeescript ->

    m = new Menu document.querySelector "#arc", radius: 230

    app = document.querySelector "#app"

    if app.ontouchmove isnt `undefined`
        app.addEventListener "touchmove", ->
            m.close

    else
        app.addEventListener "scroll", ->
            m.close


nav '#arc', ->

    a href: "#", ->

    ul ->
        li -> a href: '#', "☽"
        li -> a href: '#', "☀"
        li -> a href: '#', "✈"
        li -> a href: '#', "★"
        li -> a href: '#', "♥"
        li -> a href: '#', "☺"
