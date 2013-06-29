
# Internationalization library for JavaScript and Node.JavaScript
Als voorbeeld overgebleven

        collections:

            pages: -> @getCollection('documents').findAllLive({pageOrder:$exists:true},[pageOrder:1])

        }

So what we do is to have a special internationalize st


    i18n    = require 'i18next'
    fs      = require 'fs'

    FILE_NLWP1_MO = "continents-cities-nl_NL.mo"
    PATH_LANGS = "../locales/languages/"
    log = console.log

    config = 
        preload:        ['nl-NL']
        lng:            'nl-NL'
        fallbackLng:    false #'en'
        load:           'current'
        detectLngQS:    'taal' 
        useCookie:      true
        debug:          true
        keyseparator: '::'
        nsseparator: ':::'
        resGetPath:     '../locales/__lng__/__ns__.json'
        ns:
            #namespaces: ['app', 'buttons']
            namespaces: ['app']
            defaultNs: 'app'


    i18n.init config, (t) ->
        x = t("company::name")
        log x



    ###
    Gettext = require("node-gettext")
    gt = new Gettext()
    fileContents = fs.readFileSync("#{PATH_LANGS}/#{FILE_NLWP1_MO}")
    gt.addTextdomain(FILE_NLWP1_MO, fileContents)
    log gt.textdomain("#{PATH_LANGS}/#{FILE_NLWP1_MO}")
    greeting = gt.dgettext("nl", "Hello!")
    log greeting
    
    # access default namespace
    x = t("any.key.from.app")
 
    to access another namespace prepend [ns]
    y = t("buttons:any.key.from.buttons")
    ###
