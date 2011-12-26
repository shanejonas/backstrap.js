define (require, exports, module) ->

  #libs
  Backbone = require "backbone"
  Stage = require "cs!src/stage"
  Panel = require "cs!src/panel"

  ##application.coffee
  class Application extends Stage

    routes:
     '': 'default'
     'default': 'default'
     'other': 'other'

    start: ->
      @renderTabbar 'default', 'other'
      Backbone.history.start()

    default: (params)->
      view = new Panel
        router: @
        title: 'default'
      view.route = 'default'
      @swap view, params

    other: (params)->
      @default params

  module.exports = new Application
