module.exports = ->

  @World = require('../support/world.coffee').World

  @When /^I click on the "([^"]*)" link$/, (arg1, callback) ->
    # Write code here that turns the phrase above into concrete actions
    callback.pending()

  @Then /^the page title should be "([^"]*)"$/, (arg1, callback) ->
    # Write code here that turns the phrase above into concrete actions
    callback.pending()

  null