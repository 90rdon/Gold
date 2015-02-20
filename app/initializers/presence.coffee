# Takes two parameters: container and app
initialize = (container, app) ->
  presence = container.lookup('controller:presence')
  container.register 'presence:main', presence,
      instantiate: false
      singleton: true

  container.typeInjection 'route',      'presence', 'presence:main'
  container.typeInjection 'controller', 'presence', 'presence:main'
  container.typeInjection 'component',  'presence', 'presence:main'

presenceInitializer =
  name: 'presence'
  after: 'fireplace'
  initialize: initialize

`export {initialize}`
`export default presenceInitializer`
