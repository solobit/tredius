var cs = require('coffee-script'),
    requirejs = require('r.js');

requirejs.config({
    baseUrl: 'scripts',
    nodeRequire: require
});

requirejs(['./coffee/foo', 'bar'],
function (  foo,            bar) {
    console.log('bar.data: ' + bar.data);
    console.log('foo.name: ' + foo.name);
});
