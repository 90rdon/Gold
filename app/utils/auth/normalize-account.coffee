`import config from '../../config/environment'`

normalizeAccount =
  normalize: (profile) ->
    self = @
    new Ember.RSVP.Promise (resolve) ->

      switch profile.toJSON().provider
        when 'twitter'    then resolve(self.Twitter(profile))
        when 'github'     then resolve(self.Github(profile))
        when 'facebook'   then resolve(self.Facebook(profile))

  cachedUserProfile: (authData) ->
    self = @
    new Ember.RSVP.Promise (resolve) ->
      switch authData.provider
        when 'twitter'    then resolve(self.TwitterCachedUser(authData))
        when 'github'     then resolve(self.GithubCachedUser(authData))
        when 'facebook'   then resolve(self.FacebookCachedUser(authData))

  # ----------------------------------------
  # Twitter
  # ----------------------------------------
  Twitter: (profileRef) ->
    profile = profileRef.toJSON().identity
    user = 
      # uid:              profileRef.toJSON().uid
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
      url:              profile.url || ''
      emails:           []
      status:           ''
      logged_on:        true

    user

  TwitterCachedUser: (authData) ->
    authData.twitter.cachedUserProfile

  # ----------------------------------------
  # Github
  # ----------------------------------------
  Github: (profileRef) ->
    profile = profileRef.toJSON().identity
    emailObj = profile.emails.find (item, index, self) ->
      item  if item.primary
    user =
      # uid:              profileRef.toJSON().uid
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
      status:           ''
      logged_on:        true

    user

  GithubCachedUser: (authData) ->
    authData.github.cachedUserProfile


  # ----------------------------------------
  # facebook
  # ----------------------------------------
  Facebook: (profileRef) ->
    profile = profileRef.toJSON().identity
    user = 
      # uid:              profileRef.toJSON().uid
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
      url:              profile.link || ''
      emails:           []
      status:           ''
      logged_on:        true

    user

  FacebookCachedUser: (authData) ->
    authData.facebook.cachedUserProfile

`export default normalizeAccount`