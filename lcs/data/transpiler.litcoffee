
# Loading from global folders
<http://nodejs.org/docs/latest/api/all.html#all_accessing_the_main_module>

If the `$NODE_PATH` environment variable is set to a colon `:` delimited list
(`path:path:path`) of absolute paths, then node will search those paths for
modules if they are not found elsewhere.

Note: On Windows, `$NODE_PATH` is delimited by semicolons `;` instead of colons.

Additionally, node will search in the following locations:

1. $HOME/.node_modules
1. $HOME/.node_libraries
1. $PREFIX/lib/node

Where `$HOME` is the user's home directory, and `$PREFIX` is node's configured
node_prefix.

These are mostly for historic reasons. (ed: I actually use this still a lot for
many programs, and so do thousands of people - how is this historic?)

You are highly encouraged to place your dependencies locally in node_modules
folders. They will be loaded faster, and more reliably.

### Accessing the main module

When a file is run directly from Node, `require.main` is set to its module. That
means that you can determine whether a file has been run directly by testing

```js
require.main === module
```
For a file foo.js, this will be true if run via node foo.js, but false if run by
require('./foo').

Let's try and do that from here for coffee... the `==` will work but I like to
use the `is` keyword better. Also, while at it - let us declare the shorter
version of `console.log`.

```coffee

    log = console.log
    log require.main is module
    log require.main == module

```

These return `true` from Sublime, that seems correct since I have a build script
that runs the `node` process. Execute the file from the shell using `coffee`
returns true as well.

From [nesh][nesh] my terminal REPL I get:

```ascii
CoffeeScript 1.6.2 on Node v0.10.5
Type .help for more information
coffee> require.main is module
false
coffee> 
```

Because `module` provides a `filename` property (normally equivalent to `__filename`),
the entry point of the current application can be obtained by checking
`require.main.filename`.

    log require.main.filename

Now to add some to the fun, using this file to require from nesh terminal (needs
absolute path, no __dirname but as you might notice, no exports here either yet)

```ascii
coffee> require 'etc/transpiler'
Error: Cannot find module 'etc/transpiler' at Function.Module._resolveFilename (module.js:338:15)
coffee> require 'etc/transpiler.litcoffee'
Error: Cannot find module 'etc/transpiler.litcoffee' at Function.Module._resolveFilename (module.js:338:15)
coffee> require __dirname + '/etc/transpiler.litcoffee'
ReferenceError: __dirname is not defined
coffee> require '/home/baal/customers/tredius/etc/transpiler.litcoffee'
false
false
/usr/local/lib/node_modules/nesh/bin/nesh.js
```

It tells you a little about the nature of things.


### Addenda: Package Manager Tips

The semantics of Node's `require()` function were designed to be general enough
to support a number of sane directory structures. Package manager programs such
as `dpkg`, `rpm`, and `npm` will hopefully find it possible to build native packages
from Node modules without modification.

Below we give a suggested directory structure that could work:

Let's say that we wanted to have the folder below hold the contents of a
specific version of a package:

> /usr/lib/node/<some-package>/<some-version>

Packages can depend on one another. In order to install package `foo`, you may
have to install a *specific version* of package `bar`. The bar package may itself
have dependencies, and in some cases, these dependencies may even collide or
form cycles.

Since Node looks up the `realpath` of any modules it loads (that is, resolves
symlinks), and then looks for their dependencies in the `node_modules` folders as
described above, this situation is very simple to resolve with the following
architecture:

* /usr/lib/node/foo/1.2.3/ - Contents of the foo package, version 1.2.3.
* /usr/lib/node/bar/4.3.2/ - Contents of the bar package that foo depends on.
* /usr/lib/node/foo/1.2.3/node_modules/bar - Symbolic link to
  /usr/lib/node/bar/4.3.2/.
* /usr/lib/node/bar/4.3.2/node_modules/* - Symbolic links to the packages that
  bar depends on.

Thus, even if a cycle is encountered, or if there are dependency conflicts,
every module will be able to get a version of its dependency that it can use.

When the code in the foo package does require('bar'), it will get the version
that is symlinked into /usr/lib/node/foo/1.2.3/node_modules/bar. Then, when the
code in the bar package calls require('quux'), it'll get the version that is
symlinked into /usr/lib/node/bar/4.3.2/node_modules/quux.

Furthermore, to make the module lookup process even more optimal, rather than
putting packages directly in /usr/lib/node, we could put them in
/usr/lib/node_modules/<name>/<version>. Then node will not bother looking for
missing dependencies in /usr/node_modules or /node_modules.

In order to make modules available to the node REPL, it might be useful to also
add the `/usr/lib/node_modules` folder to the `$NODE_PATH` environment variable.
Since the module lookups using node_modules folders are all relative, and based
on the real path of the files making the calls to require(), the packages
themselves can be anywhere.

* V8 JavaScript, a C++ library. Used for interfacing with JavaScript: creating
  objects, calling functions, etc. Documented mostly in the v8.h header file
  (deps/v8/include/v8.h in the Node source tree), which is also available
  online.
* libuv, C event loop library. Anytime one needs to wait for a file descriptor
  to become readable, wait for a timer, or wait for a signal to be received one
  will need to interface with libuv. That is, if you perform any I/O, libuv will
  need to be used.
* Internal Node libraries. Most importantly is the node::ObjectWrap class which
  you will likely want to derive from.
* Others. Look in deps/ for what else is available.

Node statically compiles all its dependencies into the executable. When
compiling your module, you don't need to worry about linking to any of these
libraries.

All of the following examples are available for download and may be used as a
starting-point for your own Addon.

### Addons

Addons are dynamically linked shared objects. They can provide glue to C and C++
libraries. The API (at the moment) is rather complex, involving knowledge of
several libraries:

    log this
    if this is {} then log "this is empty"


    this.init = (options) ->

        process.exit 1 if require.main is not module

        _                = require 'lodash'
        fs               = require 'fs'
        path             = require 'path'
        natural          = require 'natural'
        i18n             = require 'i18next'
        cs               = require 'coffee-script'
        compressor       = require 'node-minify'
        cson             = require 'cson'
        yaml             = require 'yaml'
        #csv             = require 'json2csv'
        #xml-mapping

        # Destructuring array and interpolation
        [firstName, lastName] = options.split ' '
        log "Welcome #{firstName}. Or would you prefer Mr. #{lastName}?"


    this.james = (sentence) -> log sentence.match(/[^{}]+(?=\})/g)

    this.James = (request) ->
        request.match(/[^{}]+(?=\})/g)

        # V
    @James 'please {load} another {module} for {me}, give me {natural} please...'



    @init 'John Johnson'
    log 'this ' + this
    log '@ (alias for this) ' + @    


    process.exit 1



### Publieke toegang

Exporteer het explaar van (the instance, concrete realization of) het type
`Object` (class/type/supertype/base class) dat we net vastgesteld hebben, naar
de scope die voor overige modules toegankelijk is.



    this.file_location      = path.resolve(__filename)
    this.path_minified      = '../docpad.js' 
    this.path_compiled      = 'docpad.compiled.js'
    this.file_database      = 'continents-cities-nl_NL.mo'
    path_languages          = "i18n/languages/"



    i18Config: {
        preload:            ['nl-NL']
        lng:                'nl-NL'
        fallbackLng:        false #'en'
        load:               'current'
        detectLngQS:        'taal' 
        useCookie:          true
        debug:              true
        keyseparator:       '::'
        nsseparator:        ':::'
        resGetPath:         '../locales/__lng__/__ns__.json'

        ns:
            #namespaces:        ['app', 'buttons']
            namespaces:         ['app']
            defaultNs:          'app'
    }

Do a file system synchronous read upon oneself. This gives us all source code
including this piece of code and text. We don't really have reflective
properties available in JS other than `.toString()` anyway.
> `((?))` How sane can we stay? What alternatives? Include exclude stuff?


    litcoffee   = fs.readFileSync(@file_location, 'utf-8')
    educated    = cs.helpers.invertLiterate
    compiled    = cs.compile educated(litcoffee), {bare: on}

    fs.writeFile @path_compiled, compiled, 'utf-8', (err) ->
        log err if err

Compression of the final resulting JavaScript, after being transformed from
`.litcoffee` compiled to intermediate `.js` and now, finally, ready to be
compressed (minified) using UglifyJS. We break the convention with web
components of naming the file with a `.min` inside the name because docpad
expects a certain name (docpad) of one of these types (.js .coffee .json .cson).

    new compressor.minify
        type:       'uglifyjs'
        fileIn:     @path_compiled
        fileOut:    @path_minified
        callback: (err) -> throw err if err

Thanks for listening

    module.exports = this