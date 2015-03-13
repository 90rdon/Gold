session    = DS.Model.extend
  on:               DS.attr('timestamp', defaultValue: -> Firebase.ServerValue.TIMESTAMP)
  off:              DS.attr('timestamp')
  
  member:           DS.belongsTo('member', async: true )
  presences:        DS.hasMany('presence', async: true )
  
  # priority: (->
  #   @get('member').get('id')
  # ).property('member.id')

  # onTime: (->
  #   new Date((@get('on') * 1000) + ' UTC').toString()
  # ).property('on')

  # offTime: (->
  #   new Date((@get('off') * 1000) + ' UTC').toString()
  # ).property('off')
  
`export default session`