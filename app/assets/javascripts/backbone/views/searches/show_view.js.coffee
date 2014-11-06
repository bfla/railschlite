Chlite.Views.Searches ||= {}

class Chlite.Views.Searches.ShowView extends Backbone.View
  template: JST["backbone/templates/searches/show"]
  attributes:
    id: 'search-backbone-view'

  initialize: () ->
    @results = new Chlite.Collections.Search()
    @results = @results.reset @options.search["models"] # The Backbone Collection representing search results
    #@results = @options.search
    #@results.bind('reset', @populateResultList) #When search options.search is reset, repopulate the list
    @geojson = @options.search.geojsonify() # Convert campsites to geojson format for MapBox
    @filteredResults = new Chlite.Collections.Search()
    @filteredResults = @filteredResults.reset @results["models"]
    
    # Search options... These next few are passed from the router and are required.
    @center = @options.center || [44.8961, -85.9983]
    @zoom = @options.zoom || 8
    @distance = @options.distance || 30
    @keywords = @options.keywords

    # Filter data
    @filters = 
      all: true
      backcountry: false
      rustic: false
      rv: false
      reservable: false
      firstCome: false

  events:
    # 'click .vibe-filter': 'highlightActiveVibeFilter' # Highlight 
    'click .filter': 'filterWithButton' # Store the new filters
    'click #search-reset': 'searchMapArea'

  # Add campsite to the result list area
  populateResultList: (results) =>
    console.log 'Populating result list...'
    results.each(@addOneToResultList)

  addOneToResultList: (campsite) =>
    view = new Chlite.Views.Searches.SearchResultView({model : campsite})
    @$('#search-results-list').append(view.render().el)

  highlightActiveVibeFilter: ($target) =>
    if $target.hasClass('vibe-filter')
      @$('.vibe-filter').removeClass('active')
      $target.addClass('active')

  toggleMapResetButton: ->
    $target = @$('search-reset')
    $target.toggleClass('.hidden')
    $target.tooltip('show') unless $(target).hasClasS('hidden') # Show its tooltip

  # Filtering functions ===============================================================================
  
  filterResults: =>
    console.log 'Filtering results...'
    
    @filteredResults = @filteredResults.reset @results["models"]
    #@filteredResults = new Chlite.Collections.Search()
    #@filteredResults = @filteredResults.reset @options.search
    console.log @filteredResults

    # Remove any campsites that don't fit the criteria
    i = 0
    @filteredResults.each (result) =>
      @filteredResults.remove(@filteredResults.at(i)) if @filters.backcountry and !result.backcountry
      @filteredResults.remove(@filteredResults.at(i)) if @filters.rustic and !result.rustic
      @filteredResults.remove(@filteredResults.at(i)) if @filters.rv and !result.rv
      @filteredResults.remove(@filteredResults.at(i)) if @filters.reservable and !result.reservable
      @filteredResults.remove(@filteredResults.at(i)) if @filters.firstCome and !result.firstCome
      i++
      #console.log @filteredResults

    @$('#search-results-list').empty() # Empty out the previous search results
    @populateResultList(@filteredResults) # Reset the search result list
    @filterMarkers(@map, @markerlayer) # Reset the map marker layer

  filterWithButton: (e) =>
    $target = $(e.target)
    console.log 'Creating new filter:' + $target.data('filtername')
    
    # Only one vibe filter can be active at any given time so if one was clicked, set them all to null.
    if $target.hasClass('vibe-filter')
      @filters.all = false
      @filters.backcountry = false
      @filters.rustic = false
      @filters.rv = false
      @$('.vibe-filter').removeClass('active')
      @$('.vibe-filter').removeClass('btn-success')
      @$('.vibe-filter').addClass('btn-default')

    # Now add the new filter
    @filters.all = true if $target.data('filtername') is 'all'
    @filters.backcountry = true if $target.data('filtername') is 'backcountry'
    @filters.rustic = true if $target.data('filtername') is 'rustic'
    @filters.rv = true if $target.data('filtername') is 'rv'

    # These ones aren't vibe filters. They just need to be toggled...
    @filters.reservable = !@filters.reservable if $target.data('filtername') is 'reservable' 
    @filters.firstCome = !@filters.firstCome if $target.data('filtername') is 'firstCome'

    console.log(@filters)
    $target.toggleClass('active')
    $target.toggleClass('btn-default')
    $target.toggleClass('btn-success')
    @filterResults() # Now actually apply the new filter

  filterMarkers: (map, markers) =>
    console.log 'Filtering marker layer...'
    activeTribeId = $("#activeTribeId").val()
    activeReserveFilter = $("#activeReservableFilter").val()
    activeWalkinFilter = $("#activeWalkinsFilter").val()
    markers.setFilter (f) =>
      return false if @filters.backcountry and !f.properties["backcountry"]
      return false if @filters.rustic and !f.properties["rustic"]
      return false if @filters.rv and !f.properties["rv"]
      return false if @filters.reservable and !f.properties["reservable"]
      return false if @filters.firstCome and !f.properties["firstCome"]

  # Map functions =================================================================================================== 
  renderMap: (target, center, zoom) =>
    console.log 'Rendering map...'
    map = L.mapbox.map(target, "campawesome.h5d0p7ea").setView(@center, @zoom)
    map.zoomControl.setPosition('bottomright') # move the map zoom control
    @markerLayer = L.mapbox.featureLayer().addTo(map) # initialize featureLayer

    @markerLayer.on "layeradd", (e) ->
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

    @markerLayer = @markerLayer.setGeoJSON @geojson # Add features to the map
    @map = map #Save the map so other functions can access it

  searchMapArea: =>
    console.log 'Resetting search based on current map view...'
    currentCenter = @map.getCenter() # Current center of the map as Leaflet LatLng
    southWest = @map.getBounds().getSouthWest() # Returns the SW corner as LatLng
    distanceInMeters = currentCenter.distanceTo(southWest) # Distance to edge of map
    distanceInMiles = distanceInMeters * .000621371

    searchPromise = @results.refreshSearch(currentCenter['lat'], currentCenter['lng'], distanceInMiles)
    searchPromise.done( (res) =>
      @geojson = @results.geojsonify
      @markerLayer.setGeoJSON @geojson # Reset geojson with new data
      @filterResults # Add filtered results to view
      stateObj = { search: "search" } # Obj for replaceState function (see next line)
      params = $.param( { distance:distanceInMiles, lat:currentCenter['lat'], lng:currentCenter["lng"] })
      history.replaceState(stateObj, "", "search.html?"+params) # Add the proper url to the browser

    ).fail( (err) =>
      # Do something...
    )

  render: =>
    console.log 'Rendering view...'
    @$el.html(@template(search: @options.search.toJSON() )) # Add searches to the result list
    @populateResultList(@results) #Add search results to the result list
    # Note: we need to render the map after the view's DOM has already been rendered
    @$el.show () =>
      @renderMap 'search-map', @center, @zoom
    return this

