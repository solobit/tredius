require('source-map-support').install()
foo = ->
  bar = -> throw new Error 'this is a demo'
  bar()
foo()

