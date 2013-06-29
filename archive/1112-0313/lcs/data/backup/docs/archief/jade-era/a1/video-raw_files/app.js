(function() {

  $(document).ready(function() {
    var crossdomain_iframe;
    crossdomain_iframe = $(".crossdomain");
    return crossdomain_iframe.src = crossdomain_iframe.src + "?root=" + encodeURI(window.location.href);
  });

}).call(this);
