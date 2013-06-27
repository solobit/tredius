
# Browser client-side JavaScript

    head ->

        log = console.log

Gebeurtenissen aanhaken met generieke functie

        addEvent = (element, eventName, callback) ->

            if element.addEventListener
                element.addEventListener eventName, callback, false
            else
                element.attachEvent eventName, callback, false

# `ready` (functie)

Specifieke spelers worden met deze methode aangehaakt. Als argument
accepteerd de functie (variabele) de waarde van het identificatie
attribuut van de speler `iframe`.

        ready = (player_id) ->

## Gebeurtenissen

We defineren een aantal gebeurtenissen, zoals bij afspelen `onPlay` en
`onFinish` bij eindigen. Deze zgn. `event handlers` of gebeurtenis
afhandelaren (lame translation) worden weer aan de Vimeo JS API
froogaloop script vastgezet. Het enige wat zij doen is de gebeurtenis
functies registreren en zodra het moment daar is, worden ze afgevuurd
(dat is dus nog niet zo).

            onPlay   = () ->
                froogaloop.addEvent "play", (data) ->
                    log "vimeo: afspelen"

            onFinish = () ->
                froogaloop.addEvent "finish", (data) ->
                    log "vimeo: stoppen"

Geef het bericht dat we gereed zijn (op de console).

            log "vimeo: gereed!"

Stel variabele naam `froogaloop` in (definitie/declaratie) en stel deze
waarde in op een functie `$f` met als argument de player id. Registreer
de gebeurtenissen `afspelen` en `eindigen`.

            froogaloop = $f(player_id)

            onPlay()
            onFinish()

Twee stuks embedded spelers in voet helaas nog wel met een identifier
vanwege de API van Vimeo.

> TODO inladen Ids dynamisch per pagina in principe.

            player1 = $("#VideoSpeler-55429476")[0]
            player2 = $("#VideoSpeler-55430952")[0]

De functie `$f` is een `jQuery` function keyword shortcut

            $f(player1).addEvent "ready", ready
            $f(player2).addEvent "ready", ready
