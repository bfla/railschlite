Chlite.Views.Searches ||= {}

class Chlite.Views.Searches.ShowView extends Backbone.View
  template: JST["backbone/templates/searches/show"]

  # render: ->
  #   $(@el).html(@template(@model.toJSON() ))
  #   return this

  initialize: () ->
    # @options.model.campsites.bind('reset', @addAllToResultList) #Hmm...
    @options.search.bind('reset', @addAllToResultList)

  addAllToResultList: () =>
    # @options.model.campsites.each(@addOneToResultList)
    @options.search.each(@addOneToResultList)

  addOneToResultList: (campsite) =>
    # view = new Chlite.Views.Searches.SearchResultView({model : campsite})
    view = new Chlite.Views.Searches.SearchResultView({model : campsite})
    @$("#search-results-list").append(view.render().el)

