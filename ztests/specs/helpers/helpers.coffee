path = require 'path'

#protractor = require 'protractor'
#webdriver = require 'selenium-webdriver'

chai = require 'chai'
chaiAsPromised = require 'chai-as-promised'
chai.use(chaiAsPromised)

#driver = new webdriver.Builder().
#  usingServer('http://localhost:4444/wd/hub').
#  withCapabilities(webdriver.Capabilities.chrome()).
#  build()
  
#driver.manage().timeouts().setScriptTimeout(100000)

#ptor = protractor.wrapDriver driver

Helpers = []

#Helpers.browser = ptor
#Helpers.By = protractor.By
Helpers.assert = chai.assert
Helpers.expect = chai.expect

module.exports.Helpers = Helpers