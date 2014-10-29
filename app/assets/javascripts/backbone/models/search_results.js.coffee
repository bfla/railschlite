class Chlite.Models.SearchResults extends Backbone.Model
  paramRoot: 'search_result'

  defaults:
    name: null
    state_abbrev: null
    latitude: null
    longitude: null
    elevation: null
    phone: null
    electric_sites: null
    showers: null
    outhouse: null
    dump: null
    url: null
    plumbing: null
    water: null
    tent_allowed: null
    rv_allowed: null
    walkin: null
    hikein: null
    boatin: null
    rustic: null
    rv: null
    backcountry: null
    horse: null
    likely_toilets: null
    no_toilets: null
    electricity: null
    city_name: null
    sewer_hookup: null
    fifty_amp: null
    thirty_amp: null
    twenty_amp: null
    pull_thrus: null
    wifi: null
    laundry: null
    beach: null
    on_lake: null
    on_river: null

class Chlite.Collections.SearchResultsCollection extends Backbone.Collection
  model: Chlite.Models.SearchResults
  url: '/search_results'
