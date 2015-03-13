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
    @firebaseRef = new Firebase(config.firebase)
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
    @get('controllers.profiles').findAllByUid(authData.uid).then (profiles) ->

      if profiles.get('length') is 0
        # New Member
        self.get('controllers.member').create(authData).then (member) ->
          self.validate(member)
      else
        # Existing Member
        profile = profiles.get('lastObject').toJSON()
        self.get('controllers.member').findRefByUuid(profile.uuid).then (member) ->
          self.validate(member)
        , (notFound) ->
          self.get('controllers.member').create(authData).then (member) ->
            self.validate(member)

  validate: (member) ->
    @set('authenticated', true)
    @get('controllers.session').start(member)

  invalidate: ->
    @set('authenticated', false)   
    @get('controllers.session').finish()


`export default authenticationController`