$ ->
  # reorder sections
  if sortUpdateURL = $('.sidebar').data('sort-update-url')
    $('.sidebar').sortable
      axis: 'y'
      update: ->
        ids = $('> *', @).map -> $(@).data('id')
        $.ajax
          type: 'PATCH',
          url:  sortUpdateURL,
          data: { ids: ids.get() }
        null
  
$ ->
  # reorder pages
  $('.section ul[data-sort-update-url]').each ->
    sortUpdateURL = $(@).data('sort-update-url')
    $(@).sortable
      items: 'li[data-id]'
      axis: 'y'
      containment: 'parent'
      tolerance: 'pointer'
      update: ->
        ids = $('> *', @).map -> $(@).data('id')
        $.ajax
          type: 'PATCH',
          url:  sortUpdateURL,
          data: { ids: ids.get() }
        null
