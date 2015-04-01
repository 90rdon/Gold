profile   = DS.Model.extend
  identity:     DS.attr()
  uid:          DS.attr()
  # uuid:         DS.attr()
  provider:     DS.attr()
  createdOn:    DS.attr('timestamp', defaultValue: -> Firebase.ServerValue.TIMESTAMP)
  
  member:       DS.belongsTo('member', async: true )

  # priority: (->
  #   @get('uid')
  # ).property('uid')

  # id: (->
  #   @get('id')
  # ).property('id')

`export default profile`