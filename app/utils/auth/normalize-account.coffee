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
      displayName:      profile.twitter.cachedUserProfile.screen_name
      name:             profile.twitter.cachedUserProfile.name
      tagline:          ''
      bio:              profile.twitter.cachedUserProfile.description
      image:            profile.twitter.cachedUserProfile.profile_image_url
      favourites_count: profile.twitter.cachedUserProfile.favourites_count
      followers_count:  profile.twitter.cachedUserProfile.followers_count
      friends_count:    profile.twitter.cachedUserProfile.friends_count
      url:              profile.twitter.cachedUserProfile.url
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
      displayName:      profile.github.displayName || ''
      name:             profile.github.username || ''
      tagline:          ''
      bio:              ''
      image:            profile.github.cachedUserProfile.avatar_url
      favourites_count: 0
      followers_count:  profile.github.cachedUserProfile.followers
      friends_count:    0
      email:            profile.github.email
      url:              profile.github.cachedUserProfile.url
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
      first:            profile.facebook.cachedUserProfile.first_name || ''
      last:             profile.facebook.cachedUserProfile.last_name || ''
      displayName:      profile.facebook.cachedUserProfile.displayName || ''
      name:             profile.facebook.cachedUserProfile.name || ''
      tagline:          ''
      bio:              ''
      image:            profile.facebook.cachedUserProfile.picture.data.url
      favourites_count: 0
      followers_count:  0
      friends_count:    0
      emails:           ''
      url:              profile.facebook.cachedUserProfile.link
      profiles:         []

    user.get('profiles').addObject(profileRef)
    user

`export default normalizeAccount`