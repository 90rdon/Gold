# Takes two parameters: container and app
initialize = (container, app) ->
  session = container.lookup('controller:session')
  container.register 'session:main', session,
      instantiate: false
      singleton: true

  container.typeInjection 'route', 'session', 'session:main'
  container.typeInjection 'controller', 'session', 'session:main'
  container.typeInjection 'component', 'session', 'session:main'

SessionInitializer =
  name: 'session'
  after: 'authentication'
  initialize: initialize

`export {initialize}`
`export default SessionInitializer`
