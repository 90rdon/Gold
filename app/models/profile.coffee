`import {Model, attr} from 'fireplace'`

profile   = Model.extend
  identity:     attr()
  uid:          attr()
  uuid:         attr()
  provider:     attr()
  createdOn:    attr('date', default: -> Firebase.ServerValue.TIMESTAMP)

  priority: (->
    @get('uid')
  ).property('uid')

  # id: (->
  #   @get('id')
  # ).property('id')

`export default profile`