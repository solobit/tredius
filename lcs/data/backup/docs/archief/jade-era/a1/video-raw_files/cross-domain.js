(function() {
  var isSameDomain, sendMessage, useProxy;

  isSameDomain = function() {
    try {
      return !!top.location.href;
    } catch (e) {
      return false;
    }
  };

  useProxy = function(msg) {
    var i, id, iframe, pairs, proxy, querystring, root, url, url_array;
    querystring = window.location.href.split("?")[1] || false;
    id = "proxyframe";
    proxy = frames[id];
    url_array = void 0;
    root = "";
    pairs = void 0;
    url = void 0;
    if (!querystring || !msg) {
      return false;
    }
    msg = msg.replace(/\?/g, "%3F");
    msg = encodeURI(msg);
    querystring = querystring.replace(/&amp;/g, "&");
    pairs = querystring.split("&");
    i = 0;
    while (i < pairs.length) {
      if (pairs[i].indexOf("root=") !== -1) {
        root = pairs[i].replace("root=", "");
        if (root !== "") {
          root = decodeURI(root);
          url_array = root.split("/");
          url_array[url_array.length - 1] = "proxy.html?msg=" + msg;
          url = url_array.join("/");
        }
        break;
      }
      i++;
    }
    if (proxy) {
      return proxy.location.href = url;
    } else {
      iframe = document.createElement("iframe");
      iframe.id = id;
      iframe.name = id;
      iframe.src = url;
      iframe.style.display = "none";
      return document.body.appendChild(iframe);
    }
  };

  sendMessage = function() {
    var msg;
    msg = document.getElementById("message").value;
    if (parent && isSameDomain()) {
      top.showMessage(msg);
    } else {
      useProxy(msg);
    }
    return false;
  };

}).call(this);
