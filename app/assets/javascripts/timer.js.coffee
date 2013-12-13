class @Timer
  instance = null

  class Timer
    $counterObject: null
    seconds: null
    secondСountdown: 360
    intervalTime: 1000
    intervalTimer: null

    stopMessage: 'Time is over!'

    constructor: ->
      @.$counterObject = $('.counter')
      @.seconds = @.getSeconds()

    getSeconds: ->
      return CacheStorage.instance().get('timer') ? @.secondСountdown

    saveSeconds: (seconds) ->
      CacheStorage.instance().set('timer', seconds)

    start: ->     
      @.interval()

    stop: -> 
      clearTimeout(@.intervalTimer)
      @.saveSeconds(@.secondСountdown)
      alert @.stopMessage
      
    interval: ->
      @.intervalTimer = setInterval =>
        @.seconds--
        @.saveSeconds(@.seconds)
        @.$counterObject.text(@.seconds)
        @.stop() if @.seconds == 0
      , @.intervalTime
    
  @instance: ->
    instance ?= new Timer()