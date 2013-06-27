(function() {
  $(document).ready(function() {
    var isGeldig;

    $("input.valideer").each(function() {
      return $(this).after("<mark class='validate'></mark>");
    });
    $(document).on('focusout', "input.valideer", function(e) {
      if (!$(this).val() || !isGeldig($(this))) {
        return $(this).addClass("fout").parent().find("mark").removeClass("valid").addClass("fout");
      } else {
        return $(this).removeClass("fout").parent().find("mark").removeClass("fout").addClass("valid");
      }
    });
    $(document).on('click', "form a.versturen", function(e) {
      var actie, api, creds, dsid, formulier, func, mlid, server, sid;

      formulier = $(this).parents("form[id*='ulier']");
      formulier.find("input.valideer").each(function() {
        return $(this).trigger('focusout');
      });
      if ($("form mark.fout").length > 0) {
        $("span.bericht").text(" Enkele gegevens zijn niet aanwezig of onjuist ingevuld: ");
        return $("form mark.fout").attr('id', function(i, val) {
          return $("span.bericht").append(val + ', ');
        });
      } else {
        $("span.bericht").text("");
        server = encodeURI("http://www.graphicmail.nl/api.aspx?");
        sid = encodeURIComponent("SID=4");
        creds = encodeURIComponent("&Credentials=DtZEdUEEcUap7RsVxnxyWux37VTOip2Xp2M+gIusSMwpc9Hu7nDCFm2LffostDgC/8lkV84pfIARSyMl/Hfamx4oG8mt/mk8o+UsteAhNqMs/qO3lhsagAKn4EtikhystNc17yejBNe2b+pfgz1pwRTA3F1AwxkI87/m5D+5kPkj2DLiRn/CFk4UBeiBT37fW+kniU94iIxHeoOThig3YRuLGaxd3LeSloSHW1xcaEhMpaP+uFozdVPBBf5cVZwjx63xVLa5+jQZBf7UM9zaew==");
        func = encodeURIComponent("&Function=post_add_email_and_data");
        mlid = encodeURIComponent("&MailingListID=145473");
        dsid = encodeURIComponent("&DatasetID=20853");
        alert(server + sid + creds + func + mlid + dsid);
        true;
        actie = formulier.attr('action');
        api = actie + '&SucessReturnUrl=http://' + window.location.host + '/overig/succes.html' + '&ErrorReturnUrl=http://' + window.location.host + '/overig/faal.html';
        formulier.attr('action', api);
        return formulier.trigger('submit');
      }
    });
    return isGeldig = function(veld) {
      var patroon, soort, waarde;

      waarde = veld.val();
      soort = veld.attr('id');
      switch (soort) {
        case 'email':
          patroon = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
          break;
        case 'postcode':
          patroon = /^[1-9][0-9]{3}[\s]?[A-Za-z]{2}$/i;
          break;
        case 'telefoon':
          patroon = /^\d{7,}$/;
          break;
        default:
          patroon = /^(([2][e][[:space:]]|['][ts][-[:space:]]))?([ëéÉËa-zA-Z]{2,}|[A-Z]\.)((\s|[-](\s)?)[ëéÉËü\.a-zA-Z]{2,})*$/;
      }
      if (soort === 'telefoon') {
        return RegExp(patroon).test(waarde.replace(/[\s()+\-\.]|ext/g, ""));
      } else {
        return RegExp(patroon).test(waarde);
      }
    };
  });

}).call(this);
