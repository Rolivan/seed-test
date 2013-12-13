class @Seed
  instance = null

  class Seed

    stateToUriMap:
      'register':         '/home/index'
      'survey':           '/home/survey'
      'congratulation':   '/home/congratulation'

    constructor: ->
      Timer.instance().start()
      @.defineState()
      @.$form = $('form')

    defineState: ->
      @.state = window.state || 'register'

    init: ->
      console.log 'init'

  @instance: ->
    instance ?= new Seed()