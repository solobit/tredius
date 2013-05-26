
# Purpose

 Development in software projects really start with a decent packager and
 luckily Node.js has npm which offers solid dependency management strategies
 out of the box.
 There are a few programs at work on this project, and some generate their own
 needed files, such as package.json, .gitconf, .npmrc, .bowerrc and so on.
 Others should be present by convention.
 This module would really be about some generic methods for existence checks,
 validations and recommendations or additions to those structures.
 If we won't find a tool before that, this one would be all about making these
 kinds of 'project management' conventions and the overall status insightful.

 console log (regex-file-seq #"wisp" "../../"))
Some projects may have need for configuration/options objects passed, others
take string parameters to load files, not everyone has a baseline
configuration included to fall back to. Some don't even specify the options
needed to initialize part of the program. Authors may require you to use a
CLI tool, others only work from within another module. Some design schools
are OOP, others are pure functional, some synchronous, others aren't.
Long story short: its all very different from oneanother (although there
often are similiarities to be found). To make matters worse, if the API
hasn't matured enough yet, the exposed methods and parameters often change
until the authors decided it is stable (after which renaming would equal a
major upgrade thus breaking many applications, if they follow semantic
versioning system).

Usually this dynamic nature of the development world, requires us to read
manuals, cross reference multiple sources, check the dates/version numbers
and currency of documentation (and often thus accuracy) sources found on the
web.
