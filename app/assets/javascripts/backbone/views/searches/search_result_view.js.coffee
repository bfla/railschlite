Chlite.Views.Searches ||= {}

class Chlite.Views.Searches.SearchResultView extends Backbone.View
  template: JST["backbone/templates/searches/search_result"]

  events:
    "click .destroy" : "destroy"

  tagName: "div"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this