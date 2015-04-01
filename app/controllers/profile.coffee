# `import UUID from '../utils/auth/uuid'`
`import Parse  from '../utils/auth/normalize-account'`

profileController = Ember.ObjectController.extend
  needs: [
    'profiles'
  ]

  findOrCreate: (authData) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profiles').findAllByUid(authData.uid).then (profiles) ->
        if profiles.get('length') is 0
          Parse.cachedUserProfile(authData).then (profileJSON) -> 
            self.create(authData.uid, authData.provider, profileJSON)
            .then (profile) ->
              resolve(profile)
        else
          resolve(profiles.get('lastObject'))

  create: (uid, provider, profileJSON) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      profile = self.store.createRecord 'profile',
        identity:     profileJSON
        uid:          uid
        # uuid:         UUID.createUuid()
        provider:     provider
      profile.save().then (profile) ->
        resolve(profile)
      , (error) ->
        reject(error)

  # updateUUID: (profile, uuid) ->
  #   return unless uuid?
  #   if profile? and not profile.get('uuid')?
  #     new Ember.RSVP.Promise (resolve, reject) ->

  #       profile.set('uuid', uuid)
  #       profile.save().then (profile) ->
  #         resolve(profile)
  #       , (error) ->
  #         reject(error)

`export default profileController`