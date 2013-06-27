


## Helpers

This is for helper functions

    log = console.log


## Objects

Bower is made up like the following shows:

    console.log require 'bower'


## Files

1. file `~/.bowerrc` » global configuration file
1. file `./bowerrc` » local configuration file
1. file `./components` » local bower definition (arbitrary location set in rc)

### .bowerrc

Typically, a `.bowerrc` is nothing more than a few keys defined in a `.json`
file. We can resolve packages from custom git repositories or elsewhere.

We use the data format known as `JSON` to define the run-command file:

    strJSON_Bower =

```json

        {
            "directory": "bower\_components",
            "endpoint": "https://bower.mycompany.com",
            "json": "bower.json",
            "searchpath": [
                "https://bower.herokuapp.com"
            ],
            "shorthand\_resolver": "git://example.com/{{{ organization }}}/{{{ package }}}.git"
        }
```

As mentioned, `.bowerrc` files can be suited in the home directory `~` or
`$HOME` as well as the project folder. This is how a project definition could
look in CoffeeScript Object Notation (CSON) for usage inside here:

    strCSON_Bower = """
        directory: "bower_components"
        endpoint: "https://bower.mycompany.com"
        json: "bower.json"
        searchpath: [ "https://bower.herokuapp.com" ]
        shorthand_resolver: "git://example.com/{{{ organization }}}/{{{ package }}}.git"
    """




    CSON = require 'cson'
    #bowerfile = CSON.parse(bowerrc, (err, result) -> throw err if err; log result)
    log bowerrc
    log json

# Building a super-simple package and installing it via Bower

It will be a fairly meaningless package, but it will cover nearly every step of
the process of creating a package.

Create a project directory, called `%(proj.dir)`. Within it, we’ll begin with
our component.json file. You’re familiar with all the properties, except main.

