---
metadata: 'test'

---




# Variabelen

    path = "/media/afbeeldingen"
    imageList = """
        #{path}/bg_accountancy.jpg
        #{path}/bg_belastingadvies.jpg
        #{path}/bg_blauw.gif
        #{path}/bg_bruin.gif
        #{path}/bg_juristen.jpg
        #{path}/bg_pensioen.jpg
        #{path}/bg_quote.png
        #{path}/bg_tech.jpg
        #{path}/bg_ttime.jpg
        #{path}/bg_ttime_vervaagd.jpg
        """.replace(/\s+/g, " ").split(' ')
    console.log imageList


# Preload.js achtergrondafbeeldingen

Het grote formaat van de afbeeldingen op de site kan er wel eens voor
zorgen dat deze sprongsgewijs (schokkerig) doet overkomen. Dit is omdat
deze dan nog niet gebufferd in de browser is. Met name het eerste bezoek
(maar ook na updates) kan men hier last van hebben. Dit is een
JavaScript oplossing waar we in het begin van de DOM deze injecteren en
alles al parallel gaan downloaden/inladen. Dit is momenteel standaard
ingeschakeld waardoor wellicht de eerste pagina iets langzamer is.

    queue = new createjs.LoadQueue true

    queue.addEventListener 'fileload', (obj) ->


Interpolate het resultaat naar de browser of machine console output.
Zo zien we altijd de status bijgewerkt.

        console.log """
        Client-side Browser JavaScript:
        * preload.js file #{obj.result} loading."""

Gebeurtenis voor het laden gereed aanhaken en uitluisteren. Stuur een
bericht ook naar de console indien gereed.

    queue.addEventListener 'complete', -> 
        console.log 'preload.js file downloading complete'


Lijst met afbeeldingen (of videos, of muziek) invoeren. Vervolgens de
wachtrij met resources inladen.

    queue.loadManifest imageList

    queue.load()

Indien gereed deze handler afvuren die momenteel niets doet.

    handleComplete = -> 
        return

    #image = queue.getResult("myImage")
    #document.body.appendChild(image)