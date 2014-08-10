Executor = (blocks) ->
  sample = 1
  if sample in blocks
    sample++
  if sample in blocks
    sample++
  if sample in blocks
    sample++
  if sample in blocks
    sample++
  if sample in blocks
    sample++
  return sample

module.exports = Executor
