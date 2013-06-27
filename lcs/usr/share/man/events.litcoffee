
## Gebeurtenissen (events)
 
Event handlers in DocPad receive two arguments. The first is `opts`
which is an object filled with properties that the event may provide to
you. The second is `next` which is a completion callback. Both arguments
are **optional**.

Events are fired in a synchronous serial fashion, meaning fire the first
handler, wait for it to finish, fire the next handler, wait for it to
finish, and so on.

Omitting the next callback is perfectly valid and encouraged when you
are writing synchronous code. Synchronous code is code that runs
everything from start to finish in one go. Asynchronous code however is
code that will run a portion at one time, and another portion at another
time. With asynchronous code a completion callback is necessary for us
to know when everything has properly run, or rather when it is okay to
proceed to the next task (or in this case event handler).
 
        events:

Used to add our own custom routes to the server before the docpad routes
are added
 
Bekijken we puur (via `nesh -c`) wat we krijgen als we docpad
initialiseren, dan zien we dat het `_events` (het liggend streepje
simu-/impliceert een private scope) object ons de volgende sleutels geeft.

Een aantal zijn volgens mij echter geen bruikbare `events` in de zin dat
deze niet in de documentatie vermeldt staan. Voor de volledigheid heb ik
deze echter hier nog staan.

* extendTemplateData: ->
* extendCollections: ->
* contextualizeBefore: ->
* contextualizeAfter: ->
* populateCollections: ->
* docpadLoaded: ->
* log: ->

Vervolgens geeft de docpad site ons nog een aantal hints over wat voor
argumenten deze functies mogen verwachten. Ook deze zijn er in verwerkt,
samen met een pakkende, zo volledig mogelijke Nederlandstalige
omschrijving.

### DocPad gereed met laden

Een gebeurtenis gezonden zodra een DocPad exemplaar gemaakt is en de
instellingen daarin geladen zijn. Er is nog geen server gemaakt of
bestanden getransformeerd: de site is nog niet gegenereerd!

#### Functiesleutel

            docpadReady: -> #console.log @docpad

#### Argumentenlijst

* `{docpad}` Een exemplaar van het docpad object

#### Omschrijving

Deze gebeurtenis wordt uitgezonden (door middel van een Node.js
`EventEmitter.emit()` methode) wanneer DocPad gereed is om 'acties' uit
te voeren (dp official docs). Meer specifiek gaat het hier om het maken
van een nieuw exemplaar (een zgn `instance`) van de DocPad structuur
door middel van het aanroepen van de methode `.createInstance()` van de
DocPad module. Vervolgens worden de, onder andere, in dit bestand
opgeslagen **instellingen geladen in het nieuwe exemplaar**. Dit gebeurt
dus iedere keer, wanneer bijvoorbeeld de commandos `docpad generate` of
`docpad run` vanaf de opdrachtregel gegeven worden.

### Opdrachtregel gereed met laden

De gebeurtenis `consoleSetup` wordt uitgezonden op het moment zodra de
interface voor de opdrachtregel (de `CLI` of Command Line Interface)
**daadwerkelijk succesvol geladen** is.

##### Functie en argumenten

De functie voor de gebeurtenis is opgeslagen als de waarde van een
sleutel. Feitelijk betreft het hier een letterlijk `Function` object
gecreeerd door het gebruik van het sleutelwoord `function` in JavaScript
(deze bestaat niet in CoffeeScript, `function() { ... }` is hierin
verkort als `() ->` of zelfs `->` weergegeven).

            consoleSetup: ->

Deze argumenten worden als functie parameters doorgegeven aan de
gebeurtenis, DocPad noemt deze gebundeld `options`.

1. consoleInterface • Een exemplaar van de CLI
1. commander • Een exemplaar van commander.js

Daarnaast wordt aan iedere functie een zgn. closure meegegeven genaamd
`next`, deze gebruikt men om de volgende achtereenvolgende stap te aan
te roepen.

### Voorafgaand aan genereren web site

            generateBefore: ->

### Genereren van site voltooid

            generateAfter: ->

### NOOT CHECK: Verschil tussen genereren en parsen (transformeren) ##

            parseBefore: ->

            parseAfter: ->

            renderBefore: ->

### Transformeren van bestandsextensies

Een van de belangrijkste functies van docpad is het renderen of
transformeren.

#### Functiesleutel

            render: ->

#### Argumentenlijst

* `inExtension` • de extensie waarvandaan we transformeren
* `outExtension` • de extensie waar we naartoe transformeren
* `templateData` • de docpad template gegevens zoals hieronder
* `file` • het model van 'bestand' dat we gebruiken
* `content` • de inhoud van een document (dus zonder meta-gegevens)

#### Omschrijving

Render wordt, in tegenstelling tot het merendeel van de andere
gebeurtenissen, **per document** en **per extensie** uitgezonden. Dit is
om transformaties mogelijk te maken, van het ene bestandstype naar het
andere zeg maar. DocPad is een taalonafhankelijk systeem wat
eenvoudigweg mogelijk maakt om van de ene opmaaktaal naar een andere te
veranderen: van CoffeeScript naar JavaScript, of van Jade naar HTML, het
maakt niet uit (zolang er maar een plugin voor is).

#### Voorbeeld

Een bestand `mijn_document_1` wat dus getransformeerd wordt door
`Coffeecup` om van een `.coffee` bestand een `.html` bestand te maken,
binnen docpad met dubbele extensie gemarkeerd **voor iedere
bestandsextensie** in de naam van dat document (dus voor bijvoorbeeld
`bestand123.html.md.coffee` twee keer) aangeroepen.

            renderDocument: ->

            renderAfter: ->

            writeBefore: ->

            writeAfter: ->

            serverBefore: ->

            serverExtend: ->

            serverAfter: ->

### Render After

Event fired after rendering has taken place. Hiermee halen we alle uiteindelijke
HTML bestanden op die we tegen een remote SEO tool kunnen gebruiken.

            renderAfter: ->

                ###
                docpad = @docpad
                docpad.log 'info', 'Listing all generated page urls'
                documents = docpad.getCollection('html')

                documents.forEach (document) ->

                documentName = document.get('name')
                documentPath = document.get('path')
                ###

                #console.log document.get('outFilename')


Volgende in de wachtrij

                #next()?
