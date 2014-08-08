# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Creates search page map
# Call this from the search view/template.
# If you try to include it in every view, then it will throw an error

$ ->
  $('#searchReset').hide() # Hide the map reset button
  # FIX THIS - TOOLTIP IS MALFUNCTIONING
  #$('.add-tooltip').tooltip()
  #$('#searchReset').tooltip('hide') # Hide the map reset tooltip
  highlightSearchThumbnail($('#allSearchFilter')) # highlight the selected thumbnail in green

  # Apply hover effect
  $(".searchFilterThumbnail").hover ->
    searchHoverEffect( $(this) )
    return

@makeSearchMap = (center, zoom, geoJson) ->
  map = L.mapbox.map("resultsMap", "campawesome.h5d0p7ea").setView(center, zoom)
  map.zoomControl.setPosition('bottomright') # move the map zoom control
  myLayer = L.mapbox.featureLayer().addTo(map) # initialize featureLayer

  myLayer.on "layeradd", (e) ->
    marker = e.layer
    feature = marker.feature
    # Create custom popup content
    popupContent = "<a target=\"_blank\" class=\"popup searchTooltipLinkTracker\" href=\"" + feature.properties.popup_url + "\">" + "<p class=\"lead popupText\">" + feature.properties.title + "</p></a>"
    # http://leafletjs.com/reference.html#popup
    marker.bindPopup popupContent,
      closeButton: true
      minWidth: 0
    return

  # Add features to the map
  myLayer.setGeoJSON(gon.geoJson)
  # Several of the search page behaviors require the map object
  # So... One the map object is created, pass it to this function.
  setupSearchPage(map)

# Some of these behaviors require 
setupSearchPage = (map) ->
  #When the map moves, show the map reset button
  # FIX THESE - TOOLTIP IS MALFUNCTIONING
  #map.on "moveend", (e) ->
    #$("#searchReset").show()
    #$("#searchReset").tooltip "show"
    #return

  #map.on "zoomend", (e) ->
    #$("#searchReset").show()
    #$("#searchReset").tooltip "show"
    #return

  # Set click behaviors for filters
  $(".searchFilterThumbnail").click ->
    highlightSearchThumbnail($(this))
    filterId = $(this).data('tribe-id')
    changeTribeFilter(filterId)
    filterSearchResults() # Filter the list of search results
    #filterSearchMarkers(map) # Filter the search markers
    return

  # Set click behaviors for map reset button
  $('#searchReset').click ->
    resetMapArea(map)
    return

# Apply highlight affect to selected thumbnails ================================================
highlightSearchThumbnail = (target) ->
  unless target.attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
    $("#allSearchFilter").removeClass('.activeSearchFilter')
    $(".searchFilterThumbnail").removeAttr "style"
    target.attr "style", "border: 2px solid #65b045; background:#d5eacb;"
    
# add effect to filter thumbnails on hover
searchHoverEffect = (target) ->
  unless target.attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
    if target.attr("style") is "border: 1px solid #b7b7b7;"
      target.removeAttr "style"
    else
      target.attr "style", "border: 1px solid #b7b7b7;"
  return

# Stores an input value to remember which tribe filter is being applied
changeTribeFilter = (filterId) ->
  $("#activeTribeId").val(filterId)

resetMapArea = (map) ->
  currentCenter = map.getCenter() # Current center of the map as Leaflet LatLng
  southWest = map.getBounds().getSouthWest() # Returns the SW corner as LatLng
  distanceInMeters = currentCenter.distanceTo(southWest) # Distance to edge of map
  distanceInMiles = distanceInMeters * .000621371
  centerString = currentCenter['lat'].toString()+', '+currentCenter['lng'].toString() # Reformat coordinates
  params = $.param( { distance:distanceInMiles, keywords:centerString }) # HTML parameters for request
  url = "/campsites/search.json?" + params # The request url
  stateObj = { search: "search" } # Obj for replaceState function (see next line)
  history.replaceState(stateObj, "", "search.html?"+params) # Add the proper url to the browser
  alert "fetching new JSON"

  # Make ajax request for campsite JSON
  $.getJSON(url, {}).done (data) ->
    $("#searchReset").hide() # Hide the reset button
    
    myLayer.setGeoJSON data
    resetSearchList(params).done -> # Reset search list
      filterSearchResults() # Refilter search list
      return

    filterId = $("#activeTribeId").val() # Get active tribe Filter
    filterSearchMarkers map # Refilter map markers
    return

filterSearchMarkers = (map) ->
  activeTribeId = $("#activeTribeId").val()
  activeReserveFilter = $("#activeReservableFilter").val()
  activeWalkinFilter = $("#activeWalkinsFilter").val()
  myLayer.setFilter (f) ->
    
    # Test if it passes the tribe filter
    tribeBool = false
    unless activeTribeId is 0
      for x of f.properties["tribes"]
        tribeBool = true  if f.properties["tribes"][x] is activeTribeId
    else
      tribeBool = true
    
    # Test if it passes the reserve filter
    reserveBool = false
    if activeReserveFilter is "true" and f.properties["reservable"] is true
      reserveBool = true
    else reserveBool = true  if activeReserveFilter is "false"
    
    # Test if it passes the walkin filter
    walkinBool = false
    if activeWalkinFilter is "true" and f.properties["walkin"] is true
      walkinBool = true
    else walkinBool = true  if activeWalkinFilter is "false"
    
    # Show marker only if it meets the conditions
    true  if reserveBool and tribeBool and walkinBool

  return

resetSearchList = (params) ->
  $(".results").empty() # Clear the result list
  $(".results").html "<h3 class='greenify text-center'> Activating Camp-Ray vision...<br>Defeating forces of evil... <br>Superspeeding...</h3>"
  
  # Make an ajax call to get the new html
  # var targetUrl = "http://http://localhost:3000/campsites/resetSearch.html?"+params;
  #var targetUrl = "http://http://gentle-ocean-6036.herokuapp.com/campsites/resetSearch.html?"+params;
  targetUrl = "/campsites/resetSearch.html?" + params
  targetUrl = targetUrl + params
  
  #alert('started fetching new search list...');
  $.get targetUrl, (newHtml) ->
    
    #alert('completed get for new html...');
    $(".results").empty()
    $(".results").html newHtml # Add the new results
    return

  return

filterSearchResults = (params) ->
  $(".searchResult").hide() # Hide all search results
  
  # Now we'll determine which results fit all the criteria and show only them
  $(".searchResult").each ->
    targetResult = $(this)
    showMeBool = true
    #For convenience, numbers (the "activeTribeId) are used to represent filters
    # 0 = All, 1 = Rustic, 2 = RV, 3 = Backcountry
    activeTribeId = $("#activeTribeId").val()
    
    # First apply the active tribe filter, if any
    if activeTribeId isnt "0"
      showMeBool = false
      if activeTribeId is "1" and targetResult.data("rustic") #Rustic filter is on
        targetResult.show() 
        return
      if activeTribeId is "2" and targetResult.data("rv") # RV filter is on
        targetResult.show()
        return
      if activeTrbeId is "3" and targetResult.data("backcountry") # Backcountry filter on
        targetResult.show()
        return 

    # Show the result only if it passed all the tests
    targetResult.show() if showMeBool
    return

  return



