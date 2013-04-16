$ ->
  # reorder images
  if sortUpdateURL = $('.images').data('sort-update-url')
    $('.images').sortable
      update: ->
        ids = $('> *', @).map -> $(@).data('id')
        $.ajax
          type: 'PATCH',
          url:  sortUpdateURL,
          data: { ids: ids.get() }
        null
