do ->
  resolve = ->
  reject = ->
  returnsPromise = ->
    new Promise (res, rej) ->
      resolve = res
      reject = rej

  setTimeout (-> resolve 'Yeah Baby, Yeah!'), 2000
  value = await returnsPromise()
  console.log value