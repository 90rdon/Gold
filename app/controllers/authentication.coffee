`import config from '../config/environment'`

# Firebase Simple Login Hook
authenticationController = Ember.Controller.extend
  needs: [
    'profile'
    'profiles'
    'member'
    # 'session'
  ]

  sessionRef:    null
  authenticated: false
  thisself: (->
    @
  ).property('@')

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
    return @firebaseRef.authWithOAuthPopup('facebook', @authHandler)  if (provider is 'facebook')
    return @firebaseRef.authWithOAuthPopup('twitter', @authHandler)  if (provider is 'twitter')
    null

  logout: ->
    @firebaseRef.unauth()
    @invalidate()

  authHandler: (error, authData) ->
    return Gold.__container__.lookup('controller:authentication').invalidate()  if (error)
    Gold.__container__.lookup('controller:authentication').set('authenticated', true)

  # --- authenticating to our app now ---
  authenticate: (authData) ->
    self = @
    @get('controllers.profiles').findAll(authData.uid).then (profiles) ->
      if profiles.get('length') is 0
        # New Member
        self.get('controllers.member').create(authData).then (memberRef) ->
          self.set('member', memberRef)
      else
        # Existing Member
        profile = profiles.get('lastObject').toFirebaseJSON()
        self.get('controllers.member').findRefByUuid(profile.uuid).then (memberRef) ->
          self.set('member', memberRef)
        , (notFound) ->
          self.get('controllers.member').create(authData).then (memberRef) ->
          self.set('member', memberRef)

  invalidate: ->
    @set('sessionRef', null)      

`export default authenticationController`