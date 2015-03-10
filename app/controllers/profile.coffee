`import UUID from '../utils/auth/uuid'`

profileController = Ember.ObjectController.extend
  needs: [
    'profiles'
  ]

  createOrUpdate: (authData, cachedUserProfile) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profiles').findAll(authData.uid).then (profiles) ->
        if profiles.get('length') is 0

          profileRef = self.store.createRecord 'profile',
            identity:     cachedUserProfile
            uid:          authData.uid
            uuid:         UUID.createUuid()
            provider:     authData.provider

          .save().then (profileRef) ->
            resolve(profileRef)
          , (error) ->
            reject(error)
        else
          resolve(profiles.get('lastObject'))

`export default profileController`