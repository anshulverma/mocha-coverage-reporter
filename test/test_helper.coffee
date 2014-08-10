global.assert = require('chai').assert

## Instrument source with jscoverage so that we can record coverage data
{CoverageInstrumentor} = require 'coffee-coverage'
instrumentor = new CoverageInstrumentor
  coverageVar: '_test_$jscoverage'
fixtureSrc = "#{__dirname}/fixture"
require('mkdirp').sync "#{fixtureSrc}/build"
instrumentor.instrumentFile "#{fixtureSrc}/sample.coffee",
                            "#{fixtureSrc}/build/sample.js"

# We need to execute annotated source for coverage report generation. This can
# be determined using `NODE_ENV`.
coverageMode = process.env['NODE_ENV'] is 'coverage'
global.srcPath = if coverageMode then '../coverage/src' else '../src'

global.sampleRunner = require('./fixture/sample_runner').execute
