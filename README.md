# Backstrap.js

 This is an extension of [Backbone](http://documentcloud.github.com/backbone/) heavily inspired by [Spine Mobile](http://spinejs.com/mobile).

## Usage

### requirejs
I use requirejs for this project now. The syntax is easily readable and compact (see example below).

#### Bootstrapping a Stage:
A Stage is a Controller but holds your whole application and includes a tabbar and header bar
      
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

should be enough to get started.
