

$(document).ready ->

    $fields = $('form.FormulierElement :input')

    frm     = $('form.FormulierElement')
    console.log $fields

    $("[href='#']").on 'click', (e) ->
        e.preventDefault()
        return false


    frm.each ->
        $(@).after "<mark class='validate'></mark>"
        ph = null # outer scope variable for temp storage

    $('input').focus ->
        ph = $(@).attr 'placeholder'
        $(@).attr 'placeholder', ''

    $('input').focusout ->
        $(@).attr('placeholder', ph) if ph?




    $('.FormulierKnop--verzenden').click ->
        $(@).closest('form').find('input,textarea').each ->
            console.log $(@).attr 'name'
        # do something with the input/textarea



#     $("form.").each ->


#     $(this).after "<mark class='validate'></mark>"

#   # Buiten die closure voegen we een listener toe
#   $(document).on 'focusout', "input.valideer", (e) ->

#     # Die bij focusout de waarde op (in)valide test
#     if not $(this).val() or not isGeldig $(this)

#       # Bij een fout de markering toe door de valide te verwijderen en fout toe te voegen
#       $(this).addClass("fout").parent().find("mark").removeClass("valid").addClass "fout"

#     else

#       # anders dan is de geteste waarde correct volgens de regular expression en iig niet leeg
#       $(this).removeClass("fout").parent().find("mark").removeClass("fout").addClass "valid"

#       # daarmee zijn we voorlopig klaar want voorlopig

#   # luisteren we alleen nog op de klik van 'knop verzenden'
#   $(document).on 'click', "form a.versturen", (e) ->

#     # p.s. het event object (e) is niet strict noodzakelijk hier

#     # wel willen we asap weten voor welk formulier de actie geldt
#     formulier = $(this).parents("form[id*='ulier']")

#     # we hebben n.l. altijd wel 1 of meer formulieren (nieuwsbrief + contact, of abo of...)

#     # Binnen dit form forceren we op alle gewenste invoerelementen
#     formulier.find("input.valideer").each ->

#       # het afvuren van een gebeurtenis op afstand en omdat we eerder aan
#       # deze focusout gebeurtenissen geknoopt zijn, deze zorgt voor een nieuwe
#       # validatie check (if not.. or not..) - dus 2x of meer, tijdens invullen
#       # en verlaten door gebruiker (de echte gebeurtenis) en 1x door ons veroorzaakt
#       $(this).trigger 'focusout'

#       # (dit omdat de gebruiker dus met klikken aangeeft klaar te zijn)

#     # Indien er nog fouten zijn in het gehele form
#     if $("form mark.fout").length > 0

#       # komen deze vanzelf aan het licht en instrueren we de gebruiker
#       $("span.bericht").text " Enkele gegevens zijn niet aanwezig of onjuist ingevuld: "

#       # welke velden het zijn en vermelden de identifiers?
#       $("form mark.fout").attr 'id', (i, val) ->
#         $("span.bericht").append val + ', '


#     # alles goed?
#     else

#       # verwijder dan statusbericht
#       $("span.bericht").text ""

#       # statisch de form action url samenstellen...
#       server  = encodeURI          "http://www.graphicmail.nl/api.aspx?"
#       sid     = encodeURIComponent "SID=4"
#       creds   = encodeURIComponent "&Credentials=DtZEdUEEcUap7RsVxnxyWux37VTOip2Xp2M+gIusSMwpc9Hu7nDCFm2LffostDgC/8lkV84pfIARSyMl/Hfamx4oG8mt/mk8o+UsteAhNqMs/qO3lhsagAKn4EtikhystNc17yejBNe2b+pfgz1pwRTA3F1AwxkI87/m5D+5kPkj2DLiRn/CFk4UBeiBT37fW+kniU94iIxHeoOThig3YRuLGaxd3LeSloSHW1xcaEhMpaP+uFozdVPBBf5cVZwjx63xVLa5+jQZBf7UM9zaew=="
#       func    = encodeURIComponent "&Function=post_add_email_and_data"
#       mlid    = encodeURIComponent "&MailingListID=145473"
#       dsid    = encodeURIComponent "&DatasetID=20853"

#       alert server + sid + creds + func + mlid + dsid
#       true
#       actie = formulier.attr 'action'

#       # API string samenstellen voor server-side validatie
#       api = actie + '&SucessReturnUrl=http://' + window.location.host + '/overig/succes.html' +
#         '&ErrorReturnUrl=http://' + window.location.host + '/overig/faal.html'
#       formulier.attr 'action', api

#       # Finally
#       formulier.trigger 'submit'


#   # Regex test (waar/onwaar)
#   isGeldig = (veld) ->

#     # Passed by reference maar we kennen de methodes gelukkig dus ...
#     waarde = veld.val()
#     soort = veld.attr 'id'

#     # Selecteer patroon ahv veld
#     switch soort

#       when 'email'
#         patroon = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/

#       when 'postcode'
#         patroon = /^[1-9][0-9]{3}[\s]?[A-Za-z]{2}$/i

#       when 'telefoon'
#         patroon = /^\d{7,}$/

#       else
#         patroon = /^(([2][e][[:space:]]|['][ts][-[:space:]]))?([ëéÉËa-zA-Z]{2,}|[A-Z]\.)((\s|[-](\s)?)[ëéÉËü\.a-zA-Z]{2,})*$/

#     # Telefoonnummers strippen we eerst van alle extra tekens
#     if soort is 'telefoon'
#       RegExp(patroon).test waarde.replace(/[\s()+\-\.]|ext/g, "")

#     # al het overige is zo prima
#     else
#       RegExp(patroon).test waarde

# # Invoervelden als kinderen van form met id beginnend met 'ulier'
# # bijv. form#ulier_nieuws, form#ulier_contact enz.
