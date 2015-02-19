`import config from '../config/environment'`

# Firebase Simple Login Hook
authenticationController = Ember.Controller.extend
  needs: [
    'profile'
    'profiles'
    # 'session'
  ]

  sessionRef:    null
  authenticated: false

  init: ->
    self = @
    @_super()
    @firebaseRef = new Firebase(config.APP.firebaseUri)
    @firebaseRef.onAuth (authData) ->
      if (authData)
        # --- authenticating to our app now ---
        self.authenticate(authData)
      else
        self.invalidate()

  login: (provider) ->
    return @firebaseRef.authWithOAuthPopup('github', @authHandler)  if (provider is 'github')
    null

  logout: ->
    @firebaseRef.unauth()
    @invalidate()

  authHandler: (error, authData) ->
    return @invalidate  if (error)
    @set('authenticated', true)

  # --- authenticating to our app now ---
  authenticate: (authData) ->
    self = @
    @get('controllers.profiles').findAll(authData.uid).then (profiles) ->
      if profiles.get('length') is 0
        # New Member
        @get('controllers.member').create(identity).then (memberRef) ->
          self.set('member', memberRef)
      else
        # Existing Member
        profile = profiles.get('lastObject').toFirebaseJSON()
        @get('controllers.member').findRefByUuid(profile.uuid).then (memberRef) ->
          self.set('member', memberRef)
        , (notFound) ->
          @get('controllers.member').create(identity).then (memberRef) ->
          self.set('member', memberRef)

  invalidate: ->
    @set('sessionRef', null)      

`export default authenticationController`