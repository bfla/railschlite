class Chlite.Models.SearchResult extends Backbone.Model
  defaults:
    id: null
    name: null
    slug: null
    state_abbrev: null
    latitude: null
    longitude: null
    elevation: null
    horse: null
    backcountry: null
    rustic: null
    rv: null
    
  geojsonifyCampsite: =>
    geojson =
      type: 'Feature'
      geometry:
        type: 'Point'
        coordinates: [@.get('longitude'), @.get('latitude')]
      properties:
        title: @.get('name')
        campsiteId:@.get('id')
        rustic:@.get('rustic')
        rv:@.get('rv')
        backcountry:@.get('backcountry')
        horse: @.get('horse')
        popup_url: '/campsites/' + @.get('slug')
        vibe_img: @.get('vibeImg')
        'marker-color': "\#09b"
        'marker-symbol': 'campsite'
        'marker-size': 'large'
    return geojson

class Chlite.Collections.Search extends Backbone.Collection
  model: Chlite.Models.SearchResult
  geojsonify: => #return an array of geojsonified results
    geoArr = new Array()
    geoArr = @.map (cg) -> 
      cg.geojsonifyCampsite()
    return geoArr
  refreshSearch: (lat, lng, distance)=>
    promise = $.Deferred()
    $.ajax
      url: '/searches.json'
      data:
        lat: lat
        lng: lng
        distance: distance
      success: (res) ->
        promise.resolve(res)
      failure: ->
        err = 'Search failed'
        promise.reject(err)
    return promise