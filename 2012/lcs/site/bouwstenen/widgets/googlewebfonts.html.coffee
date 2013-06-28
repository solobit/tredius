

# Early webfont loader library ( more control over font loading than the Google Fonts API provides) + also lets you use multiple web-font providers
script src: "//ajax.googleapis.com/ajax/libs/webfont/1/webfont.js"

coffeescript ->

    log = (args...) -> console.log args...

    # Define our fonts
    webFontCfg =

        google:

            families: ['Dosis:400,500,600', 'Open Sans:400italic,600italic,700italic,400,600,700']

        ###
        typekit:
            id: 'myKitId'

        ascender:
            key: 'myAscenderKey',
            families: [ 'AscenderSans:bold,bolditalic,italic,regular' ]

        monotype:
            projectId: 'YourProjectId'

        custom:
            families: ['OneFont', 'AnotherFont']
            urls: [ 'http://myotherwebfontprovider.com/stylesheet1.css',
                    'http://yetanotherwebfontprovider.com/stylesheet2.css' ]
        ###

        loading: () -> log "loading Google webfonts: #{@google.families}"

        fontloading: (fontFamily, fontDescription) -> log "In progress of loading '#{fontFamily}: #{fontDescription}"

        fontactive: (fontFamily, fontDescription) -> log "Active '#{fontFamily}: #{fontDescription}"

        fontinactive: (fontFamily, fontDescription) -> log "Inactivate '#{fontFamily}: #{fontDescription}"

        active: () -> log "All fonts downloaded and active"

        inactive: () -> log "Fonts are inactive"

    # Start loading
    WebFont.load webFontCfg

### Specialized webfont loader styles for during loading, active or inactive states
stylus '''

    // Paragraphs
    .wf-loading p
        font-family: sans-serif
    .wf-inactive p
        font-family: sans-serif
    .wf-active p
        font-family: 'Open Sans', sans-serif

    // Menubalk en nieuwsbrief
    .wf-loading
        & ul.NavigatieBalk > li > a
            font-family: sans-serif
            font-size: 18px
        & .PaginaBand-grijs section aside h3
            font-family: sans-serif
            font-size: 24px
    .wf-inactive
        & ul.NavigatieBalk > li > a
            font-family: sans-serif
            font-size: 18px
        & .PaginaBand-grijs section aside h3
            font-family: sans-serif
            font-size: 24px
    .wf-active
        & ul.NavigatieBalk > li > a
            font-family: Dosis
            font-size: 18px
        & .PaginaBand-grijs section aside h3
            font-family: Dosis
            font-size: 24px

    // Titel
    .wf-loading h1
        font-family: sans-serif
        font-size: 30px
    .wf-inactive h1
        font-family: sans-serif
        font-size: 30px
    .wf-active h1
        font-family: 'Open Sans', sans-serif
        font-size: 30px
'''
###