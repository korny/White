$(document)
  .on 'dragover',
    false
  .on 'dragenter', ->
    console.log 'dragenter', @
    $('body').addClass 'dragging'
  .on 'dragleave', ->
    console.log 'dragleave', @
    $('body').removeClass 'dragging'
  .on 'drop', (event) ->
    console.log 'drop'
    files = event.originalEvent.dataTransfer.files
    alert "You just dragged #{files.length} file(s) into the browser."
    false
