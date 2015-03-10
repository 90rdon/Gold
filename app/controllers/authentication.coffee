`import config from '../config/environment'`

# Firebase Simple Login Hook
authenticationController = Ember.Controller.extend
  needs: [
    'profiles'
    'member'
    'session'
  ]

  authenticated:  false

  init: ->
    self = @
    @_super()
    @firebaseRef = new Firebase(config.APP.firebaseUri)
    @firebaseRef.onAuth (authData) ->
      if authData
        # --- authenticating to our app ---
        self.authenticate(authData)
      else
        self.invalidate()

  login: (provider) ->
    return @firebaseRef.authWithOAuthPopup('github', @authenticate)  if (provider is 'github')
    return @firebaseRef.authWithOAuthPopup('facebook', @authenticate)  if (provider is 'facebook')
    return @firebaseRef.authWithOAuthPopup('twitter', @authenticate)  if (provider is 'twitter')
    null

  logout: ->
    @firebaseRef.unauth()
    @invalidate()

  # --- authenticating to our app ---
  authenticate: (authData) ->
    self = @
    @get('controllers.profiles').findAll(authData.uid).then (profiles) ->

      if profiles.get('length') is 0
        # New Member
        self.get('controllers.member').create(authData).then (memberRef) ->
          self.validate(memberRef)
      else
        # Existing Member
        profile = profiles.get('lastObject').toFirebaseJSON()
        self.get('controllers.member').findRefByUuid(profile.uuid).then (memberRef) ->
          self.validate(memberRef)
        , (notFound) ->
          self.get('controllers.member').create(authData).then (memberRef) ->
          self.validate(memberRef)

  validate: (memberRef) ->
    @set('authenticated', true)
    @get('controllers.session').start(memberRef)

  invalidate: ->
    @set('authenticated', false)   
    @get('controllers.session').finish()


`export default authenticationController`