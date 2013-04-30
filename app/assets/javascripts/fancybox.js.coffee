$ ->
  # display image
  $('.images .fancybox').fancybox
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
    },
    beforeLoad: ->
      this.title = $('.title', this.element).html()
  
  $(document).on 'keyup', '.fancybox-title input', (event) ->
    if event.which == 13
      $(this).closest('form').submit()
