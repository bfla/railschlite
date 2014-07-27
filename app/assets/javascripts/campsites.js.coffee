# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  #makeCampsiteMap(gon.initCenter, 9, gon.geoJson)
  map = L.mapbox.map("campsiteMap", "campawesome.h5d0p7ea").setView(gon.initCenter, 13) # initialize the map
  map.scrollWheelZoom.disable()
  map.touchZoom.disable()
  map.markerLayer.setGeoJSON(gon.geoJson) # set the markers

#makeCampsiteMap = (center, zoom, geoJson) ->
  #map = L.mapbox.map("campsiteMap", "campawesome.h5d0p7ea").setView(center, zoom) # initialize the map
  #map.markerLayer.setGeoJSON(geoJson) # set the markers