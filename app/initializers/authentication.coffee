# Takes two parameters: container and app
initialize = (container, app) ->
  authentication = container.lookup('controller:authentication')
  container.register 'authentication:main', authentication,
      instantiate: false
      singleton: true

  container.typeInjection 'route', 'authentication', 'authentication:main'
  container.typeInjection 'controller', 'authentication', 'authentication:main'
  container.typeInjection 'component', 'authentication', 'authentication:main'

AuthenticationInitializer =
  name: 'authentication'
  after: 'fireplace'
  initialize: initialize

`export {initialize}`
`export default AuthenticationInitializer`
