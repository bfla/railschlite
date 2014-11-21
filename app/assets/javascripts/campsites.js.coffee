# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Call this from the campsite show view
# Otherwise, it will get called for every view, which is bad because...
# ... it will throw an error because there is no appropriate div to place it in.

$ () =>
  # Apply hover effect to campsite thumbnails
  $(".nearby-thumb").hover ->
    nearbyThumbHoverEffect $(this)
    return

@makeCampsiteMap = () ->
  map = L.mapbox.map("campsiteMap", "campawesome.h5d0p7ea").setView(gon.initCenter, 13) # initialize the map
  map.scrollWheelZoom.disable()
  map.touchZoom.disable()
  map.markerLayer.setGeoJSON(gon.geoJson) # set the markers

# Apply hover effect to nearby thumbnails
nearbyThumbHoverEffect = (target) ->
  unless target.attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
    if target.attr("style") is "border: 1px solid #b7b7b7;"
      target.removeAttr "style"
    else
      target.attr "style", "border: 1px solid #b7b7b7;"
  return