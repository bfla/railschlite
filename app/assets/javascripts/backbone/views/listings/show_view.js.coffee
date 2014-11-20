Chlite.Views.Listings ||= {}

class Chlite.Views.Listings.ShowView extends Backbone.View
  template: JST["backbone/templates/listings/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this