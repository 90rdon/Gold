profilesController = Ember.ArrayController.extend
  findAllByUid: (uid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      self.store.findQuery 'profile',
        orderBy:  'uid'
        equalTo:  uid

      .then (profiles) ->
        resolve(profiles)
      , (error) ->
        reject(error)

  findLastOne: (uid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      self.store.findQuery 'profile', 
        orderBy:        'uid'
        equalTo:        uid
        limitToLast:    1

      .then (profiles) ->
        resolve(profiles.get('firstObject'))
      , (error) ->
        reject(error)

`export default profilesController`