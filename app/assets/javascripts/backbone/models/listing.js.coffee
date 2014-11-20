class Chlite.Models.Listing extends Backbone.Model
  paramRoot: 'listing'

  defaults:
    id: null
    name: null
    latitude: null
    longitude: null
    one_liner: null
    summary: null
    rules: null
    restroom: null
    showers: null
    electricity: null
    twenty_amp: null
    thirty_amp: null
    fifty_amp: null
    dump: null
    water_hookup: null
    sewer_hookup: null
    pull_thrus: null
    wifi: null
    laundry: null
    beach: null
    on_lake: null
    on_river: null
    wifi: null
    cable: null
    pool: null
    laundry: null
    pets_allowed: null
    pets_restricted: null
    alcohol_restricted: null


class Chlite.Collections.GuideBook extends Backbone.Model
  model: Chlite.Models.GuidePost
  url: '/guidebooks'

class Chlite.Models.GuidePost extends Backbone.Model
  defaults:
    longitude: null
    latitude: null
    description: null

class Chlite.Collections.ListingsCollection extends Backbone.Collection
  model: Chlite.Models.Listing
  url: '/listings'
