@Helpers = require('./helpers/helpers.coffee').Helpers
expect = @Helpers.expect


describe 'Math', ->
  describe 'Incrementing numbers', ->

    it 'should return 1 when incrementing 0', ->
      @n = 0
      @n++
      expect(@n).to.equal 1