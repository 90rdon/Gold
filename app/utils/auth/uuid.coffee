uuid =
  createUuid: ->
    'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
      r = Math.random() * 16 | 0
      v = (if c is 'x' then r else (r & 0x3 | 0x8))
      v.toString(16)

  createShortUrl: ->
    text = ''
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    i = 0

    while i < 7
      text += possible.charAt(Math.floor(Math.random() * possible.length))
      i++
    text

`export default uuid`