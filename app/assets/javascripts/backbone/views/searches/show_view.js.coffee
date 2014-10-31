Chlite.Views.Searches ||= {}

class Chlite.Views.Searches.ShowView extends Backbone.View
  template: JST["backbone/templates/searches/show"]
  attributes:
    id: 'search-backbone-view'

  initialize: () ->
    @results = @options.search # The Backbone Collection representing search results
    @results.bind('reset', @populateResultList) #When search options.search is reset, repopulate the list
    @geojson = @options.search.geojsonify() # Convert campsites to geojson format for MapBox
    
    # Search options... These next few are passed from the router and are required.
    @center = @options.center || [44.8961, -85.9983]
    @zoom = @options.zoom || 8
    @distance = @options.distance || 30
    @keywords = @options.keywords

    # DOM Elements
    @mapboxTarget = 'search-map' #MapBox wants the id (text without '#') of its target div
    # @resetBtn = $('#map-reset-button')
    # @allTypesBtn = $('.')
    # @filterTypeBtn = $('.')

    # Filtering variables
    @filters = 
      vibe: 'all'
      reservable: false
      walkin: false

  # events:
  #   'click .reset': 'resetSearch'
  #   'click .filter': 'filter'
  #    'render': 'renderMap @mapboxTarget, @center, @zoom)'

  populateResultList: () =>
    @results.each(@addOneToResultList)

  addOneToResultList: (campsite) =>
    view = new Chlite.Views.Searches.SearchResultView({model : campsite})
    @$("#search-results-list").append(view.render().el)

  renderMap: (target, center, zoom) =>
    map = L.mapbox.map(target, "campawesome.h5d0p7ea").setView(@center, @zoom)
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

    myLayer.setGeoJSON(@geojson) # Add features to the map
    @map = map #Save the map so other functions can access it

  render: =>
    @$el.html(@template(search: @options.search.toJSON() )) # Add searches to the result list
    @populateResultList() #Add search results to the result list
    # Note: we need to render the map after the view's DOM has already been rendered
    @$el.show () =>
      @renderMap @mapboxTarget, @center, @zoom
    return this

