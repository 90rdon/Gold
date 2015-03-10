presenceContainer = Ember.View.extend
  # Use idle/away/back events created by idle.js to update our status information.
  didInsertElement: ->
    self = @
    @get('controller').get('controllers.presence').onConnect()
    document.onIdle = ->
      self.get('controller').get('controllers.presence').setMyStatus('idle')
    document.onAway = ->
      self.get('controller').get('controllers.presence').setMyStatus('away')
    document.onBack = (isIdle, isAway)->
      self.get('controller').get('controllers.presence').setMyStatus('online')

    setIdleTimeout(5000)
    setAwayTimeout(10000)
    
`export default presenceContainer`