window.onload = ->
  
  # Simple slider
  new Dragdealer("simple-slider")
  
  # Vertical
  mask = document.getElementById("scroll-mask")
  content = document.getElementById("scroll-content")
  new Dragdealer("scroll-bar",
    horizontal: false
    vertical: true
    yPrecision: content.offsetHeight
    animationCallback: (x, y) ->
      margin = y * (content.offsetHeight - mask.offsetHeight)
      content.style.marginTop = String(-margin) + "px"
  )
  
  # Magnifier
  text = document.getElementById("magnifying-text")
  new Dragdealer("magnifier",
    steps: 6
    snap: true
    animationCallback: (x, y) ->
      text.style.fontSize = String(12 + x * 24) + "px"
  )
  
  # Slideshow
  menuWrapper = document.getElementById("slideshow-menu-wrapper")
  cursor = document.getElementById("slideshow-menu-cursor")
  slideshow = new Dragdealer("slideshow",
    steps: 4
    loose: true
    animationCallback: (x, y) ->
      top = x * (menuWrapper.offsetHeight - cursor.offsetHeight)
      cursor.style.top = String(top) + "px"
  )
  document.getElementById("slideshow-photo-1").onclick = ->
    slideshow.setStep 1
    false

  document.getElementById("slideshow-photo-2").onclick = ->
    slideshow.setStep 2
    false

  document.getElementById("slideshow-photo-3").onclick = ->
    slideshow.setStep 3
    false

  document.getElementById("slideshow-photo-4").onclick = ->
    slideshow.setStep 4
    false

  
  # Map
  canvasMask = new Dragdealer("canvas-mask",
    vertical: true
    steps: 2
    loose: true
  )
  document.getElementById("canvas-slide-1").onclick = ->
    canvasMask.setValue 0, 0
    false

  document.getElementById("canvas-slide-2").onclick = ->
    canvasMask.setValue 1, 0
    false

  document.getElementById("canvas-slide-3").onclick = ->
    canvasMask.setValue 0, 1
    false

  document.getElementById("canvas-slide-4").onclick = ->
    canvasMask.setValue 1, 1
    false