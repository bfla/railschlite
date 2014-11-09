Chlite.Views.Listings ||= {}

class Chlite.Views.Listings.NewView extends Backbone.View
  template: JST["backbone/templates/listings/new"]

  events:
    "submit #new-listing": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (listing) =>
        @model = listing
        window.location.hash = "/#{@model.id}"

      error: (listing, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
