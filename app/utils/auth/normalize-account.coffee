normalizeAccount =
  # ----------------------------------------
  # Twitter
  # ----------------------------------------
  Twitter: (profileRef) ->
    profile = profileRef.toFirebaseJSON().identity
    user = Ember.Object.create
      # id:               profile.uuid
      first:            ''
      last:             ''
      displayName:      profile.screen_name
      name:             profile.name
      tagline:          profile.description
      bio:              profile.description
      image:            profile.profile_image_url
      favourites_count: profile.favourites_count
      followers_count:  profile.followers_count
      friends_count:    profile.friends_count
      url:              profile.url
      profiles:         []
      
    user.get('profiles').addObject(profileRef)
    user


  # ----------------------------------------
  # Github
  # ----------------------------------------
  Github: (profileRef) ->
    profile = profileRef.toFirebaseJSON().identity
    user = Ember.Object.create
      # id:               profile.uuid
      first:            ''
      last:             ''
      displayName:      profile.login || ''
      name:             profile.login || ''
      tagline:          ''
      bio:              ''
      image:            profile.avatar_url
      favourites_count: 0
      followers_count:  profile.followers
      friends_count:    0
      emails:           profile.emails
      url:              profile.url
      profiles:         []

    user.get('profiles').addObject(profileRef)
    user


  # ----------------------------------------
  # facebook
  # ----------------------------------------
  Facebook: (profileRef) ->
    profile = profileRef.toFirebaseJSON().identity
    user = Ember.Object.create
      # id:               profile.uuid
      first:            profile.first_name || ''
      last:             profile.last_name || ''
      displayName:      profile.name || ''
      name:             profile.username || ''
      tagline:          ''
      bio:              ''
      image:            0
      favourites_count: 0
      followers_count:  0
      friends_count:    0
      emails:           ''
      url:              profile.link
      profiles:         []

    user.get('profiles').addObject(profileRef)
    user

`export default normalizeAccount`