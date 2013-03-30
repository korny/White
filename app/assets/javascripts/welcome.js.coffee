$(document)
  .on 'dragover',
    false  # required to make dragging work on Gecko
  .on 'dragenter', ->
    $('body').addClass 'dragging'
  .on 'dragleave', ->
    $('body').removeClass 'dragging'
  .on 'drop', (event) ->
    files = event.originalEvent.dataTransfer.files
    alert "You just dragged #{files.length} file(s) into the browser."
    false
