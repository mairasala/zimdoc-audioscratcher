window.App=_.extend({},window.App,
  init:->
    @loadSounds() if @context = @createContext()

  loadSounds:->
    soundLoader= new App.SoundLoader(@context)
    $(soundLoader).on 'loaded', (evt)=> @soundsLoaded(evt)
    soundLoader.load(['media/Bonde.mp3'])

  soundsLoaded:(evt)->
    if evt.target.buffers.length
      @buffer= evt.target.buffers[0]
      $('#loading').hide()
      @setButtonBehaviour(false)

  startSound:->
    @source= @context.createBufferSource()
    @source.buffer = @buffer
    @source.connect(@context.destination)
    @source.start(0)
    @setButtonBehaviour(true)

  stopSound:->
    @source.stop()
    @setButtonBehaviour(false)

  setButtonBehaviour:(isplaying)->
    if isplaying
      $('#sound').show().text('STOP').off('click').on 'click',=> @stopSound()
    else
      $('#sound').show().text('START').off('click').on 'click', =>@startSound()

  createContext:->
    try
      window.AudioContext = window.AudioContext||window.webkitAudioContext
      new AudioContext()
    catch e
      alert('Web Audio API is not supported in this browser')
      null
)

$(window).load ->
  App.init()