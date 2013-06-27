$(document).ready ->

  #Custom settings
  style_in = "easeOutBounce"
  style_out = "jswing"
  speed_in = 1000
  speed_out = 300

  #Calculation for corners
  neg = Math.round($(".qitem").width() / 2) * (-1)
  pos = neg * (-1)
  out = pos * 2
  $(".qitem").each(->
    url = $(this).find("a").attr("href")
    img = $(this).find("img").attr("src")
    alt = $(this).find("img").attr("img")
    $("img", this).remove()
    $(this).append "<div class=\"topLeft\"></div><div class=\"topRight\"></div><div class=\"bottomLeft\"></div><div class=\"bottomRight\"></div>"
    $(this).children("div").css "background-image", "url(" + img + ")"
    $(this).find("div.topLeft").css
      top: 0
      left: 0
      width: pos
      height: pos

    $(this).find("div.topRight").css
      top: 0
      left: pos
      width: pos
      height: pos

    $(this).find("div.bottomLeft").css
      bottom: 0
      left: 0
      width: pos
      height: pos

    $(this).find("div.bottomRight").css
      bottom: 0
      left: pos
      width: pos
      height: pos

  ).hover(->
    $(this).find("div.topLeft").stop(false, true).animate
      top: neg
      left: neg
    ,
      duration: speed_out
      easing: style_out

    $(this).find("div.topRight").stop(false, true).animate
      top: neg
      left: out
    ,
      duration: speed_out
      easing: style_out

    $(this).find("div.bottomLeft").stop(false, true).animate
      bottom: neg
      left: neg
    ,
      duration: speed_out
      easing: style_out

    $(this).find("div.bottomRight").stop(false, true).animate
      bottom: neg
      left: out
    ,
      duration: speed_out
      easing: style_out

  , ->
    $(this).find("div.topLeft").stop(false, true).animate
      top: 0
      left: 0
    ,
      duration: speed_in
      easing: style_in

    $(this).find("div.topRight").stop(false, true).animate
      top: 0
      left: pos
    ,
      duration: speed_in
      easing: style_in

    $(this).find("div.bottomLeft").stop(false, true).animate
      bottom: 0
      left: 0
    ,
      duration: speed_in
      easing: style_in

    $(this).find("div.bottomRight").stop(false, true).animate
      bottom: 0
      left: pos
    ,
      duration: speed_in
      easing: style_in

  ).click ->
    window.location = $(this).find("a").attr("href")


