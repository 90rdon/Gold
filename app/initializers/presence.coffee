# Takes two parameters: container and app
initialize = (container, app) ->
  presence = container.lookup('controller:presence')
  container.register 'presence:main', presence,
      instantiate: false
      singleton: true

  # container.typeInjection 'route',      'presence', 'presence:main'
  container.typeInjection 'controller:authentication', 'presence', 'presence:main'
  # container.typeInjection 'component',  'presence', 'presence:main'

presenceInitializer =
  name: 'presence'
  after: 'store'
  initialize: initialize

`export {initialize}`
`export default presenceInitializer`
