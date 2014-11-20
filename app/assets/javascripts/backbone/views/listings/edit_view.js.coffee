Chlite.Views.Listings ||= {}

class Chlite.Views.Listings.EditView extends Backbone.View
  template : JST["backbone/templates/listings/edit"]
  controlsTemplate: JST["backbone/templates/listings/controls"]
  overviewTemplate: JST["backbone/templates/listings/overview"]
  amenitiesTemplate: JST["backbone/templates/listings/amenities"]
  detailsTemplate: JST["backbone/templates/listings/details"]
  #photosTemplate : JST["backbone/templates/listings/photos"]
  #guidebookTemplate : JST["backbone/templates/listings/guidebook"]
  # @listing = new Chlite.Models.Listing()
  # @listing = @listing.reset(@options.listing) if @options?.listing?

  events:
    'click [data-link]': 'switchEditPanel'

  switchEditPanel: (e) =>
    e.preventDefault()
    $target = $(e.target)
    console.log $target
    switch $target.data('link')
      when 'overview' then @renderOverview()
      when 'amenities' then @renderAmenities()
      when 'details' then @renderDetails()

  highlightActiveControl: (action) =>
    @$('.listing-control').removeClass('active')
    @$('[data-link="' + action + '"]').closest('li').addClass('active')

  renderControls: =>
    @$('[data-view="edit-listing-controls"]').html @controlsTemplate()

  renderOverview: =>
    # @$('[data-view="edit-listing-form"]').html @overviewTemplate( model: @listing )
    # @$("form").backboneLink @listing
    @$('[data-view="edit-listing-form"]').html @overviewTemplate( @model )
    @$("form").backboneLink(@model)
    @highlightActiveControl('overview')

  renderAmenities: =>
    @$('[data-view="edit-listing-form"]').html @amenitiesTemplate( @model )
    @$("form").backboneLink @model
    @highlightActiveControl('amenities')

  renderDetails: =>
    @$('[data-view="edit-listing-form"]').html @detailsTemplate( @model )
    @$("form").backboneLink @model
    @highlightActiveControl('details')

  render: =>
    # @$el.html( @template(listing: @listing) )
    @$el.html( @template(@model.toJSON() ))
    @renderControls()
    @renderOverview()
    return this