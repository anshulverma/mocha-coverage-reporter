Reporter = (runner) ->
  runner.on 'end', ->
    coverage = global._test_$jscoverage || global._$jscoverage or {}
    result = []
    result.push processFile file, cov for file, cov of coverage
    process.stdout.write JSON.stringify result, null, 2

processFile = (file, cov) ->
  sloc = hits = 0
  for line, index in cov.source
    ++sloc unless typeof cov[index] is 'undefined'
    ++hits if cov[index]
  file: file
  coverage: parseFloat (hits / sloc * 100).toFixed 2

module.exports = Reporter
