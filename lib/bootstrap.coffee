define (require, exports, module) ->

  #local requires
  domReady = require 'domReady'
  App = require 'cs!application'

  ##Bootstrap the app here.
  domReady ->
    console.log 'ready!'
    App.start()

  #export
  module.exports = App
