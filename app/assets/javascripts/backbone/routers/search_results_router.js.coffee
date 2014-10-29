class Chlite.Routers.SearchResultsRouter extends Backbone.Router
  initialize: (options) ->
    @searchResults = new Chlite.Collections.SearchResultsCollection()
    @searchResults.reset options.searchResults

  routes:
    "new"      : "newSearchResults"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSearchResults: ->
    @view = new Chlite.Views.SearchResults.NewView(collection: @search_results)
    $("#search_results").html(@view.render().el)

  index: ->
    @view = new Chlite.Views.SearchResults.IndexView(search_results: @search_results)
    $("#search_results").html(@view.render().el)

  show: (id) ->
    search_results = @search_results.get(id)

    @view = new Chlite.Views.SearchResults.ShowView(model: search_results)
    $("#search_results").html(@view.render().el)

  edit: (id) ->
    search_results = @search_results.get(id)

    @view = new Chlite.Views.SearchResults.EditView(model: search_results)
    $("#search_results").html(@view.render().el)
