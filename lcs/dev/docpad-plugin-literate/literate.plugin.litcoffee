
Enables rendering from .html.coffee.litcoffee

Does string interpolation on the .litcoffee prose section in sequential
order



title
    self
    environ
    scope

prologue
    imports

prose
    varA=2
    code

"prose #{varA}" <------ 2
    varA=4
    code

"prose #{varA}" <-------- 4
    code
