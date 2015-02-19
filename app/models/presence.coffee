`import {Model, attr, hasOne} from 'fireplace'`

presence    = Model.extend
  status:           attr()
  device:           attr()
  ip:               attr()
  meta:             attr()
  data:             attr()
  on:               attr()
  off:              attr()
  session:          hasOne()

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