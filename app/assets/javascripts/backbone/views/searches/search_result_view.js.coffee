Chlite.Views.Searches ||= {}

class Chlite.Views.Searches.SearchResultView extends Backbone.View
  template: JST["backbone/templates/searches/search_result"]

  events:
    "click .destroy" : "destroy"

  tagName: "div"

  vibeImgPath: =>
    if @model.get('horse') then path = '/images/icons/Horse120.png'
    else if @model.get('backcountry') then path = '/images/icons/Backcountry120.png'
    else if @model.get('rv') then path = '/images/icons/RV120.png'
    else path = '/images/icons/Rustic120.png'

  campsitePath: =>
    '/campsites/' + @model.get('slug')

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template({model: @model.toJSON(), vibeImgPath:@vibeImgPath(), campsitePath:@campsitePath() }))
    return this