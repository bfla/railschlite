Chlite.Views.Listings ||= {}

class Chlite.Views.Listings.EditView extends Backbone.View
  template : JST["backbone/templates/listings/edit"]

  events :
    "submit #edit-listing" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (listing) =>
        @model = listing
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
