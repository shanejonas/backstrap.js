define (require, exports, module) ->

  #libs
  _ = require 'underscore'
  $ = require 'jquery'
  Backbone = require 'backbone'

  module.exports = Tabbar

  class Tabbar extends Backbone.View
    
    #element defaults
    tagName: 'nav'
    className: 'tabbar'

    #holder for tabs
    tabs: []

    #assign tabs that are passed in
    initialize: ->
      if @options.tabs then @tabs = @options.tabs

    #render tabs
    render: ->
      @renderTabs()
      @

    #for each tab that we have, make a button for all of them
    #bind click events and and append to tabbar
    renderTabs: ->
      _(@tabs).each (tab, index)=>
        button = $("<div class='button boxed #{tab}'><span>#{tab}</span></div>")
        button.bind 'tap', =>
          @goToTab tab
        $(@el).append button
      #jquery weirdness for getting first button and adding active
      $($('.button', @el).get(0)).addClass('active')

    # Go To a tab
    goToTab: (tab)->
      # remove all active classes on buttons
      @$('div').removeClass('active')
      # add class to new tab
      button = @$(".#{tab}")
      button.addClass('active')
      params = {}
      # if we have a current tab, set the previous tab to the current one
      # and cache the index of the previous tab
      if @currentTab
        @prevTab =  @currentTab
        prevIndex = _.indexOf @tabs, @prevTab

      #set current tab and index
      @currentTab = tab
      currIndex = _.indexOf @tabs, @currentTab
      
      # if its not the same tab
      if currIndex isnt prevIndex
        # if we have a previous tab and the curr index is bigger than the previous
        # transition right else transition left, and if theres no previous tab default to right
        if @prevTab
          if currIndex > prevIndex
            params.trans = 'right'
          else
            params.trans = 'left'
        else
          params.trans = 'right'

        # route to the correct tab
        @options.router[tab](params)
        @options.router.navigate tab, false

      #trigger a tab change event and pass in the tab string
      @trigger('change', tab)

