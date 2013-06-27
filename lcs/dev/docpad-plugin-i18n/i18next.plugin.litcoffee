
# Plugin: Internationalization

    module.exports = (BasePlugin) ->

This setups my basic plugin, it extends from BasePlugin and hooks into the
renderBefore event, a full listing of all events in docpad is available [here][02].

        balUtil         = require 'bal-util'

        i18n            = require 'i18next'
        fs              = require 'fs'

        FILE_NLWP1_MO   = "continents-cities-nl_NL.mo"
        PATH_LANGS      = "../locales/languages/"
        log             = console.log

Define Plugin

Derived class from the super-type `BasePlugin`.

        class i18Plugin extends BasePlugin

            name: 'i18next-plugin'

            config: 
                preload:        ['nl-NL']
                lng:            'nl-NL'
                fallbackLng:    false #'en'
                load:           'current'
                detectLngQS:    'taal' 
                useCookie:      true
                debug:          true
                keyseparator:   '::'
                nsseparator:    ':::'
                resGetPath:     '../locales/__lng__/__ns__.json'
                ns:
                    #namespaces: ['app', 'buttons']
                    namespaces:     ['app']
                    defaultNs:      'app'


            renderBefore: (opts,next) ->

                docpad = @docpad

The renderBefore event receives two values in its opts argument, the collection
and the templateData. The collection is the collection of documents that we are
rendering, and the templateData is the data object that is passed to the
documents when rendering. Note we also require the bal-util module which we'll
use later on.

                {collection,templateData} = opts

Now we need to loop over our documents and figure out how / if they need translating

                pagesToRender = new docpad.FilesCollection()


So far so good. We have followed the well established pattern for this type of
plugins, exactly as described [here][01]




[01]: <https://github.com/benjamind/delarre.docpad/blob/master/src/documents/posts/creating-a-docpad-plugin.html.md>
[02]: <http://bevry.me/docpad/events>