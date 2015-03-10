sessionController = Ember.ObjectController.extend
  needs: [
    'application'
    'presence'
    'member'
    'members'
  ]

  sessionRef:     null
  presenceRef:    null
  memberRef:      null
  status:         null

  start: (memberRef) ->
    self = @
    @set('memberRef', memberRef)
    # --- automatically set the presenceRef ---
    @set('presenceRef', @get('controllers.presence').get('presenceRef'))
    new Ember.RSVP.Promise (resolve, reject) ->

      json = Ember.Object.create
        member:     null
        on:         Firebase.ServerValue.TIMESTAMP
        presences:  []

      json.set('member', memberRef)
      json.get('presences').addObject(self.get('presenceRef'))
      session = self.store.createRecord 'session', json
      session.save().then (sessionRef) ->
        if sessionRef?
          resolve(self.onDisconnect(sessionRef))
        else
          reject()

  onDisconnect: (sessionRef) ->
    self = @
    sessionRef.buildFirebaseReference().onDisconnect()
      .update
        off: Firebase.ServerValue.TIMESTAMP
      , ->
        self.set('sessionRef', null)

  finish: ->
    @setMyStatus('offline')

    @get('memberRef').buildFirebaseReference()
    .child('logon')
    .set(false)  if @get('memberRef')?

    @get('memberRef').buildFirebaseReference()
    .child('status')
    .set('offline')  if @get('memberRef')?

    @set('presenceRef', null)
    @set('sessionRef', null)
    @set('memberRef', null)

  setMyStatus: (status) ->
    @set('status', status)
    @get('memberRef').buildFirebaseReference().child('status').set(status)  if @get('memberRef')?

  last: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      self.store.fetch 'session', 
        endAt: uuid
        limit: 1

      .then (profiles) ->
        resolve(profiles)
      , (error) ->
        reject(error)

`export default sessionController`