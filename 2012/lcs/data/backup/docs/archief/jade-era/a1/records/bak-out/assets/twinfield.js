(function() {
  var qs, qsParm, translateCode;

  qs = function() {
    var i, key, parms, pos, query, val, _results;

    val = "";
    query = window.location.search.substring(1);
    parms = query.split("&");
    i = 0;
    _results = [];
    while (i < parms.length) {
      pos = parms[i].indexOf("=");
      if (pos > 0) {
        key = parms[i].substring(0, pos);
        val = parms[i].substring(pos + 1);
        qsParm[key] = val;
      }
      _results.push(i++);
    }
    return _results;
  };

  translateCode = function(p_code) {
    var blnError, strWarning;

    strWarning = "";
    blnError = true;
    switch (p_code.toLowerCase()) {
      case "accdisabled":
        strWarning = "het account is niet actief, neem contact op met de beheerder.";
        break;
      case "incorrect":
        strWarning = "gebruikersnaam, wachtwoord of administratie is niet juist, probeer opnieuw.";
        break;
      case "loginfirst":
        strWarning = "voer de account gegevens in, om in te loggen.";
        break;
      case "loggedoff":
        strWarning = "uitgelogd.";
        blnError = false;
        break;
      case "companyinactive":
        strWarning = "de administratie staat uit.";
        break;
      case "wrongbrowser":
        strWarning = "Het systeem is alleen te gebruiken met Internet Explorer 5.x en hoger";
        break;
      default:
        strWarning = "Unknown error: " + p_code;
    }
    if (strWarning.length > 0) {
      if (blnError) {
        return "Fout: " + strWarning;
      }
      return strWarning;
    }
  };

  qsParm = new Array();

}).call(this);
