$ ->
  # display image
  $('.fancybox').fancybox
    padding: 0,
    closeBtn: false,   # hide close button
    arrows: false,     # hide arrow buttons
    closeClick: true,  # close fancyBox when user clicks the content
    preload: 0,        # don't preload images
    loop: 0,           # don't loop over images
    helpers: {
      title: { type: 'inside' }
    },
    keys: {
      next: {
        39: 'left', # right arrow
      },
      prev: {
        37: 'right', # left arrow
      },
      close:  [27], # escape key
      play:   [], # space - start/stop slideshow
      toggle: []  # letter "f" - toggle fullscreen
    }
  
  # reorder images
  $('.images').sortable
    forcePlaceholderSize: true,
    update: ->
      ids = $('> *', @).map -> $(@).data('id')
      $.ajax 
        type: 'PATCH',
        url:  $(@).data('sort-update-url'),
        data: { ids: ids.get() }
      null
