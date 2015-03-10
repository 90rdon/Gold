`import NormalizeAccount  from '../utils/auth/normalize-account'`

memberController = Ember.ObjectController.extend
  needs: [
    'profile'
  ]

  isMe:       false

  # uuid: (->
  #   @get('content').buildFirebaseReference().name()
  # ).property(@)

  uuid: (->
    null
  ).property()

  block: (->
    if @get('content.logon')
      if @get('isMe')
        return true
      else
        return false
    else
      return true
  ).property('content.logon')

  normalize: (profileRef) ->
    new Ember.RSVP.Promise (resolve) ->

      switch profileRef.toFirebaseJSON().provider
        when 'twitter'    then resolve(NormalizeAccount.Twitter(profileRef))
        when 'github'     then resolve(NormalizeAccount.Github(profileRef))
        when 'facebook'   then resolve(NormalizeAccount.Facebook(profileRef))

  cachedUserProfile: (authData) ->
    switch authData.provider
      when 'twitter'    then NormalizeAccount.TwitterCachedUser(authData)
      when 'github'     then NormalizeAccount.GithubCachedUser(authData)
      when 'facebook'   then NormalizeAccount.FacebookCachedUser(authData)

  create: (authData) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      userProfile = self.cachedUserProfile(authData)
      self.get('controllers.profile').createOrUpdate(authData, userProfile).then (profileRef) ->
        self.normalize(profileRef).then (user) ->
          user.set('id', profileRef.toFirebaseJSON().uuid)
          self.store.createRecord('member', user).save().then (memberRef) ->
            resolve(memberRef)
          , (error) ->
            reject(error)

  findRefByUuid: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.fetch('member',  uuid).then (memberRef) ->
        resolve(memberRef)
      , (error) ->
        reject(error)

  refresh: (memberRef, status) ->
    memberRef.buildFirebaseReference()
    .child('status')
    .set(status)

`export default memberController`