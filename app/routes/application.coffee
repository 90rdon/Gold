applicationRoute = Ember.Route.extend
  needs: []

  actions:
    login: (provider) ->
      @get('controllers.authentication').authClient.login provider

    logout: ->
      @get('controllers.authentication').authClient.logout()
      @get('controllers.authentication').invalidate()

    call: (recipient) ->
      @transitionToRoute 'call', '',
        queryParams:
          caller_id:    @get('memberUuid')
          recipient_id: recipient.get('id')

`export default applicationRoute`