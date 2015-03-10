indexController = Ember.ObjectController.extend
  needs: [
    # 'members'
    'authentication'
  ]

  # search:     null
  # memberList: null

  # membersIsLoaded: (->
  #   @set('memberList', @get('controllers.members'))
  # ).observes('controllers.members.content.isLoaded')

  # searching: (->
  #   self = @
  #   Ember.run.later ->
  #     self.get('filtered')
  #   , 5
  # ).observes('search')

  # sorted: (->
  #   console.log 'sorted'
  #   result = Em.ArrayProxy.createWithMixins Em.SortableMixin,
  #     content:@get('filteredContent')
  #     sortProperties: @get('sortProperties')
  #     sortAscending: @get('sortAscending')
  #   @set('memberList', result)
  # ).observes('arrangedContent', 'sortAscending')

  # changed: (->
  #   @get('filtered')
  # ).observes('content.@each')

  # filteredContent: (->
  #   regexp = new RegExp(@get('search'), 'i')
  #   result = @get('controllers.members.content').filter (item) ->
  #     hasMatch = item.get('constructor.attributes.keys.list').filter (prop) ->
  #       regexp.test item.get(prop)

  #     if hasMatch.length > 0 then true else false
  # ).property('search', 'controllers.members')

  # filtered: (->
  #   result = Em.ArrayProxy.createWithMixins Em.SortableMixin,
  #     content:@get('filteredContent')
  #     sortProperties: @get('sortProperties')
  #     sortAscending: @get('sortAscending')
  #   @set('memberList', result)
  # ).property('filteredContent')

  actions:
    login: (provider) ->
      @get('controllers.authentication').login provider

    logout: ->
      @get('controllers.authentication').logout()

`export default indexController`