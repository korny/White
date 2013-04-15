$ ->
  # display image
  $('.fancybox').fancybox
    padding: 0
    closeBtn: false,   # hide close button
    arrows: false,     # hide arrow buttons
    closeClick: true,  # close fancyBox when user clicks the content
    preload: 0,        # don't preload images
    wrapCSS: 'border: 2px solid red',
    helpers: { overlay: { css: { background: 'white' } } }
  
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
