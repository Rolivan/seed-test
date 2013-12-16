class @Seed
  instance = null

  class Seed
    $form: null
    state: null

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
      @.$form.deserialize CacheStorage.instance().get @.state
      @.initListeners()

      @.$form.submit (event) =>
        event.preventDefault()
        @.formSubmit()

    initListeners: ->
      $('input, select').on "keyup change", (event) =>
        CacheStorage.instance().set(@.state, @.$form.serialize())

      $('.btn-submit').click (event) =>
        event.preventDefault()
        @.$form.submit()

    formSubmit: =>
      formData = $(@.$form).serialize()
      $('input').removeClass 'error'

      $.ajax
        url: @.stateToUriMap[@.state]
        type: 'post'
        data: formData
        dataType: 'json'
        success: (data) => 
          unless (data.ok)
            for key, value of data.messages
              $('input[name*="' + key + '"]').addClass 'error'
          else 
            window.state = data.state
            @.defineState()
            $(".form-box").replaceWith($(data.html));
            @.$form = $('form')
            @.init()

            history.pushState({}, "SeedBlocks", data.url)

      return false

  @instance: ->
    instance ?= new Seed()