define (require, exports, module) ->

  #libs
  $ = require "jquery"
  Backbone = require "backbone"

  module.exports = Panel

  class Panel extends Backbone.View

    tagName: 'section'
    className: 'panel'

    #init header and content
    initialize: ->
      @header = $('<header><span/></header>')
      @content = $('<article/>')
      @resizeContent()
      $(@content).bind 'resize', =>
        @resizeContent()
      @title = @options.title
      $('span', @header).text @title
      $(@el).append @header
      @content.addClass 'content'
      $(@el).append @content

    #hack for sizing the content correctly
    resizeContent: ->
      $(@content).css 'height', (window.innerHeight - 100) + 'px'

    #default render of header and content
    render: ->
      $(@content).html('CONTENT')
      $(@header).html('HEADER')
      @

    #add a back button to the header
    addBackButton: (text='back', backRoute)->
      button = @make 'div', class: 'button'
      $(button).addClass('left')
      $(button).text text
      @header.append button
      $(button).bind 'tap', =>
        route = backRoute ?= @options.router.prevView?.route
        if route
          @options.router[route](trans: 'left')
        else
          throw 'views must have a .route to be able to use the back button'
        
      
    #add a default button to the header, passing in a route to go to
    addButton: (text, callback)->
      button = @make 'div', class: 'button'
      $(button).text text
      $(button).addClass('right')
      @header.append button
      $(button).bind 'tap', (e)=>
        callback(e)
