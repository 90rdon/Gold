`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'member', path: '/:member_id'
  @route 'call', path: '/call/:call_id'

`export default Router`
