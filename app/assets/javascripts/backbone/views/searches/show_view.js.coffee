Chlite.Views.Searches ||= {}

class Chlite.Views.Searches.ShowView extends Backbone.View
  template: JST["backbone/templates/searches/show"]
  attributes:
    id: 'search-backbone-view'

  initialize: () ->
    @results = @options.search # The Backbone Collection representing search results
    @results.bind('reset', @populateResultList) #When search options.search is reset, repopulate the list
    @geojson = @options.search.geojsonify() # Convert campsites to geojson format for MapBox
    @filteredResults = @results
    
    # Search options... These next few are passed from the router and are required.
    @center = @options.center || [44.8961, -85.9983]
    @zoom = @options.zoom || 8
    @distance = @options.distance || 30
    @keywords = @options.keywords

    # DOM Elements
    @mapboxTarget = 'search-map' #MapBox wants the id (text without '#') of its target div
    @searchResetBtn = $("#search-reset")
    @resultsListDiv = $('#search-results-list')
    # @resetBtn = $('#map-reset-button')
    # @allTypesBtn = $('.')
    # @filterTypeBtn = $('.')

    # Filter data
    @filters = 
      all: true
      backcountry: false
      rustic: false
      rv: false
      reservable: false
      firstCome: false

  events:
    'click .vibe-filter': 'highlightActiveVibeFilter' # Highlight 
    'click .filter': 'editFilter' # Store the new filters
    'click .filter': 'filter' # Apply the new filter
    'click .reset-map': 'searchMapArea'
  #   'click .reset': 'resetSearch'
  #   'click .filter': 'filter'
  #    'render': 'renderMap @mapboxTarget, @center, @zoom)'

  populateResultList: (results) =>
    results.each(@addOneToResultList)

  addOneToResultList: (campsite) =>
    view = new Chlite.Views.Searches.SearchResultView({model : campsite})
    @resultsListDiv.append(view.render().el)

  highlightActiveVibeFilter: ->
    if $(this).hasClass('vibe-filter')
      @$('.vibe-filter').removeClass('active')
    $(this).addClass('active')

  filter: =>
    @filteredResults = @results
    i = 0
    # Remove any campsites that don't fit the criteria
    @filteredResults.each (result) =>
      @filteredResults.splice(i) if @filters.backcountry and !result.backcountry
      @filteredResults.splice(i) if @filters.rustic and !result.rustic
      @filteredResults.splice(i) if @filters.rv and !result.rv
      @filteredResults.splice(i) if @filters.reservable and !result.reservable
      @filteredResults.splice(i) if @filters.firstCome and !result.firstCome
      i++

    @resultsListDiv.empty() # Empty out the previous search results
    @populateResultList(@filteredResults) # Reset the search result list
    @filterMarkers(@filteredResults) # Reset the map marker layer

  editFilter: ->
    # Only one vibe filter can be active at any given time, so...
    if $(this).hasClass('vibe-filter')
      @filters.all = false
      @filters.backcountry = false
      @filters.rustic = false
      @filters.rv = false
    # Now apply 
    @filters.all = true if $(this).data('filter-name') is 'all'
    @filters.backcountry = true if $(this).data('filter-name') is 'backcountry'
    @filters.rustic = true if $(this).data('filter-name') is 'rustic'
    @filters.rv = true if $(this).data('filter-name') is 'rv'
    @filters.reservable = true if $(this).data('filter-name') is 'reservable'
    @filters.firstCome = true if $(this).data('filter-name') is 'firstCome'

  # Map functions =================================================================================================== 
  renderMap: (target, center, zoom) =>
    map = L.mapbox.map(target, "campawesome.h5d0p7ea").setView(@center, @zoom)
    map.zoomControl.setPosition('bottomright') # move the map zoom control
    myLayer = L.mapbox.featureLayer().addTo(map) # initialize featureLayer

    myLayer.on "layeradd", (e) ->
      marker = e.layer
      feature = marker.feature
      # Create custom popup content
      popupContent = "<a target=\"_blank\" class=\"popup searchTooltipLinkTracker\" 
        href=\"" + feature.properties.popup_url + 
        "\">" + "<p class=\"lead popupText\">" + 
        feature.properties.title + "</p></a>"
      # http://leafletjs.com/reference.html#popup
      marker.bindPopup popupContent,
        closeButton: true
        minWidth: 0

    myLayer.setGeoJSON(@geojson) # Add features to the map
    @map = map #Save the map so other functions can access it

  filterMarkers: =>
    # Do something.


  searchMapArea: =>
    currentCenter = @map.getCenter() # Current center of the map as Leaflet LatLng
    southWest = @map.getBounds().getSouthWest() # Returns the SW corner as LatLng
    distanceInMeters = currentCenter.distanceTo(southWest) # Distance to edge of map
    distanceInMiles = distanceInMeters * .000621371

    @results.refreshSearch(currentCenter['lat'], currentCenter['lng'], distanceInMiles)

    #params = $.param( { distance:distanceInMiles, lat:currentCenter['lat'], lng:currentCenter["lng"] }) # HTML parameters for request
    #url = "/campsites/search.json?" + params # The request url

    # Make ajax request for campsite JSON
    #$.getJSON(url, {}).done (data) ->
      #@searchResetBtn.hide() # Hide the reset button

      #stateObj = { search: "search" } # Obj for replaceState function (see next line)
      #history.replaceState(stateObj, "", "search.html?"+params) # Add the proper url to the browser
      
      # myLayer.setGeoJSON data
      # resetSearchList(params).done -> # Reset search list
      #   filterSearchResults() # Refilter search list
      #   return

    @filter # filter the results

  render: =>
    @$el.html(@template(search: @options.search.toJSON() )) # Add searches to the result list
    @populateResultList(@results) #Add search results to the result list
    # Note: we need to render the map after the view's DOM has already been rendered
    @$el.show () =>
      @renderMap @mapboxTarget, @center, @zoom
    return this

