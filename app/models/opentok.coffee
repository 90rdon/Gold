opentok    = DS.Model.extend
  opentok:          DS.attr()
  sessionId:        DS.attr()
  token:            DS.attr()
  caller_id:        DS.attr()
  recipient_id:     DS.attr()
  on:               DS.attr()
  off:              DS.attr()

  # onTime: (->
  #   new Date((@get('on') * 1000) + ' UTC').toString()
  # ).property('on')

  # offTime: (->
  #   new Date((@get('off') * 1000) + ' UTC').toString()
  # ).property('off')
  
`export default opentok`