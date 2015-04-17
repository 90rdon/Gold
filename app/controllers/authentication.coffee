`import config from '../config/environment'`

# Firebase Simple Login Hook
authenticationController = Ember.Controller.extend
  needs: [
    'profile'
    'member'
    'session'
  ]
  
  session:        null
  
  authenticated:  (->
    true  if @get('session')?
    false
  ).property('session')
  
  init: ->
    self = @
    # @_super()
    @firebaseRef = new Firebase(config.firebase)
    @firebaseRef.onAuth (authData) ->
      # --- authenticating to our app ---
      self.validate(authData)

  login: (provider) ->
    return @firebaseRef.authWithOAuthPopup('github', @validate)  if (provider is 'github')
    return @firebaseRef.authWithOAuthPopup('facebook', @validate)  if (provider is 'facebook')
    return @firebaseRef.authWithOAuthPopup('twitter', @validate)  if (provider is 'twitter')
    null

  logout: ->
    @firebaseRef.unauth()
    @invalidate()

  validate: (authData) ->
    self = @
    if authData
      @authenticate(authData).then (member) ->
        self.get('controllers.session').start(member).then (session) ->
          self.set('session', session)
    else
      @invalidate()    

  invalidate: ->
    @set('session', null)   
    @get('controllers.session').finish()


  # --- authenticating to our app ---
  authenticate: (authData) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profile').findOrCreate(authData).then (profile) ->
        self.get('controllers.member').findOrCreate(profile).then (member) ->
          resolve(member)
        , (error) ->
          reject(error)


`export default authenticationController`