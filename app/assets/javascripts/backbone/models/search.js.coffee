class Chlite.Models.SearchResult extends Backbone.Model
  defaults:
    id: null
    name: null
    state_abbrev: null
    latitude: null
    longitude: null
    elevation: null

# class Chlite.Collections.SearchesCollection extends Backbone.Collection
#   model: Chlite.Models.Result
#   url: '/searches'

# class Chlite.Models.Search extends Backbone.Model
#   paramRoot: 'search'

#   defaults:
#     keywords: null
#     distance: null
#     zoom: null
#     campsites: []

class Chlite.Collections.Search extends Backbone.Collection
  model: Chlite.Models.SearchResult