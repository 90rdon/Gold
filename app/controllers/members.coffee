membersController = Ember.ArrayController.extend
  itemController: 'member'

  init: ->
    @_super()
    console.log 'controller:members:init'

  onLoaded: (->
    console.log 'controller:members:onLoaded'
  ).observes('content.isLoaded')
  

`export default membersController`