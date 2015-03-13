`import config from '../config/environment'`

sessionController = Ember.ObjectController.extend
  needs: [
    'application'
    'presence'
    'member'
    'members'
  ]

  session:        null
  presence:       null
  member:         null

  # status: (->
  #   @setMyStatus(@get('controllers.presence').get('status'))
  # ).observes('controllers.presence.status')

  start: (member) ->
    self = @
    # @setMyStatus(@get('status'))
    @set('member', member)

    # --- automatically set the presence ---
    @set('presence', @get('controllers.presence').get('presence'))
    new Ember.RSVP.Promise (resolve, reject) ->

      session = self.store.createRecord 'session', 
        member: member
      session.get('presences').addObject(self.get('presence'))
      session.save().then (session) ->
        if session?
          self.set('session', session)
          resolve(self.onDisconnect(session))
        else
          reject()

  onDisconnect: (session) ->
    self = @
    session = new Firebase(config.firebase + '/sessions/' + session.id)
    session.onDisconnect()
      .update
        off: Firebase.ServerValue.TIMESTAMP
      , ->
        self.set('session', null)

  finish: ->
    # @setMyStatus('offline')

    @set('presence', null)
    @set('session', null)
    @set('member', null)

  setMyStatus: (status) ->
    return  unless status
    @set('status', status)
    if @get('member')?
      if @get('member').get('status') is 'offline'
        @get('member').set('logged_on', false)
      else
        @get('member').set('logged_on', true)
      @get('member').set('status', status)
      @get('member').save()
    return

  # last: (uuid) ->
  #   self = @
  #   new Ember.RSVP.Promise (resolve, reject) ->
      
  #     self.store.find 'session', 
  #       endAt: uuid
  #       limit: 1

  #     .then (session) ->
  #       resolve(session)
  #     , (error) ->
  #       reject(error)

`export default sessionController`