window.App=_.extend({},window.App,
  init:->
    @loadSounds() if @context = @createContext()

  loadSounds:->
    console.log('Im gonna load myself some sounds!')

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