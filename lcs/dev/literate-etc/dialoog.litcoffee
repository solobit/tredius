
    detective = require 'detective'
    walkdir = require 'walkdir'
    fs = require 'fs'

    src = fs.readFileSync __dirname + 

## Prologue

The preface or introduction to a literary work, a speech often in verse
addressed to the audience by an actor at the beginning of a play.

When you’re focused on character development writing, you can study up
on archetypal characters to understand the inner workings of a solid
hero. But when learning how to develop characters, you really need to
understand what is at your main character’s core. Have you done your
homework in creating everything there is to know about your
character—including background, history, phobias, nervous habits, etc.?
There’s a two-fold process that can help you turn the literary
characterization of your lead that you’ve developed in your notes into
dynamite scenes that will have your readers thirsty for more story about
your main character. [Source](http://www.writersdigest.com/character-development)



    introduction = () ->


Setup a question by providing a variable `property` or named in any
other fashion you like, that is set to a new Object `{ }`. For explicit
purposes of education, I have provided it - but this is fully optional
as we use significant white space (the indent on the next line) to imply
its presence as well.

        # ((note)) Our literate coffee routine needs to remove empty
        # variables not used elsewhere.
        propertyEmpty = {}

In case you may wonder, the name `property` often refers to 'properties
of a class', since an Object is a concrete realization of a class, we
ask for the property of `property` here? Yes, but since we only need 1
answer from the entire definition (the rest is to help ask the question,
what is a viable answer, which form it takes), the name is technically
correct because we really are interested in only the answer (the prompt
is getting the property we want). The [example][02] as such, the name
might be very confusing to non-programmers (like I demonstrated, even
got me confused for a second):

        # The last object, and thus closure, of this chapter (function)
        questionToAnswer = {

I feel this is a bit safer. Personally, my OOP background makes me want
to make this into a class instead of a plain old JavaScript object - but
how are they really that different anyway? The complexity of the object
might be one reason to make a class, or just for clarity - or because it
fits in a description of the domain elsewhere.

We create a field with the key `name` and assign that a value of
`yesno`. This will allow us to re-use patterns at a later stage. This
could also become some form of 'type of question: yn' we might later
want so these names could also be dynamically created by some convention
to use `yn-` or `yn-somename-q` or whatever you want.

            name:       "yesno"

The message really is our first text we could internationalizably have
written here. Since this project eventually needs to be multilingual,
this is a really good candidate to abstract out.

            message:    "Dit bestand naar de schijf schrijven?"

Fact is, the 'prompt' module really expects any object (under any
variable identifier so property is ok but might as well just be
'boogaga', whatever) but with specifically named fields, and certain
*types* of values (if properly done in their side, I'm not checking the
source right now). Validator is a good word, I like `pattern` here as
well. Both are 'true' from this perspective.

            validator:  /j[a]*|n[ee]?/

Issue a warning message if the answer does not conform the pattern we
established above.

            warning:    "U moet j[a] of n[ee] antwoorden"

And finally set a default answer.

            default:    "nee"
        }


    plot = () ->

A command prompt (or just prompt) is a sequence of (one or more)
characters used in a command-line interface to indicate readiness to
accept commands. Its intent is to literally **prompt the user** to take
action. A prompt usually ends with one of the characters `$`, `%`, `#`,
`:`, `>` and often includes other information, such as the path of the
[current working directory][01].

![A command prompt and command line in a Windows path](http://upload.wikimedia.org/wikipedia/en/thumb/8/8a/COMMAND_LINE.svg/500px-COMMAND_LINE.svg.png)

We use the prompt module `get()` method to accept our `property` object
as a first argument of the method/function. The second argument we
provide, is another function. It is a callback function which, itself
holds another callback `result` and, as is advised to always do with
asynchronous execution models, the first argument to be a error object.

This would trigger the function right now, which we might now want. So
for abstracting out common patterns in Literate CoffeeScript, which is
what I do here, we might want to wrap this in a function to resemble our
main storyline.

        # Changed variable name from property to ` questionToAnswer`
        prompt.get questionToAnswer, (err, result) ->

We should always try to get rid of errors at the soonest possible
moment. This often leads to the following pattern often found included
in routines, yet a little more elaborate, using the built-in prompt
error type logger.

            # Catch errors earliest possible moment in a graceful way
            (prompt.logger.error err; process.exit 1) if err

Next we set-up a `try..catch` block to deal with errors that may occur
while parsing the result (say, if someone entered an illigal character
somehow not covered - unlikely; but try pressing `Ctrl+C` to send a
`SIGTERM` signal).

            try

Log the results to the terminal window. You need to describe, in text,
what result goes where. For a bit more automated handling, you can play
with the name, if you have many questions, you can abstract out a
`Questionaire` class eventually I'd say. I used a form of string
interpolation to process the result in a terminal message output.

                console.log "\nUw reactie is ontvangen:"

To demonstrate how one would normally, in JavaScript, handle this form
of string concatenation, let us get the number of questions we have
answered.

                console.log "aantal vragen beantwoord: " + (key for key of result).length

I used a little trick to get the amount. Since `result` is an object, we
need to iterate it to receive an array, who's elements we can easily
count without using a `i` or `counter` variable.

But in CoffeeScript, even the `+` can easily be omitted using string
interpolation.

Using a list to display the results we gathered, we can process many
questions in 1 run. We could of course form nice coherent sentences
using the same technique of string interpolation, but lets assume for
now that we want to show the results in a list, one row per question
answered.

                console.log "» antwoord: #{result.yesno}"

Note that these would be very localizable strings that need to come from
a language map (file) somewhere.

            catch e

                prompt.logger.error e



    preamble = () ->

Setting these properties customizes the prompt. They must be set up
front, before initializing the prompt with the `start()` method. This
requires us, if we don't want to keep these statements up here, that we
need some functions wrapped around these statements so we don't have to
discuss this part yet.

        prompt.message = "Bestand schrijven?".magenta
        prompt.delimiter = " ~ ".green

In case of any serious low-level signals, like `Ctrl+C` sends a signal
on unices, we attach a event handler to our main (node) process, that
will trigger on a signal `SIGTERM` and second parameter the way to deal
with it.

        process.on 'SIGTERM', ->
            prompt.logger.error 'Exiting, received a SIGTERM signal. Bye!'
            process.exit 1

Start the prompt safefly and correct now.

        prompt.start()











[01]: <http://en.wikipedia.org/wiki/Working_directory>
[02]: <https://github.com/flatiron/prompt/tree/master/examples>