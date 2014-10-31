class Chlite.Models.SearchResult extends Backbone.Model
  defaults:
    id: null
    name: null
    state_abbrev: null
    latitude: null
    longitude: null
    elevation: null
    url: null
    backcountry: null
    rustic: null
    rv: null
  geojsonify: =>
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
        popup_url: "campsites/" + @.get('url')
        'marker-color': "\#09b"
        'marker-symbol': 'campsite'
        'marker-size': 'large'

class Chlite.Collections.Search extends Backbone.Collection
  model: Chlite.Models.SearchResult
  geojsonify: => #return an array of geojsonified results
    geoArr = new Array()
    geoArr = @.map (cg) -> 
      cg.geojsonify()