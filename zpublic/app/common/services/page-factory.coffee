#Creates a factory which holder variables and functions that pertain to
#All pages, and that all page controllers may need access to.

PageFactory = ->
  title = 'Angler'

  title: ->
    title
  setTitle: (newTitle)->
    title = newTitle

angular
  .module('Angler')
  .factory('Page', PageFactory)
