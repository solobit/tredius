

## Bronnen en referenties

De volgende bronnen zijn handig voor gebruik van dit soort bestanden.

* API: <https://npmjs.org/doc/json.html>
* Web based generator: <http://jspkg.com/generator>
* Interactief voorbeeld: <http://package.json.nodejitsu.com/>
* Zeer compleet voorbeeld: <http://registry.npmjs.org/npm/latest>

Voor meer informatie, raadpleeg Google en zoek op `node.js package.json`
of een specifiek probleem.


## Projectdefinitie

We beginnen met de definitie van ons project in dit document.

    projectDefinitie =
   
Deze worden hiermee overal gebruikt. Dus niet alleen door Node.js

        name:               "tredius-corporate"

        version:            "0.0.5"

        description:        "Tredius corporate web site"

        main:               "docpad.coffee"

Met het veld `private` voorkom je dat dit project gepubliceerd wordt in
het openbare register van downloadbare software.

        private:            true

Prefer global houdt in dat dit pakketje niet in het systeem-breedde
register opgenomen hoeft te worden; het is alleen voor dit project.

        preferGlobal:       false


### Dependencies

Een belangrijk onderdeel van software is het zgn. dependency-management:
hier staan onze plugins vermeld.

        dependencies:

Onze supervette generator en transformator.

            docpad:                       "6.x"

Hiermee laden we eenvoudig objecten die vaker gebruikt worden in de
chache van de client browser.

            "docpad-plugin-cachr":        "2.x"

Dit pakketje zorgt voor de mogelijkheid CoffeeScript notatie te
gebruiken om HTML te genereren.

            "docpad-plugin-coffeekup":    "2.x"

Uiteraard hebben we daarvoor CoffeeScript zelf nodig dus deze is, als
taal, ook toegevoegd.

            "docpad-plugin-coffeescript": "2.x"

Makkelijker is om, voor de notatie van serializable objecten ook een
soort verkorte notatie te gebruiken: daarom is CSON een CoffeeScript
equivalent van JSON (en NPM/Bower/etc werkt alleen met JSON).

            "docpad-plugin-cson":         "2.x"

Voor paginas die dominant zijn in tekstuele weergave hebben we een zeer
leesbare notatie, dit is Markdown en de marked plugin verzorgt deze in
docpad.

            "docpad-plugin-marked":       "2.x"

Partials zijn herbruikbare componenten, onder andere gebruikt als
widgets hier.

            "docpad-plugin-partials":     "2.x"

Dit doet ...

            "docpad-plugin-services":     "2.x"


De stijl en vormgeving van webpagina's wordt altijd in CSS gedaan.
Stylus is een krachtige, verkorte notatie en deze ondersteunt
JavaScript/eigen functies om deze nog verder te versterken.

            "docpad-plugin-stylus":       "2.x"

#### Verwijderde plugins

* "docpad-plugin-cleanurls": "2.x" ; Reden :: redirections
* "docpad-plugin-eco": "2.x" ; Reden :: niet gebruikt
* "docpad-plugin-text": "2.x" ; Reden :: niet gebruikt

Development packages are defined in the next part:

        devDependencies:

            ender: "1.0.1"

            URIjs: "~1.10.2"

            chai: "1.6.x"

            mocha: "1.9.x"

            docco: "0.6.x"

            biscotto: "*"

> NOOT: dit is continue aan verandering onderheving

#### Verwijderde development packages

* pdfkit: "~0.1.9"
* domready: "~0.2.11"
* "docpad-plugin-eco": "2.x"

Deze hebben het niet gehaald.


### Scripts

De volgende scripts worden gebruikt:

        scripts:

            test: "echo Fout! Geen test script gedefineerd. && exit 1"

            start: "echo Fout! Geen start script gedefineerd. && exit 1"

Opslag van gegevens in een `repository`.

        repository:

            type:   "git"

            url:    "git@github.com/solobit/customers.git"

Auteursgegevens en licenties.

        author:         "Solobit"
        
        license:        "MIT"

        readmeFilename: "README.md"

        gitHead:        "185909b228cc42fa2e409a49dc1e6587dd3adf4a"

<!--o-->
 The CommonJS Packages spec details a few ways that you can indicate the
 structure of your package using a directories hash. If you look at npm's
 package.json, you'll see that it has directories for doc, lib, and man. 

 In the future, this information may be used in other creative ways.

        directories:

            bin:        "bin"

            lib:        "lib"
            
            doc:        "extra/documentatie"
            
            man:        "extra/handleiding"
            
            example:    "extra/voorbeelden"


        keywords: [ "accountancy", "belastingen", "pensioen", "adviseurs"
                    , "detachering", "loonadminstratie", "juridische"
                    , "diensten" ]


Schrijf nu het JSON bestand nadat we akkoord hebben gegegeven:

    objJSON = CSON.parseSync(CSON.stringifySync projectDefinitie)

    projectJSONString = CSON.stringifySync projectDefinitie

    log objJSON

    rl = readline.createInterface
        input:  process.stdin
        output: process.stdout

    rl.question locale.proceedYN, (answer) ->


> TODO: refactor; naive implementation


        if answer is "J"

            fs.writeFile "./package.json", JSON.stringify(objJSON), (err, cb) ->

                log locale.fileWritten
        else
            return

        rl.close()




