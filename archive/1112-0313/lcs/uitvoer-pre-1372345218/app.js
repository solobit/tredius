(function() {
  var handleComplete, imageList, path, queue;

  path = "/media/afbeeldingen";

  imageList = ("" + path + "/bg_accountancy.jpg\n" + path + "/bg_belastingadvies.jpg\n" + path + "/bg_blauw.gif\n" + path + "/bg_bruin.gif\n" + path + "/bg_juristen.jpg\n" + path + "/bg_pensioen.jpg\n" + path + "/bg_quote.png\n" + path + "/bg_tech.jpg\n" + path + "/bg_ttime.jpg\n" + path + "/bg_ttime_vervaagd.jpg").replace(/\s+/g, " ").split(' ');

  console.log(imageList);

  queue = new createjs.LoadQueue(true);

  queue.addEventListener('fileload', function(obj) {
    return console.log("Client-side Browser JavaScript:\n* preload.js file " + obj.result + " loading.");
  });

  queue.addEventListener('complete', function() {
    return console.log('preload.js file downloading complete');
  });

  queue.loadManifest(imageList);

  queue.load();

  handleComplete = function() {};

}).call(this);
