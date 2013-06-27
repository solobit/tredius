var fdf = require('fdf')
  , fs = require('fs');

var data = fdf.generate({
  name: 'Batman',
  type: 'Superhero'
});

fs.writeFileSync('data.fdf', data);
