module.exports = ->

  @World = require('../support/world.coffee').World

  @Given /^I am on the homepage$/, (callback) ->
    # Write code here that turns the phrase above into concrete actions
    callback.pending()

  @Given /^I am on the website$/, (callback) ->
    # Write code here that turns the phrase above into concrete actions
    callback.pending()

  null