`import NormalizeAccount  from '../utils/auth/normalize-account'`
`import config from '../config/environment'`

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

  normalize: (profile) ->
    new Ember.RSVP.Promise (resolve) ->

      switch profile.toJSON().provider
        when 'twitter'    then resolve(NormalizeAccount.Twitter(profile))
        when 'github'     then resolve(NormalizeAccount.Github(profile))
        when 'facebook'   then resolve(NormalizeAccount.Facebook(profile))

  cachedUserProfile: (authData) ->
    switch authData.provider
      when 'twitter'    then NormalizeAccount.TwitterCachedUser(authData)
      when 'github'     then NormalizeAccount.GithubCachedUser(authData)
      when 'facebook'   then NormalizeAccount.FacebookCachedUser(authData)

  create: (authData) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      userProfile = self.cachedUserProfile(authData)
      self.get('controllers.profile').createOrUpdate(authData, userProfile).then (profile) ->
        self.normalize(profile).then (user) ->
          user.id = profile.toJSON().uuid
          member = self.store.createRecord('member', user)
          member.save().then (member) ->
            member.get('profiles').addObject(profile)
            member.save().then (member) ->
              resolve(member)
            , (error) ->
              reject(error)

  findRefByUuid: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.find 'member', 
        orderBy:      'uuid'
        startAt:      uuid
        endAt:        uuid
        limitToLast:  1
      .then (member) ->
        resolve(member)
      , (error) ->
        reject(error)

  refresh: (member, status) ->
    memberRef = new Firebase(config.firebase + '/members/' + member.toJSON().id)
    memberRef
    .child('status')
    .set(status)

`export default memberController`