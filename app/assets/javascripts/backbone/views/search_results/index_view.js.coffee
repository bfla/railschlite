Chlite.Views.SearchResults ||= {}

class Chlite.Views.SearchResults.IndexView extends Backbone.View
  template: JST["backbone/templates/search_results/index"]

  initialize: () ->
    @options.searchResults.bind('reset', @addAll)

  addAll: () =>
    @options.searchResults.each(@addOne)

  addOne: (searchResults) =>
    view = new Chlite.Views.SearchResults.SearchResultsView({model : searchResults})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(searchResults: @options.searchResults.toJSON() ))
    @addAll()

    return this
