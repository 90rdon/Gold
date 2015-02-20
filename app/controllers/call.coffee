callController = Ember.ObjectController.extend
  callRef: null

  connected: (->
    @set('callRef', @get('content'))
  ).observes('onLoaded')

  actions:
    disconnected: ->
      @transitionToRoute 'index'

`export default callController`