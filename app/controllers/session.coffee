`import config from '../config/environment'`

sessionController = Ember.ObjectController.extend
  needs: [    
    'presence'
    'member'
    'sessions'
  ]

  session:        null
  presence:       null
  member:         null

  status: null

  statusWatch: (->
    status = @get('controllers.presence').get('status')
    @set('status', status)
    if @get('session')?
      @get('session').set('status', status)  
      @get('session').save()
    
    @get('controllers.member').refresh(@get('member'), status)
  ).observes('controllers.presence.status')

  start: (member) ->
    self = @
    session = @get('session')

    # --- automatically set the presence ---
    @set('presence', self.get('controllers.presence').get('presence'))

    new Ember.RSVP.Promise (resolve, reject) ->

      if session?
        reject('No action taken. We have a session already.')
      else        
        # @setMyStatus(@get('status'))
        self.set('member', member)
        self.set('controllers.member.uuid', member.id)

        
        self.get('controllers.sessions').alive(member).then (session) ->
          if session?
            # --- here is the alive session ---
            resolve(session)
          else
            # --- lets create a new session here ---
            self.create().then (session) ->
              self.set('session', session)
              resolve(session)

  create: ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      session = self.store.createRecord 'session', 
        member: self.get('member')
        status: 'online'

      session.get('presences').addObject(self.get('presence'))
      session.save().then (session) ->
        self.onDisconnect(session)
        resolve(session)

  onDisconnect: (session) ->
    self = @
    session = new Firebase(config.firebase + '/sessions/' + session.id)
    session.onDisconnect()
      .update
        off: Firebase.ServerValue.TIMESTAMP

  finish: ->
    @get('controllers.presence').setMyStatus('offline')

    @set('presence', null)
    @set('session', null)
    @set('member', null)
    @set('controllers.member.uuid', null)

  # setMyStatus: (status) ->
  #   return  unless status
  #   @set('status', status)
  #   @get('controllers.member').refresh(@get('member'), status)

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