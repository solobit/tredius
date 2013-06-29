

# Zodra HTML DOM geladen
$(document).ready ->

  # Cookie maken
  createCookie = (a, b, c) ->
    if c
      d = new Date
      d.setTime d.getTime() + c * 24 * 60 * 60 * 1e3
      e = "; expires=" + d.toGMTString()
    else
      e = ""
    document.cookie = a + "=" + b + e + "; path=/"

  # Cookie lezen
  readCookie = (a) ->
    b = a + "="
    c = document.cookie.split(";")
    d = 0

    while d < c.length
      e = c[d]
      e = e.substring(1, e.length)  while e.charAt(0) is " "
      return e.substring(b.length, e.length)  if e.indexOf(b) is 0
      d++
    null

  privacyUrl = "http://www.google.com/privacy.html"
  closeText = "[ok]"
  cookieStatus = readCookie("cookieStatus")

  unless cookieStatus is 1

    cookieBoxStyle =
      position: "fixed"
      right: "10px"
      bottom: "10px"
      width: "200"
      "-webkit-border-radius": "10px"
      "-moz-border-radius": "10px"
      "border-radius": "10px"
      border: "1px solid #ccc"
      padding: "10px"
      "font-family": "Open Sans, sans-serif"
      "font-size": "12px"
      "background-color": "#efefef"
      display: "none"

    $(".cookieWarningBox").css cookieBoxStyle

    $(".cookieWarningBox").html """
      Deze website gebruikt 'cookies' teneinde u de beste, meest relevante
      ervaring te leveren. Gebruik van deze website impliceert dat u hiermee
      akkoord gaat. U kunt <a href='/overig/privacy.html'>hier</a> onze
      privacyverklaring lezen. <a style='float:right;' href='#'>[ok]</a>
      """

    $(".cookieWarningBox").fadeIn 300

  # Bij klikken
  $(".cookieWarningBox a").click ->
    console.log 'test'
    $(".cookieWarningBox").fadeOut 300
    createCookie "cookieStatus", 1, 10


