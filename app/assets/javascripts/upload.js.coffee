setup = false

window.setupFileUpload = ->
  return if setup
  setup = true
  
  $(document)
    .on 'dragover',
      false  # required to make dragging work on Gecko
    .on 'drop', (event) ->
      $('body').removeClass 'dragging'
      files = event.originalEvent.dataTransfer.files
      window.setTimeout -> upload files
      false
  
  # draglevel = 0
  # $('body')
  # .on 'dragenter', ->
  #   if ++draglevel >= 1
  #     $('body').addClass 'dragging'
  # .on 'dragleave', ->
  #   if --draglevel <= 0
  #     $('body').removeClass 'dragging'
  
  upload = (files, index = 0) ->
    if file = files.item index
      $progress = $ '<progress min=0 max=100 value=0>'
      $('.images').append $progress
      progress = (event) ->
        if event.lengthComputable
          $progress.val event.loaded / event.total * 100 | 0
      
      formData = new FormData
      formData.append 'file', file
      
      uploadPath = $('.images').data('upload-url')
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
        .fail ->
          console.log 'Something went terribly wrong...'
        .always ->
          $('progress').remove()
