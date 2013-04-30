$.rails.prompt = (message, defaultValue) ->
  window.prompt message, defaultValue
  
$.rails.handlePrompt = (element) ->
  config = element.data('prompt')
  message      = config.message || config
  defaultValue = config.default
  param        = config.param || 'value'
  return true unless message
  
  if $.rails.fire element, 'prompt'
    value = $.rails.prompt message, defaultValue
    callback = $.rails.fire element, 'prompt:complete', [value]
  
  params = element.data('params') || {}
  params[param] = value
  element.data 'params', params
  
  value && callback

allowAction = $.rails.allowAction
$.rails.allowAction = (element) ->
  if element.data('confirm')
    allowAction element
  else if element.data('prompt')
    $.rails.handlePrompt element
