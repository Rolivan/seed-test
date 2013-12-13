class @CacheStorage
  instance = null

  class CacheStorage
    constructor: () ->
      if typeof(Storage) isnt "undefined"
        console.log 'storage'
      else
        console.log 'no storage'

    get: (key) ->     
      localStorage[key]
      
    set: (key, value) ->
      localStorage[key] = value #JSON.stringify value

  @instance: ->
    instance ?= new CacheStorage()