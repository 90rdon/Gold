profilesController = Ember.ArrayController.extend
  findAll: (uid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      self.store.fetch 'profile', 
        startAt:  uid
        endAt:    uid

      .then (profiles) ->
        resolve(profiles)
      , (error) ->
        reject(error)

`export default profilesController`