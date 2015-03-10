`import config from '../config/environment'`

presenceController = Ember.Controller.extend
  needs: [
    'application'
  ]

  status:           null
  presenceRef:      null

  onConnect: ->
    self = @
    @set('connectedRef', new Firebase(config.APP.firebaseUri + '/.info/connected'))
    
    @get('connectedRef').on 'value', (ispresence) ->
      if ispresence.val()
        self.create().then ->
          self.set('status', 'online')
        return
      else
        self.set('status', 'offline')

  create: ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.set  'presenceRef', self.store.createRecord 'presence', 
        status: 'online'
        device: 'unknown'
        ip:     '127.0.0.1'
        meta:   null
        data:   null
        on:     Firebase.ServerValue.TIMESTAMP
        off:    null

      self.get('presenceRef').save().then (presenceRef) ->
        if presenceRef?
          #on disconnect
          self.onDisconnect()
          resolve()
        else
          reject()

  onDisconnect: ->
    self = @
    @get('presenceRef').buildFirebaseReference().onDisconnect()
      .update
        off: Firebase.ServerValue.TIMESTAMP
        status: 'offline'
      , ->
        self.set('status', 'offline')

  setMyStatus: (status) ->
    self = @
    @get('presenceRef').buildFirebaseReference()
      .update
        status: status
      , ->
        self.set('status', status)

`export default presenceController`
