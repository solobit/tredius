var juice = require('juice');
juice("./out/t-time/columns/nov2012.html", function(err, html) {
  console.log(html);
});
