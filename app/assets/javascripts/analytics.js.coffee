$ ->
  # Navbar search tracker
  $('.navbar-search-tracker').on 'click', ->
    ga 'send', 'event', 'button', 'click', 'dropdown | navbar'
    console.log 'Tracked event'

$ ->
  # Track unbuilt features to see which are being clicked
  $(['data-unbuilt-feature']).on 'click', ->
    ga 'send', 'event', 'button', 'click', $(this).data('unbuilt-feature')
    console.log 'Tracked event'

$ ->
  # Generic trackers
  $(['data-tracker']).on 'click', ->
    ga 'send', 'event', 'button', 'click', $(this).data('tracker')
    console.log 'Tracked event'
