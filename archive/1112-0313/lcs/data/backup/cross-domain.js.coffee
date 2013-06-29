# # Cross-domain iframe  beveiliging workaround

# Demonstration of cross-domain security workaround
#   by Philip Hutchison, October 2010
#   MIT-style license. Use at your own risk.
#   This example's code can be made much more concise, but I'm using long form for clarity in the example
#   See explanation at http://pipwerks.com/2010/10/17/iframes-and-cross-domain-security-part-3/
#

# Returns boolean indicating whether parent frame is accessible
isSameDomain = ->

  # Using try/catch to check for top.location so we don't throw a JS error
  try
    return !!top.location.href
  catch e
    return false

# Internal document iframe proxy
useProxy = (msg) ->

  # The `var msg` will be sent to proxy HTML file via a querystring.
  # This function will prep the string, then send to proxy.
  querystring = window.location.href.split("?")[1] or false
  id = "proxyframe" #The name of the frame
  proxy = frames[id] #Look for existing frame with name "proxyframe"
  url_array = undefined
  root = ""
  pairs = undefined
  url = undefined
  return false  if not querystring or not msg

  # --- Prep/clean up string ---

  #Encode any question marks since they're reserved for querystrings
  msg = msg.replace(/\?/g, "%3F")

  #URI encode the entire string
  msg = encodeURI(msg)

  # --- Send to proxy via querystring ---

  #First we must determine what domain is hosting the proxy file
  #by examining the querystring for our custom 'root' parameter

  #Ensure all ampersands are single (not entities) so we can split using "&"
  querystring = querystring.replace(/&amp;/g, "&")
  pairs = querystring.split("&")

  #Loop through the pairs.
  i = 0

  while i < pairs.length
    if pairs[i].indexOf("root=") isnt -1

      #Extract the value from the string by replacing the
      #identifier/assignment portion of the string with nothing ""
      root = pairs[i].replace("root=", "")
      if root isnt ""

        #a root parameter was found. decode it.
        root = decodeURI(root)

        #replace parent page filename in root parameter
        #with proxy filename and querystring
        url_array = root.split("/")
        url_array[url_array.length - 1] = "proxy.html?msg=" + msg

        #Set new URL
        url = url_array.join("/")
      break #We only care about the 'root' parameter
    i++

  #If the proxy iframe has already been created, use it
  if proxy

    #Redirect to the new URL
    proxy.location.href = url

  #else create the proxy iframe
  else
    iframe = document.createElement("iframe")
    iframe.id = id
    iframe.name = id
    iframe.src = url
    iframe.style.display = "none"
    document.body.appendChild iframe

sendMessage = ->

  msg = document.getElementById("message").value

  #If domains match, no need for proxy workaround.
  if parent and isSameDomain()

    #Invoke parent's JavaScript directly
    top.showMessage msg
  else

    #Security restrictions prevent us from communicating
    #directly with parent. Must use proxy instead.
    useProxy msg
  false
