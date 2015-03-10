`import { test } from 'ember-qunit'`
`import startApp from '../helpers/start-app'`

App = undefined

module 'Index',
  setup: ->
    App = startApp()
    return
  teardown: ->
    Ember.run App, App.destroy
    return

home = '#brand'

test 'Home page', ->
  expect 1
  visit('/').then ->
    ok(exists(home), 'Home has Brand Logo') 