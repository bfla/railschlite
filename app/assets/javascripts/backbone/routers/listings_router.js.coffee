class Chlite.Routers.ListingsRouter extends Backbone.Router
  initialize: (options) ->
    @listing = new Chlite.Models.Listing()
    @listing = @listing.reset(@options.listing) if @options?.listing?
    # @listings = new Chlite.Collections.ListingsCollection()
    # @listings.reset options.listing

  routes:
    # "new"      : "newListing"
    # "index"    : "index"
    # ":id/edit" : "edit"
    # ":id"      : "show"
    # ".*"        : "index"
    ".*" : "edit"

  edit: ->
    @view = new Chlite.Views.Listings.EditView(model: @listing)
    # $("#listings").html @view.render().el
    $('[data-router="listings"]').html(@view.render().el)

  # overview: ->
  #   listing = options.listing
  # amenities: ->
  #   listing = options.listing

  # newListing: ->
  #   @view = new Chlite.Views.Listings.NewView(collection: @listings)
  #   $("#listings").html(@view.render().el)

  # index: ->
  #   @view = new Chlite.Views.Listings.IndexView(listings: @listings)
  #   $("#listings").html(@view.render().el)

  # show: (id) ->
  #   listing = @listings.get(id)

  #   @view = new Chlite.Views.Listings.ShowView(model: listing)
  #   $("#listings").html(@view.render().el)

  # edit: (id) ->
  #   listing = @listings.get(id)

  #   @view = new Chlite.Views.Listings.EditView(model: listing)
  #   $("#listings").html(@view.render().el)
