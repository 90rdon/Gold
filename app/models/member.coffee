member      = DS.Model.extend
  # uid:              DS.attr()
  first:            DS.attr()
  last:             DS.attr()
  displayName:      DS.attr()
  name:             DS.attr()
  tagline:          DS.attr()
  bio:              DS.attr()
  image:            DS.attr()
  favourites_count: DS.attr()
  followers_count:  DS.attr()
  friends_count:    DS.attr()
  primary_email:    DS.attr()
  emails:           DS.attr()
  url:              DS.attr()
  joined_on:        DS.attr('timestamp', defaultValue: -> Firebase.ServerValue.TIMESTAMP)
  status:           DS.attr()
  logged_on:        DS.attr()

  profiles:         DS.hasMany('profile', async: true )
  sessions:         DS.hasMany('session', async: true )

  # fullName: (->
  #   first   = @get('first') || ''
  #   last    = @get('last') || ''

  #   return first + ' ' + last
  # ).property('first', 'last')
  
`export default member`