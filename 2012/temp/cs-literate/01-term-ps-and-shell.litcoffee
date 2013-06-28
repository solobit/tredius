


## Prerequisites

I assume you have Node.js and the latest CoffeeScript installed.

Next you will need `nesh`, a innovative recent project to provide a
better Node/Coffee REPL. It has auto-colors for hash keys, values and
other data structures as well as auto-completion of method names, a save
options, built in `.help` and `.cls` commands.

We will use a simple method of spawning a child process off the node
process running under your operating system service/process manager.

    {exec, spawn} = require 'child_process'

Then feed it our arbitrary command and handle errors at the earliest
moment possible. Also you should make sure, if only for conventional
purposes, as a good practice stick the `err` parameter at the first
position and any others afterwards. Asynchronous functions usually have
2 parameters (or more) being the error object and a closure callback
variable (often also called `next` or `res`).

    exec "npm i -g nesh --save", (err, res) ->
        process.exit 1 if err

This installs the package `nesh` in the global module folder, reserved
for command line applications we want accessible from anywhere in our
terminal (regardless of the project, system-wide).

Since we didn't send the exit signal (we are still here aren't we?) we
can asume everything went alright with `npm` (I could have required that
as a module, I know).

    terminal = spawn 'xterm'

    terminal.stdout.on "data", (data) ->
        terminal.stdin.write "nesh -c"
        console.log "stdout: " + data
        console.log "Executing the 'nesh' command from the new terminal:"

    terminal.on "exit", (code) ->
        console.log "child process exited with code " + code

    setTimeout (->
        console.log "Timed out..."
        terminal.stdin.end()
    ), 1000



