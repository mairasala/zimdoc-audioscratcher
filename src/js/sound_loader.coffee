window.App ||={}
App.SoundLoader=(context)->
  @context= context
  @buffers=[]
  @

App.SoundLoader.prototype.loadBuffer=(url,total)->
  request = new XMLHttpRequest
  request.open 'GET', url, true
  request.responseType = 'arraybuffer'

  request.onload = =>
    @context.decodeAudioData request.response, ((buffer) =>
      @buffers.push buffer
      if @buffers.length >= total
        $(@).trigger('loaded')
      return
    ), (message)->
      console.log(message)
    return
  
  request.send()

App.SoundLoader.prototype.load=(urls)->
  _.each(urls,(url)=>
    @loadBuffer(url,urls.length)
  )
  