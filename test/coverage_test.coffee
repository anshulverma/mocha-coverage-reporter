{EventEmitter} = require 'events'

runTest = (test) ->
  runner = new EventEmitter
  orignalWrite = process.stdout.write
  process.stdout.write = (resultJson) ->
    process.stdout.write = orignalWrite
    result = JSON.parse resultJson
    test result
  require("#{srcPath}/main")(runner)
  runner.emit 'end'

describe 'coverage tests', ->
  it 'verify non full coverage', (done) ->
    sampleRunner [1]
    runTest (result) ->
      assert.lengthOf result, 1
      assert.deepPropertyVal result, '[0].file', 'sample.coffee'
      assert.deepPropertyVal result, '[0].coverage', 71.43
      do done

  it 'verify 100% coverage', (done) ->
    sampleRunner [1, 2, 3, 4, 5]
    runTest (result) ->
      assert.lengthOf result, 1
      assert.deepPropertyVal result, '[0].file', 'sample.coffee'
      assert.deepPropertyVal result, '[0].coverage', 100

      do done
