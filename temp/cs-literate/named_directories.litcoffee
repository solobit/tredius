
# Suggestion: `named_directories` 001

While working on a customer web site, which I made in Docpad, I also got
permission to play around a bit with the code/features of the web site.
As such I have also been experimenting with docpad to try and get a
better feel for some plugins I'd like (to develop) and how to abstract
certain concepts.

As a mechanism - and of course for comfort, since I have local native
Dutch clients - I have been writing as much as I could in native Dutch.
CSS/HTML class names, identifiers, docpad meta-data, docpad config and
so forth. This has allowed me somewhat a better view on how we could
possibly expand on i18n in a step-by-step approach (red: localization,
internationalization, languages).

Much in docpad/coffeescript already facilitates localization of code,
e.g. in the naming of variables and such. Although docpad (and more or
less defacto the internet) has English as a language, obviously, I
didn't rename those inside the scope of docpad (and all its submodules)
but about everything else was renamed to a proper translation in Dutch.

Quite a few possible future plugins I've implemented as a 'widget' (no,
there really isnt a proper dutch word for that) which is nothing more
than a designated folder under the partials directory (renamed to
'bouwstenen' aka buildingblocks). This simple idea allows for some quick
and easy draft write-ups that are readily used as partials throughout
the site. Some examples are: a lazy form generator, product details and
business-cards or local business directions and google maps.

The current `docpad.litcoffee` file that I have (manually unmangled
every time it is updated to get a `.js` or `.coffee` file) has those
keys that are available by docpad localized:

    exConf =

        srcPath:        'site'
        outPath:        'uitvoer'

Note that `node_modules` is kept (for now) in the root directory to
locate plugins, as I still frequently `npm install` stuff. Those can be
moved into `modules/node_modules` or even a `modules/node` lateron.

        pluginsPaths:   ['node_modules', 'modules/node_modules', 'modules/plugins']

Also, I kept the original names (for now) in these arrays to provide
some backwards compatibility earlier on, these are currently obsolete
though.

        documentsPaths: ['documents', 'documenten']
        filesPaths:     ['files', 'public', 'bestanden']
        layoutsPaths:   ['layouts', 'sjablonen']

This did make me think a bit more on the subject and seperation of
concerns and localization. These **localized path names** should really
be inside the language definition of docpad and then made available
through a boolean flag for translation of the path names into localized
path names.

        isLocalizedPaths: true
        language: 'nl'

This might allow for something along the lines of:

    # Very crude and naive language example structure
    languages =
        short:
            srcPath: 'src'
            outPath: 'out'
        en_GB:
            srcPath: 'sources'
            outPath: 'public_html'
        en_US: -> "".replace '*our', '/1/or'
        nl:
            srcPath: 'bronmap'
            outPath: 'uitvoer'

And some arbitrary logic to load it, obviously naive.

    if not exConf[isLocalizedPaths] then languages[exConf.language] else languages.short

The defaults are actually really needed to prevent 'breaking' old sites
(backwards compatible) and they should be set to the defaults as they
are now: src, out, documents, files etc.


