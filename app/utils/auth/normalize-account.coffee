normalizeAccount =
  # ----------------------------------------
  # Twitter
  # ----------------------------------------
  Twitter: (profileRef) ->
    profile = profileRef.toFirebaseJSON().identity
    user = Ember.Object.create
      uid:              profileRef.toFirebaseJSON().uid
      first:            ''
      last:             ''
      displayName:      profile.screen_name || ''
      name:             profile.name || ''
      tagline:          ''
      bio:              profile.description || ''
      image:            profile.profile_image_url || ''
      favourites_count: profile.favourites_count || 0
      followers_count:  profile.followers_count || 0
      friends_count:    profile.friends_count || 0
      primary_email:    ''
      emails:           []
      url:              profile.url || ''
      profiles:         []
      
    user.get('profiles').addObject(profile)
    user

  TwitterCachedUser: (authData) ->
    authData.twitter.cachedUserProfile

  # ----------------------------------------
  # Github
  # ----------------------------------------
  Github: (profileRef) ->
    profile = profileRef.toFirebaseJSON().identity
    emailObj = profile.emails.find (item, index, self) ->
      item  if item.primary
    user = Ember.Object.create
      uid:              profileRef.toFirebaseJSON().uid
      first:            ''
      last:             ''
      displayName:      profile.name || ''
      name:             profile.login || ''
      tagline:          ''
      bio:              ''
      image:            profile.avatar_url || ''
      favourites_count: 0
      followers_count:  profile.followers || 0
      friends_count:    0
      primary_email:    emailObj.email || ''
      emails:           profile.emails || []
      url:              profile.url || ''
      profiles:         []

    user.get('profiles').addObject(profileRef)
    user

  GithubCachedUser: (authData) ->
    authData.github.cachedUserProfile


  # ----------------------------------------
  # facebook
  # ----------------------------------------
  Facebook: (profileRef) ->
    profile = profileRef.toFirebaseJSON().identity
    user = Ember.Object.create
      uid:              profileRef.toFirebaseJSON().uid
      first:            profile.first_name || ''
      last:             profile.last_name || ''
      displayName:      profile.displayName || ''
      name:             profile.name || ''
      tagline:          ''
      bio:              ''
      image:            profile.picture.data.url || ''
      favourites_count: 0
      followers_count:  0
      friends_count:    0
      primary_email:    ''
      emails:           []
      url:              profile.link || ''
      profiles:         []

    user.get('profiles').addObject(profile)
    user

  FacebookCachedUser: (authData) ->
    authData.facebook.cachedUserProfile

`export default normalizeAccount`