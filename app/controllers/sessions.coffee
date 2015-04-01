`import config from '../config/environment'`

sessionsController = Ember.ObjectController.extend
  needs: [
  ]

  alive: (member) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.findQuery 'session',
        orderBy:    'member'
        startAt:    member.id
        endAt:      member.id

      .then (sessions) ->
        return resolve()  if sessions.get('length') is 0
        return resolve(sessions.get('firstObject'))  if sessions.get('length') is 1
        sessions.find (item, index, enumerable) ->
          return resolve(item)  if item.off is null
          reject()
        , (error) ->
          reject(error)
      , (error) ->
        reject(error)

`export default sessionsController`