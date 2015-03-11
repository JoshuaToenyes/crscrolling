velocityStop = null


##
# @param {number} v - Scroll velocity in pixels per millisecond.
startScroll = (x, y) ->
  start = null
  top   = document.body.scrollTop
  left  = document.body.scrollLeft
  end   = false

  if x is 0 and y is 0 then return

  scrollStep = (ts) ->
    if !start then start = ts
    progress = ts - start
    window.scrollTo left + progress * x, top + progress * y
    if !end then window.requestAnimationFrame scrollStep

  window.requestAnimationFrame scrollStep

  return -> end = true


module.exports =

  ##
  # Sets the document's scrolling velocity in pixels per second.
  #
  # @param {number} x - Scroll velocity in x-direction (in pixels per second).
  # @param {number} y - Scroll velocity in y-direction (in pixels per second).
  velocity: (x, y) ->
    x = +x / 1000
    y = +y / 1000
    if velocityStop? then velocityStop()
    velocityStop = startScroll(x, y)
    return
