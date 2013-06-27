(function() {
  head(function() {
    var addEvent, log, ready;

    log = console.log;
    addEvent = function(element, eventName, callback) {
      if (element.addEventListener) {
        return element.addEventListener(eventName, callback, false);
      } else {
        return element.attachEvent(eventName, callback, false);
      }
    };
    return ready = function(player_id) {
      var froogaloop, onFinish, onPlay, player1, player2;

      onPlay = function() {
        return froogaloop.addEvent("play", function(data) {
          return log("vimeo: afspelen");
        });
      };
      onFinish = function() {
        return froogaloop.addEvent("finish", function(data) {
          return log("vimeo: stoppen");
        });
      };
      log("vimeo: gereed!");
      froogaloop = $f(player_id);
      onPlay();
      onFinish();
      player1 = $("#VideoSpeler-55429476")[0];
      player2 = $("#VideoSpeler-55430952")[0];
      $f(player1).addEvent("ready", ready);
      return $f(player2).addEvent("ready", ready);
    };
  });

}).call(this);
