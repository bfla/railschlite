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
      horse: false

  events:
    # 'click .vibe-filter': 'highlightActiveVibeFilter' # Highlight 
    'click .filter': 'filterWithButton' # Store the new filters
    'click #search-reset': 'searchMapArea'
    'click #panel-close': 'hidePanel'

  render: =>
    console.log 'Rendering view...'
    @$el.html(@template(search: @options.search.toJSON(), filteredResults: @filteredResults )) # Add searches to the result list
    @populateResultList(@results) #Add search results to the result list
    # Note: we need to render the map after the view's DOM has already been rendered
    @addResultsCount()
    @setNotifications()
    @$el.show () =>
      @renderMap 'search-map', @center, @zoom
    return this

  # Functions to help with display and rendering ============================================================
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

  # Hide the map reset button when appropriate
  toggleMapResetButton: ->
    $target = @$('search-reset')
    $target.toggleClass('.hidden')
    $target.tooltip('show') unless $(target).hasClasS('hidden') # Show its tooltip

  # Add message to the search results list
  addResultsCount: =>
    count = @filteredResults.length
    switch count
      when 0 then msg = "0 matches. Bummer. Perhaps widen your search?"
      when 1 then msg = "CampHero's supervision found 1 match."
      else msg = "Bam! CampHero's supervision found " + count + " matches."
    @$('#results-count').html msg

  hidePanel: =>
    @$('.panel').hide()

  setNotifications: =>
    if @results == 200
      @$('#map-notice-text').html 'Cool beans. There are more than 200 campgrounds in this area. Narrow your search area to see more campgrounds.'
      @$('#map-notice').removeClass('hidden')
    else
      @$('#map-notice').addClass('hidden') unless @$('#map-notice').hasClass('hidden')
      @$('#map-notice').html ''

  # Filtering functions ===============================================================================
  
  filterWithButton: (e) =>
    $target = $(e.target)
    console.log 'Creating new filter:' + $target.data('filtername')
    
    # Only one vibe filter can be active at any given time so if one was clicked, set them all to null.
    if $target.hasClass('vibe-filter')
      @filters.all = false
      @filters.backcountry = false
      @filters.rustic = false
      @filters.rv = false
      @filters.horse = false
      @$('.vibe-filter').removeClass('active')
      @$('.vibe-filter').removeClass('btn-success')
      @$('.vibe-filter').addClass('btn-default')

    # Now add the new filter
    if $target.data('filtername') is 'all' then @filters.all = true 
    else if $target.data('filtername') is 'horse' then @filters.horse = true
    else if $target.data('filtername') is 'backcountry' then @filters.backcountry = true
    else if $target.data('filtername') is 'rv' then @filters.rv = true 
    else if $target.data('filtername') is 'rustic' then @filters.rustic = true

    console.log(@filters)
    $target.toggleClass('active')
    $target.toggleClass('btn-default')
    $target.toggleClass('btn-success')
    @filterResults() # Now actually apply the new filter

  filterResults: =>
    console.log 'Filtering results...'
    @filteredResults = new Chlite.Collections.Search()
    @filteredResults = @filteredResults.reset @results["models"]

    # Remove any campsites that don't fit the criteria
    i = 0
    @filteredResults.each (result) =>
      # @filteredResults.remove(@filteredResults.at(i)) if @filters.backcountry and not result.get('backcountry')
      # @filteredResults.remove(@filteredResults.at(i)) if @filters.rustic and not result.get('rustic')
      # @filteredResults.remove(@filteredResults.at(i)) if @filters.rv and not result.get('rv')
      # @filteredResults.remove(@filteredResults.at(i)) if @filters.horse and not result.get('horse')
      # i++
      if @filters.rustic
        @filteredResults = @filteredResults.reset( @results.where({rustic: true}) )
      else if @filters.rv
        @filteredResults = @filteredResults.reset( @results.where({rv: true}) )
      else if @filters.backcountry
        @filteredResults = @filteredResults.reset( @results.where({backcountry: true}) )
      else if @filters.horse
        @filteredResults = @filteredResults.reset( @results.where({horse: true}) )
      i++

    @$('#search-results-list').empty() # Empty out the previous search results
    @populateResultList(@filteredResults) # Reset the search result list
    @filterMarkers() # Reset the map marker layer
    @addResultsCount()
    @setNotifications()

  filterMarkers: =>
    console.log 'Filtering marker layer...'
    filteredGeojson = @filteredResults.geojsonify()
    @markerLayer = @markerLayer.setGeoJSON filteredGeojson

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
    distanceInMiles = Math.round(distanceInMeters * .000621371) # Rounded to nearest integer
    lat = currentCenter['lat'].toFixed(5) # Round to 5 decimal places
    lng = currentCenter['lng'].toFixed(5)

    searchPromise = @results.refreshSearch(lat, lng, distanceInMiles)
    searchPromise.done( (res) =>
      @results = @results.reset res
      # @geojson = @results.geojsonify
      # @markerLayer.setGeoJSON @geojson # Reset geojson with new data
      @filterResults() # Add filtered results to view

      stateObj = { search: "search" } # Obj for replaceState function (see next line)
      params = $.param( { distance:distanceInMiles, lat:lat, lng:lng })
      history.replaceState(stateObj, "", "searches?"+params) # Add the proper url to the browser

    ).fail( (err) =>
      # Do something...
    )

