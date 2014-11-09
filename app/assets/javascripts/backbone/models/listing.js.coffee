class Chlite.Models.Listing extends Backbone.Model
  paramRoot: 'listing'

  defaults:
  	name: null
  	state_abbrev: null
  	latitude: null
  	longitude: null
  	one_liner: null
  	overview: null
  	host_name: null
  	host_description: null
  	rv: null
  	rustic: null
  	backcountry: null
  	horse: null
  	showers: null
    electricity: null
    twenty_amp: null
    thirty_amp: null
    fifty_amp: null
  	water_hookup: null
  	sewer_hookup: null
    wifi: null
    cable: null
    pool: null
    laundry: null


class Chlite.Models.GuideBook extends Backbone.Model
  paramRoot: 'guidebook'
  defaults:

class Chlite.Models.GuidePost extends Backbone.Model
  defaults:
    longitude: null
    latitude: null
    description: null

class Chlite.Collections.ListingsCollection extends Backbone.Collection
  model: Chlite.Models.Listing
  url: '/listings'
