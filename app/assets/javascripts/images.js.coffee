$ ->
  # reorder images
  $('.images').sortable
    update: ->
      ids = $('> *', @).map -> $(@).data('id')
      $.ajax 
        type: 'PATCH',
        url:  $(@).data('sort-update-url'),
        data: { ids: ids.get() }
      null
