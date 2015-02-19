sessionController = Ember.ObjectController.extend
  needs: [
    'application'
    'presence'
    'member'
    'members'
  ]

  # connectionRef:  null
  # sessionRef:     null
  status:          'offline'
  memberRef:        null
  memberObj:        null
  memberSessionRef: null

  memberDisplayName: (->
    return null  unless @get('memberRef')
    @get('memberRef').toFirebaseJSON().display_name
  ).property('memberRef')

  memberUuid: (->
    return null  unless @get('memberRef')
    @get('memberRef').buildFirebaseReference().name()
  ).property('memberRef')

  memberRefWatch: (->
    self = @
    # @set('isLoggedIn',  @get('memberRef')?)
    if @get('memberRef')
      @set('memberUuid',  @get('memberRef').buildFirebaseReference().name()) 
      @get('controllers.members').find (item, index) ->
        item.get('block')  if self.get('memberUuid') is self.get('controllers.members').get('content').buildFirebaseReference().name()
    else
      self = @
      @set('memberRef', null)
      @set('memberUuid', null)
      @get('controllers.members').find (item, index) ->
        item.get('block')  if self.get('memberUuid') is self.get('controllers.members').get('content').buildFirebaseReference().name()
  ).observes('memberRef')

  # init: ->
  #   self = @
  #   @set('store', App.__container__.lookup('store:main'))

  # create: (session) ->
  #   self = @
  #   new Ember.RSVP.Promise (resolve, reject) ->

  #     self.store.createRecord('session', session).save()
  #     .then (sessionRef) ->
  #       resolve(sessionRef)
  #     , (error) ->
  #       reject(error)

  serialize: (id, uuid, snapshot) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      reject()  unless snapshot

      session = Ember.Object.create
        id:       id
        uuid:     uuid
        device:   snapshot.device
        ip:       snapshot.ip
        meta:     snapshot.meta
        data:     snapshot.data
        logon:    snapshot.on
        logoff:   null

      resolve(session)
    , (error) ->
      reject(error)

  start: (memberRef) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      # --- here is where the member is set
      self.set('memberRef', memberRef)
      # --- adapt the presence sessionRef into the app sessionRef
      sessionRef = self.get('controllers.presence').get('thisSessionRef')
      
      sessionRef.once 'value', (snapshot) ->
        self.serialize(
          sessionRef.name(),
          memberRef.buildFirebaseReference().name(),
          snapshot.val()
        ).then (session) ->
          memberRef.buildFirebaseReference().child('sessions').child(session.id).set(session)
          memberSession = memberRef.buildFirebaseReference().child('sessions').child(session.id)
          memberSession.onDisconnect().update(logoff: Firebase.ServerValue.TIMESTAMP)
          # memberSession.onDisconnect().update(logoff: new Date().getTime())Firebase.ServerValue.TIMESTAMP
          
          self.set('memberSessionRef', memberSession)

          self.get('controllers.members').filter (member) ->
            if member.get('uuid') is self.get('memberUuid')
              self.set('memberObj', member)
              member.set('isMe', true) 

          self.get('memberRef').buildFirebaseReference()
          .child('logon')
          .set(true)

          self.get('memberRef').buildFirebaseReference()
          .child('logon')
          .onDisconnect()
          .set(false)

          self.get('memberRef').buildFirebaseReference()
          .child('status')
          .onDisconnect()
          .set('offline')

          resolve(self)

        , (error) ->
          reject(error)
      , (error) ->
        reject(error)

  finish: ->
    @setMyStatus('offline')
    @set('memberRef', null)
    @set('memberObj', null)
    @set('memberSessionRef', null)

    @get('memberRef').buildFirebaseReference()
    .child('logon')
    .set(false)  if @get('memberRef')?

    @get('memberRef').buildFirebaseReference()
    .child('status')
    .set('offline')  if @get('memberRef')?

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