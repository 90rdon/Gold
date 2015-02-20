`import UUID  from '../utils/auth/uuid'`

profileController = Ember.ObjectController.extend
  create: (identity) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.createRecord 'profile',
        identity:     identity
        uid:          identity.uid
        uuid:         UUID.createUuid()
        provider:     identity.provider

      .save().then (profileRef) ->
        resolve(profileRef)
      , (error) ->
        reject(error)

`export default profileController`