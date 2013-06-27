

    ###
    # Put together the URL

    # This function puts the video on the page
    embedVideo = (video) ->
      document.getElementById("embed").innerHTML = unescape(video.html)

    # This function loads the data from Vimeo
    init = ->
      js = document.createElement("script")
      js.setAttribute "type", "text/javascript"
      js.setAttribute "src", url
      document.getElementsByTagName("head").item(0).appendChild js

    # This is the URL of the video you want to load
    videoUrl = "http://www.vimeo.com/7100569"

    # This is the oEmbed endpoint for Vimeo (we're using JSON)
    endpoint = "http://www.vimeo.com/api/oembed.json"

    # Tell Vimeo what function to call
    callback = "embedVideo"

    url = endpoint + "?url=" + encodeURIComponent(videoUrl) + "&callback=" + callback + "&width=640"

    # Call our init function when the page loads
    window.onload = init

    ###








tags:           [ '100% onafhankelijk assurantietussenpersoon',
'verzekering', 'lijfrente', 'risiscoadviseurs',
'eigen bedrijfspand', 'arbeidsongeschiktheid', 'personeel aannemen' ]