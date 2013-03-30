$(document)
  .on 'dragover',
    false  # required to make dragging work on Gecko
  .on 'dragenter', ->
    $('body').addClass 'dragging'
  .on 'dragleave', ->
    $('body').removeClass 'dragging'
  .on 'drop', (event) ->
    files = event.originalEvent.dataTransfer.files
    window.setTimeout -> upload files
    false

upload = (files, index = 0) ->
  if file = files.item(index)
    formData = new FormData
    formData.append 'file', file
    
    $.ajax('/images', type: 'POST', data: formData, contentType: false, processData: false)
      .done (data, textStatus) ->
        upload files, index + 1
      .fail ->
        console.log 'Something went terribly wrong...'
