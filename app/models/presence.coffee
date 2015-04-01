presence    = DS.Model.extend
  status:           DS.attr()
  device:           DS.attr()
  ip:               DS.attr()
  meta:             DS.attr()
  # data:             DS.attr('string')
  on:               DS.attr('timestamp', defaultValue: -> Firebase.ServerValue.TIMESTAMP)
  off:              DS.attr('timestamp')

  session:          DS.belongsTo('session', async: true )

  # priority: (->
  #   @get('uuid')
  # ).property('uuid')

  # onTime: (->
  #   new Date((@get('on') * 1000) + ' UTC').toString()
  # ).property('on')

  # offTime: (->
  #   new Date((@get('off') * 1000) + ' UTC').toString()
  # ).property('off')
  
`export default presence`