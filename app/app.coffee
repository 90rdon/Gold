`import Ember from 'ember'`
`import Resolver from 'ember/resolver'`
`import loadInitializers from 'ember/load-initializers'`
`import config from './config/environment'`

Ember.MODEL_FACTORY_INJECTIONS = true

App = Ember.Application.extend
  modulePrefix: config.modulePrefix
  podModulePrefix: config.podModulePrefix
  Resolver: Resolver

App.reopen
  ready: ->
    console.log 'App ready!! --- init firebaseUri ---'
    @__container__.lookup('store:main').set('firebaseRoot', config.APP.firebaseUri)
    console.log 'App initialized'

loadInitializers(App, config.modulePrefix)

`export default App`
