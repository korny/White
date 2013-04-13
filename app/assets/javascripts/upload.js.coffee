window.dragAndDropFileUploadTo = (uploadPath) ->
  console.log "Starting file uploader to #{uploadPath}…"
  
  $(document)
    .on 'dragover',
      false  # required to make dragging work on Gecko
    .on 'drop', (event) ->
      $('body').removeClass 'dragging'
      files = event.originalEvent.dataTransfer.files
      window.setTimeout -> upload files
      false
  
  ->
    draglevel = 0
    $('body')
    .on 'dragenter', ->
      if ++draglevel >= 1
        $('body').addClass 'dragging'
    .on 'dragleave', ->
      if --draglevel <= 0
        $('body').removeClass 'dragging'
  
  upload = (files, index = 0) ->
    if file = files.item index
      image = new Image
      image.width = 100  # a fake resize
      $('.images').append $(image).wrap('<div class="image" />').parent()
      $progress = $ '<progress min=0 max=100 value=0>'
      progress = (event) ->
        if event.lengthComputable
          $progress.val event.loaded / event.total * 100 | 0
      $(image).after $progress
      
      formData = new FormData
      formData.append 'file', file
      
      $.ajax(uploadPath,
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
          image.src = data.url
          $(image).next('progress').remove()
          $(image).on 'loaded', ->
            $(@).removeAttr 'width'
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
          image.src = event.target.result
        
        reader.readAsDataURL file
