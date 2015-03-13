`import config from '../config/environment'`

# Takes two parameters: container and app
initialize = (container, app) ->
  app.__container__.lookup('store:main').set('firebaseRoot', config.APP.firebaseUri)

fireplaceInitializer =
  name: 'fireplace'
  after: 'store'
  initialize: initialize

`export {initialize}`
`export default fireplaceInitializer`