callController = Ember.ObjectController.extend
  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

  callRef: null

  connected: (->
    @set('callRef', @get('content'))
  ).observes('onLoaded')

  actions:
    disconnected: ->
      @transitionToRoute 'index'

`export default callController`