

## Dependencies

    fs      = require 'fs'
    winston = require 'winston'
    CSON    = require 'cson'


    cObj = {

## The package definition file

### Package management in Node.js

The most important things in your package.json are the `name` and `version`
fields. Those are actually required, and your package won't install
without them. The name and version together form an identifier that is
assumed to be completely unique. Changes to the package should come
along with changes to the version.

The name is what your thing is called. Some tips:

* Don't put `js` or `node` in the name. It's assumed that it's js, since
  you're writing a package.json file, and you can specify the engine
  using the "engines" field. (See below.)
* The name ends up being part of a URL, an argument on the command line,
  and a folder name. Any name with non-url-safe characters will be
  rejected. Also, it can't start with a dot or an underscore.
* The name will probably be passed as an argument to require(), so it
  should be something short, but also reasonably descriptive.
* You may want to check the npm registry to see if there's something by
  that name already, before you get too attached to it.
  http://registry.npmjs.org/

*The unique name of your package:* this will also indicate the name of
the package in the NPM global repository ( if you choose to publish it).

        name:           'buildr'

*Flag that indicates this package prefers to be installed globally:*
this is usually reserved for packages that contain command line
interfaces ( CLIs ). In most situations, you will **NOT** use this property.

        preferGlobal:   false

*Version of the package as specified by [Semantic Versioning][semver]:*
it is important to keep track of your package versions in a sufficiently
[smart way][depjitsu]. If you don't follow standard versioning
techniques, it will be difficult for users to keep track of your
packages. Consider the following version updates: 
* 0.1.0 -> 0.1.1 should be non-breaking.
* 0.1.1 -> 0.2.0 could be breaking.

        version:        fs.readFileSync 'version', 'utf8'

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam cursus. Morbi ut
mi. Nullam enim leo, egestas id, condimentum at, laoreet mattis, massa.

        date:           new Date

### Defaults

The npm program will default some values based on package contents, for
example the scripts field:

        scripts:

> NOTE: Some of these may actually be regarded as anti-patterns

If there is a server.js file in the root of your package, then npm will
default the start command to node server.js.

            #start:                  'node server.js'

If there is a wscript file in the root of your package, npm will default
the preinstall command to compile using [node-waf/gyp (newer)][wafgyp].

            #preinstall:             "node-waf clean || true; node-waf configure build"

            prepublish:             'cake clean build'

If there is a binding.gyp file in the root of your package, npm will
default the preinstall command to compile using node-gyp.

            #preinstall:             'node-gyp rebuild'



        homepage:       'https://github.com/balupton/buildr.npm'

        bugs:
            web:        'https://github.com/balupton/buildr.npm/issues'

        licenses: [
            type:       'MIT'
            url:        'http://creativecommons.org/licenses/MIT/'
        ]


        repository:
            type:       'git'
            url:        'http://github.com/balupton/buildr.npm.git'


        description:    "
            The (Java|Coffee)Script and (CSS|Less)
            (Builder|Bundler|Packer|Minifier|Merger|Checker)
        ".replace(/\s+/g, " ").trim()
        
        keywords:       [ 'javascript', 'coffee', 'lesscss', 'less',
                          'css', 'builder', 'package', 'compile',
                          'compress', 'minify', 'bundle', 'merge',
                          'lint' ]
        
        author:         
            name:       'Benjamin Lupton'
            email:      'b@lupton.cc'
            web:        'http://balupton.com'

        maintainers: [
        
            name:       'Benjamin Lupton'
            email:      'b@lupton.cc'
            web:        'http://balupton.com'
        ,
            name:       'Brandon Ramirez'
            email:      'brandon.s.ramirez@gmail.com'
            web:        'http://www.brandonsramirez.com/'
        ]

***project contributors:*** if there is an `AUTHORS` file in the root of
your package, npm will treat each line as a `Name <email> (url)` format
such as demonstrated below, where *email and url are optional*. Lines
which start with a `#` or are a `blank line, will be ignored`.

        contributors: [
            name:       'Benjamin Lupton'
            email:      'b@lupton.cc'
            web:        'http://balupton.com'
        ,
            name:       'Brandon Ramirez'
            email:      'brandon.s.ramirez@gmail.com'
            web:        'http://www.brandonsramirez.com/'
        ,
            name:       'Rob Jentzema'
            email:      'rob.jentzema@gmail.com'
            web:        'https://github.com/supersym'
        ]




        dependencies:
            #less:                    '1.3.x'
            stylus:                  '1.x'
            'coffee-script':         '1.4.x'
            'bal-util':              '1.x'
            jshint:                  '0.9.x'
            csslint:                 '0.9.x'
            'uglify-js':             '1.3.x'

The `npm` installer complains it can't find this package:
pulverizr:              '0.7.x'

            cson:                    '>=1.4'
            'watch-tree-maintained': '0.1.x'
            caterpillar:             '1.x'
            optimist:                '>=0.3'
            rimraf:                  '2.1.4'

        engines:
            node:                   '>=0.4.0'

        directories:
            lib:                    'lib'

        bin:
            buildr:                 './bin/buildr.js'

        main:                       './lib/buildr.js'
    }

## Data formats

### from memory object to string of text characters

Stringify the internal hash to a real CSON string, then read it and parse
as a JSON string, then write that one to the package.json file one level below.
    
    CSON.stringify cObj, (err, cStr) ->
        return if err

### from CSON string to JSON memory object

Now that we have a string of CSON, of which the likes we could store in
a file if we'd want to. But for us it is just a intermediate step:

        CSON.parse cStr, (err, jObj) ->
            return if err

### writing a JSON string to a file

Try catching errors using the obviously named block when trying to write
a file. There could be many exceptions thrown at us such as insufficient
permissions etc.

            try

                fs.writeFile '../package.json', JSON.stringify(jObj),

All we have left now is to set the encoding to 'utf-8' and provide a
callback with an error object.

#### file encoding

We ensure that the correct format is fed to the fs.writeFile() method
and file system libraries by providing a key of the options object.

Finally, we provide a function with a error handler object as closure.
Return on the earliest error possible, then inform the user ~@naive

                'utf-8', (err) ->

                    return err if err
                    console.log 'Saved file...'


[semver]: <http://semver.org/>
[depjitsu]: <http://blog.nodejitsu.com/package-dependencies-done-right>
[wafgyp]: <https://github.com/TooTallNate/node-gyp>