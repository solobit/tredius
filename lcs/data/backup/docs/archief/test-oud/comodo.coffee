
program = require("commodore")
###
program.version("0.0.1").option("-p, --peppers", "Add peppers").option("-P, --pineapple", "Add pineapple").option("-b, --bbq", "Add bbq sauce").option("-c, --cheese [type]", "Add the specified type of cheese [marble]", "marble").parse process.argv
console.log "you ordered a pizza with:"
console.log "  - peppers"  if program.peppers
console.log "  - pineappe"  if program.pineapple
console.log "  - bbq"  if program.bbq
console.log "  - %s cheese", program.cheese
###
range = (val) ->
  val.split("..").map Number
list = (val) ->
  val.split ","
program.version("0.0.1").usage("[options] <file ...>").option("-i, --integer <n>", "An integer argument", parseInt).option("-f, --float <n>", "A float argument", parseFloat).option("-r, --range <a>..<b>", "A range", range).option("-l, --list <items>", "A list", list).option("-o, --optional [value]", "An optional value").parse process.argv
console.log " int: %j", program.integer
console.log " float: %j", program.float
console.log " optional: %j", program.optional
program.range = program.range or []
console.log " range: %j..%j", program.range[0], program.range[1]
console.log " list: %j", program.list
console.log " args: %j", program.args