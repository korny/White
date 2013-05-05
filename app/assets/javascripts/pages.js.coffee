$(document).on 'click', '.edit-page-text', ->
  $(@).next('form').andSelf().toggle()
