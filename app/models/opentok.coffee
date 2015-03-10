`import {Model, attr, hasOne, hasMany} from 'fireplace'`

opentok    = Model.extend
  opentok:          attr()
  sessionId:        attr()
  token:            attr()
  caller_id:        attr()
  recipient_id:     attr()
  on:               attr()
  off:              attr()

  onTime: (->
    new Date((@get('on') * 1000) + ' UTC').toString()
  ).property('on')

  offTime: (->
    new Date((@get('off') * 1000) + ' UTC').toString()
  ).property('off')
  
`export default opentok`