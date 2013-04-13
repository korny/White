$ ->
  $('.images').sortable
    forcePlaceholderSize: true,
    update: ->
      ids = $('> *', @).map -> $(@).data('id')
      console.log ids
      $.ajax 
        type: 'PATCH',
        url:  $(@).data('sort-update-url'),
        data: { ids: ids.get() }
      null
