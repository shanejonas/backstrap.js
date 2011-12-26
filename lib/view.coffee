define (require, exports, module) ->
  #requires
  Backbone = require 'backbone'
  $ = require 'jquery'

  class View extends Backbone.View
    render: ->
      $('body').append('<b>this is a rendered view</b>')

  module.exports = new View
