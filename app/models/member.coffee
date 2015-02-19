`import {Model, attr, hasMany} from 'fireplace'`

member    = Model.extend
  first:            attr()
  last:             attr()
  displayName:      attr()
  name:             attr()
  tagline:          attr()
  bio:              attr()
  image:            attr()
  favourites_count: attr()
  followers_count:  attr()
  friends_count:    attr()
  url:              attr()
  createdOn:        attr()
  status:           attr()
  logon:            attr()

  profiles:         hasMany('profile', embedded: false)

  fullName: (->
    first   = @get('first') || ''
    last    = @get('last') || ''

    return first + ' ' + last
  ).property('first', 'last')
  
`export default member`