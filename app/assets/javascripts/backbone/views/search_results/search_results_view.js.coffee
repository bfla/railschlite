Chlite.Views.SearchResults ||= {}

class Chlite.Views.SearchResults.SearchResultsView extends Backbone.View
  template: JST["backbone/templates/search_results/search_results"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
