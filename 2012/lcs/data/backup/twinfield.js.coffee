qs = ->

  val = ""
  query = window.location.search.substring(1)
  parms = query.split("&")
  i = 0

  while i < parms.length
    pos = parms[i].indexOf("=")
    if pos > 0
      key = parms[i].substring(0, pos)
      val = parms[i].substring(pos + 1)
      qsParm[key] = val
    i++

translateCode = (p_code) ->
  strWarning = ""
  blnError = true

  switch p_code.toLowerCase()
    when "accdisabled"
      strWarning = "het account is niet actief, neem contact op met de beheerder."
    when "incorrect"
      strWarning = "gebruikersnaam, wachtwoord of administratie is niet juist, probeer opnieuw."
    when "loginfirst"
      strWarning = "voer de account gegevens in, om in te loggen."
    when "loggedoff"
      strWarning = "uitgelogd."
      blnError = false
    when "companyinactive"
      strWarning = "de administratie staat uit."
    when "wrongbrowser"
      strWarning = "Het systeem is alleen te gebruiken met Internet Explorer 5.x en hoger"
    else
      strWarning = "Unknown error: " + p_code

  if strWarning.length > 0
    return "Fout: " + strWarning  if blnError
    strWarning

qsParm = new Array()
