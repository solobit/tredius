// Generated by CoffeeScript 1.6.2
(function() {
  var cc, helpers, tpl;

  cc = require('coffeecup');

  tpl = function() {
    return div('.test', function() {
      return ul(function() {
        return li(function() {
          return 'hhehehe';
        });
      });
    });
  };

  helpers = {
    fields: ['achternaam', 'voornaam', 'email', 'telefoonnummer', 'woonplaats', 'postcode'],
    achternaam: {
      required: true,
      length: 20
    },
    postcode: {
      pattern: "[0-9]{4}[A-Z]{2}"
    }
  };

}).call(this);
