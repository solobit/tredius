// Generated by CoffeeScript 1.6.2
(function() {
  var cheerio, domain, request;

  request = require('request');

  cheerio = require('cheerio');

  domain = 'http://www.tredius.nl';

  request(domain, function(error, response, body) {
    if (!error && response.statusCode === 200) {
      return console.log(body);
    }
  });

}).call(this);
