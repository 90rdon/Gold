`import UUID   from '../utils/auth/uuid'`
`import Parse  from '../utils/auth/normalize-account'`
`import config from '../config/environment'`

memberController = Ember.ObjectController.extend
  needs: [
    'presence'
    'profile'
    'members'
    'session'
  ]

  isMe:   false
  status: null
  uuid:   null

  block: (->
    if @get('content.logon')
      if @get('isMe')
        return true
      else
        return false
    else
      return true
  ).property('content.logon')

  findOrCreate: (profile) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      if profile.get('member').get('content')?
        self.get('controllers.members').findByProfile(profile).then (member) ->
          resolve(member)
        , (notFound) ->
          self.create(profile).then (member) ->
            resolve(member)
          , (error) ->
            reject(error)
      else
        if self.get('controllers.session').get('member')?
          resolve(self.get('controllers.session').get('member'))
        else
          self.create(profile).then (member) ->
            resolve(member)
          , (error) ->
            reject(error)

  isNewProfile: (member, profile) ->
    # self = @
    # new Ember.RSVP.Promise (resolve, reject) ->

    #   self.store.find('member', member.id).then (members) ->
    #     resolve(false)  if members.get('length') is 0
    !member.get('profiles').isAny('id', profile.id)

  addProfile: (member, profile) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      # self.get('controllers.profile').updateUUID(profile, member.id)
      if self.isNewProfile(member, profile)
        member.get('profiles').addObject(profile)
        member.save().then (member) ->
          profile.save().then (profile) ->
            resolve(member)
        , (error) ->
          reject(error)

  create: (profile) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      Parse.normalize(profile).then (memberJSON) ->
        # memberJSON.id = profile.toJSON().uuid
        uuid = UUID.createUuid()
        memberJSON.id = uuid
        member = self.store.createRecord('member', memberJSON)
        member.save().then (member) ->
          self.addProfile(member, profile).then (member) ->
            resolve(member)
          , (error) ->
            reject(error)

  refresh: (member, status) ->
    self = @
    return  unless status?
    @set('status', status)
    if member?
      member.set('status', status)
      member.save()

`export default memberController`