Tredius corporate web front-end
===============================

### SOP

#### Literate package files

This is somewhat of a complicated chicken-and-egg story. The problem is, using
`npm i something --save` or `npm i elsething --save-dev` will add only to the
`package.json` file as will the command `npm init` which we may use now and
then. On the other hand, having a `.cson` file gives us so much benefits like
comments (multiline!) or why not skip it all together and have a `.litcoffee`
file. So this is one case, where the .json will be updated often with new
dependencies (dev, opt whatever) and we need to merge it with the previous
.cson file so we may keep the comments.

* sdiff is a good tool for this and allows us to interactively merge these
two files into 1 new one.

#### Current status

At the moment I am heavily refactoring old Jade written code to
CoffeeScript as well as abstracting out any patterns I have/had noticed.

Plugins I am currently abstracting out of Tredius or under consideration:

* Mail / Form munge (obfuscate to prevent automated spamming tools)
* ARIA-friendly forms and menu controls -> will become a more advanced GUI structure later
* Web 3.0 semantic support features (like schema.org Things or GoodRelations businesses)
* Better support for OOP class definitions through docpad if possible

> This web site was purposely written using native Dutch nomenclature.
It was intended as both experiment as well as demonstration of localized
docpad-enable web site building. Furthermore it serves a practical
matter as most of my intended customers will be local business in The
Netherlands. Also future possible developers may be served this way as a
more user-centric native speaking approach will prevent possible
miscommunication due to unambiguous nature (the web and programming uses
English) It may however, be of use for other developers who use
[Docpad][dp] as their tool of choice to generate
(static/Node.js/dynamic) web sites and who would like to learn from this
project. Renaming every variable will prove a useful exercise of getting
familiar with the structure I have set up.

> You may find some difficulties in understanding the names of elements,
classes or variables. I hope however, you will be able to understand the
structure without speaking a single word Dutch, as we share a lot of
words with English, or often enough, don't have any equivalent. It's my
personal challenge to do so but you will not see me find alternatives
for 'Video' and such. But an 'Artikel' is an 'Article' and a 'Pagina' is
a 'Page' so have fun decoding :)

[dp]: <http://docpad.org/>

Bronnen
-------

### Nomenclatuur
http://snn.vvb.org/2400lijst.htm
