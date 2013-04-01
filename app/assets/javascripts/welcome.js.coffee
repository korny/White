$(document)
  .on 'dragover',
    false  # required to make dragging work on Gecko
  .on 'drop', (event) ->
    $('body').removeClass 'dragging'
    files = event.originalEvent.dataTransfer.files
    window.setTimeout -> upload files
    false

$ ->
  draglevel = 0
  $('body')
  .on 'dragenter', ->
    if ++draglevel >= 1
      $('body').addClass 'dragging'
  .on 'dragleave', ->
    if --draglevel <= 0
      $('body').removeClass 'dragging'

progress = (event) ->
  if event.lengthComputable
    complete = event.loaded / event.total * 100 | 0
    $('#progress').val complete

upload = (files, index = 0) ->
  if file = files.item(index)
    formData = new FormData
    formData.append 'file', file
    
    $.ajax('/images',
      type: 'POST',
      data: formData,
      contentType: false,
      processData: false,
      xhr: ->
        xhr = jQuery.ajaxSettings.xhr()
        xhr.upload.addEventListener 'progress', progress, false
        xhr
      )
      .done (data, textStatus) ->
        upload files, index + 1
      .fail ->
        console.log 'Something went terribly wrong...'
    
    # preview
    acceptedTypes =
      'image/png': true
      'image/jpeg': true
      'image/gif': true
    if acceptedTypes[file.type]
      reader = new FileReader
      reader.onload = (event) ->
        image = new Image
        image.src = event.target.result
        image.width = 100  # a fake resize
        document.body.appendChild image
      
      reader.readAsDataURL file
