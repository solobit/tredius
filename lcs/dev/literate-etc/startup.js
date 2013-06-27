// use loaders
var fileContent = require("raw!"+__filename);

// use loaders automatically
var template = require("./my-template.jade");

var html = template({content: fileContent});

// use require.context
var directoryRequire = require.context("raw!./subdir");
var txtFile = directoryRequire("./aFile.txt");

// use require.ensure
require.ensure(["./someFile.js"], function(require) {
    var someFile = require("./someFile.js");
});

// use AMD define
require.define(["./aDep"], function(aDep) {
    aDep.run();
});

// use AMD require
require(["./bDep"], function(bDep) {
    bDep.doSomething();
});