$ ->
  $('.navbar-search-tracker').on 'click', ->
    ga 'send', 'event', 'button', 'click', 'dropdown | navbar'
    return