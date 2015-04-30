`import UUID  from 'linguis/utils/auth/uuid'`

callRoute = Ember.Route.extend
  queryParams:
    id:
      refreshModel: true
      
  model: (params) ->
    return params.call_id  if params.call_id
    ic-ajax(App.serverUri + '/token/' + UUID.createShortUrl() + '?recipient_id=' + params.queryParams.recipient_id + '&caller_id=' + params.queryParams.caller_id).then (call_id) ->
      call_id

  setupController: (controller, model) ->
    @store.fetch('call', model).then (callRef) ->
      controller.set('model', callRef)

  actions:
    willTransition: (transition) ->
      console.log 'in transition'
    
`export default callRoute`