presenceContainer = Ember.View.extend
  # Use idle/away/back events created by idle.js to update our status information.
  didInsertElement: ->
    self = @
    @get('controller').get('controllers.presence').onConnect()
    document.onIdle = ->
      # put the 'offline' check instead of in the controller so we can stop the view to stop sending status if we are already 'offline'
      self.get('controller').get('controllers.presence').setMyStatus('idle')  unless self.get('controller').get('controllers.presence').get('status') is 'offline'
    document.onAway = ->
      self.get('controller').get('controllers.presence').setMyStatus('away')  unless self.get('controller').get('controllers.presence').get('status') is 'offline'
    document.onBack = (isIdle, isAway)->
      self.get('controller').get('controllers.presence').setMyStatus('online')  unless self.get('controller').get('controllers.presence').get('status') is 'offline'

    setIdleTimeout(5000)
    setAwayTimeout(10000)
    
`export default presenceContainer`