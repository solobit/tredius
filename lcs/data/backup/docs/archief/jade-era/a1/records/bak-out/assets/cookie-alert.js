(function() {
  $(document).ready(function() {
    var closeText, cookieBoxStyle, cookieStatus, createCookie, privacyUrl, readCookie;

    createCookie = function(a, b, c) {
      var d, e;

      if (c) {
        d = new Date;
        d.setTime(d.getTime() + c * 24 * 60 * 60 * 1e3);
        e = "; expires=" + d.toGMTString();
      } else {
        e = "";
      }
      return document.cookie = a + "=" + b + e + "; path=/";
    };
    readCookie = function(a) {
      var b, c, d, e;

      b = a + "=";
      c = document.cookie.split(";");
      d = 0;
      while (d < c.length) {
        e = c[d];
        while (e.charAt(0) === " ") {
          e = e.substring(1, e.length);
        }
        if (e.indexOf(b) === 0) {
          return e.substring(b.length, e.length);
        }
        d++;
      }
      return null;
    };
    privacyUrl = "http://www.google.com/privacy.html";
    closeText = "[ok]";
    cookieStatus = readCookie("cookieStatus");
    if (cookieStatus !== 1) {
      cookieBoxStyle = {
        position: "fixed",
        right: "10px",
        bottom: "10px",
        width: "200",
        "-webkit-border-radius": "10px",
        "-moz-border-radius": "10px",
        "border-radius": "10px",
        border: "1px solid #ccc",
        padding: "10px",
        "font-family": "Open Sans, sans-serif",
        "font-size": "12px",
        "background-color": "#efefef",
        display: "none"
      };
      $(".cookieWarningBox").css(cookieBoxStyle);
      $(".cookieWarningBox").html("Deze website gebruikt 'cookies' teneinde u de beste, meest relevante\nervaring te leveren. Gebruik van deze website impliceert dat u hiermee\nakkoord gaat. U kunt <a href='/overig/privacy.html'>hier</a> onze\nprivacyverklaring lezen. <a style='float:right;' href='#'>[ok]</a>");
      $(".cookieWarningBox").fadeIn(300);
    }
    return $(".cookieWarningBox a").click(function() {
      console.log('test');
      $(".cookieWarningBox").fadeOut(300);
      return createCookie("cookieStatus", 1, 10);
    });
  });

}).call(this);
