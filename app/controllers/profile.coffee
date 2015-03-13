`import UUID from '../utils/auth/uuid'`

profileController = Ember.ObjectController.extend
  needs: [
    'profiles'
  ]

  createOrUpdate: (authData, cachedUserProfile) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profiles').findAllByUid(authData.uid).then (profiles) ->
        if profiles.get('length') is 0

          profile = self.store.createRecord 'profile',
            identity:     cachedUserProfile
            uid:          authData.uid
            uuid:         UUID.createUuid()
            provider:     authData.provider

          .save().then (profile) ->
            resolve(profile)
          , (error) ->
            reject(error)
        else
          resolve(profiles.get('lastObject'))

`export default profileController`