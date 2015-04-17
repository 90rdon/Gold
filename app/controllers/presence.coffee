`import config from '../config/environment'`

presenceController = Ember.Controller.extend
  needs: [
    'application'
  ]

  status:        null
  presence:      null

  init: ->
    self = @
    @set('connectedRef', new Firebase(config.firebase + '/.info/connected'))
    
    @get('connectedRef').on 'value', (ispresence) ->
      self.setMyStatus('online')  if ispresence.val()

  onConnect: ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      presence = self.store.createRecord 'presence', 
        status: 'online'
        device: 'unknown'
        ip:     '127.0.0.1'
        meta:   null
        off:    null

      presence.save().then (presence) ->
        if presence?
          self.set('presence', presence)
          #on disconnect
          self.onDisconnect()
          resolve()
        else
          reject()

  onDisconnect: ->
    self = @
    presence = new Firebase(config.firebase + '/presences/' + @get('presence').id)
    presence.onDisconnect()
      .update
        off: Firebase.ServerValue.TIMESTAMP
        status: 'offline'
      , ->
        self.set('status', 'offline')

  setMyStatus: (status) ->
    @set('status', status)
    if @get('presence')?
      @get('presence').set('status', status)  
      @get('presence').save()

`export default presenceController`
