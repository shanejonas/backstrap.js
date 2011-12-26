define (require, exports, module) ->

  #libs
  $ = require 'jquery'
  Backbone = require 'backbone'
  Panel = require 'cs!src/panel'
  Tabbar = require 'cs!src/tabbar'

  #export definition
  module.exports = Stage

  #class definition
  class Stage extends Backbone.Router

    constructor: ->
      super()

      #keep track of route history
      @bind 'all', (route) =>
        route = route.split(':')[1]
        @routeHistory.push route
      
      #create elements for stage
      @el = $('<div id="body"/>')
      $('body').append @el
      @header  = $('<header />')
      @content = $('<article />')
      @footer  = $('<footer />')
      
      #empty this element add stage class and append the header content and footer
      @el.empty()
      @el.addClass('stage')
      @content.addClass 'content'
      @el.append(@header, @content, @footer)

    routeHistory: []

    #default transition effects for GFX plugin (from spine)
    effectDefaults:
      duration: 350
      easing: 'cubic-bezier(.25, .1, .25, 1)'
      
    #default transition effects for GFX plugin (from spine)
    effectOptions: (options = {})  ->
      $.extend({}, @effectDefaults, options)
    
    #swapping router, from Thoughtbot "Backbone on Rails"
    #modified to throw transitions with options you pass in
    swap: (newView, options)->
      options ?= trans: 'left'
      # if we have a current view unbind it and set it as the previous view
      if @currentView
        @unbindView @currentView
        @prevView = @currentView

      #render out the new view
      @currentView = newView
      @currentView.render()
    
      # if we have a previous view then swap them and slide 
      # out previous one and slide in new one
      # if we dont then we dont need to do a transition so just append it to the content
      if @prevView?
        #prev panel animation
        $(@prevView.el).gfxSlideOut @effectOptions
          direction: @oppositeEffect options.trans
          complete: =>
            # remove the view after the views transition completes
            $(@prevView.el).remove()
        #hide it here so we dont have weird rendering effects
        $(@currentView.el).hide()
        $(@content).append @currentView.el
        #jquery chain show to transition for smooth slide in animation after appending
        $(@currentView.el).show().gfxSlideIn @effectOptions
          direction: options.trans
        #cache previous direction
        @prevDir = options.trans
      else
        $(@content).append @currentView.el


    # give back the opposite transition effect
    oppositeEffect: (trans) ->
      transitionText = if trans is 'left' then 'right' else 'left'

    #unbind events on models and collections for this view
    unbindView: (view) ->
      view.model?.unbind()
      view.collection?.unbind()
      $(view).unbind()

    #make a new tabbar view with the tabs passed in and append it to the footer
    renderTabbar: (tabs...)->
      @tabbar = new Tabbar
        tabs: tabs
        router: @
      @footer.html @tabbar.render().el

    ##defaults:
    start: ->
      @renderTabbar 'default'
      Backbone.history.start()
    #default route example
    routes:
      '': 'default'
    #default route method rendering a panel and calling swap with params
    default: (params={trans: 'left'})->
      @render
      view = new Panel
        router: @
        title: 'default'
      view.route = 'default'
      @swap view, params
      
