membersController = Ember.ArrayController.extend
  itemController: 'member'

  onLoaded: (->
    console.log 'controller:members:onLoaded'
  ).observes('content.isLoaded')

  findByProfile: (profile) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.find('profile', profile.id).then (profile) ->
        member = profile.get('member')
        return resolve(member)  if member.get('content')?
        reject()
      , (error) ->
        reject(error)

  findByMember: (member) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.find('member', member.id).then (member) ->
        resolve(member)
      , (error) ->
        reject(error)
  
`export default membersController`