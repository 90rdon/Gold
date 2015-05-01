/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'gold',
    environment: environment,
    firebase: 'https://linguis.firebaseio.com/',
    baseURL: '/',
    locationType: 'hash',
    natives: [
      'English',
      'Spanish'
    ],
    languages: [
      'Russian',
      'Chinese',
      'French',
      'Portuaguese'
    ],
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
        // 'ember-htmlbars': true
      }
    },

    APP: {
      // firebaseUri: 'https://linguis.firebaseio.com',
      linguisEndpoint: ''
    },

    cordova: {
      rebuildOnChange: true,
      emulate: true,
      liveReload: {
        enabled: true,
        platform: 'ios'
      }
    },

    contentSecurityPolicy: {
      'default-src': "'self'",
      'script-src': "'self' http://127.0.0.1:35729 https://*.firebase.com https://*.firebaseio.com",
      'frame-src': "'self' http://127.0.0.1:35729 //*.firebase.com //*.firebaseio.com",
      'font-src': "'self'",
      'connect-src': "'self' ws://127.0.0.1:35729 wss://*.firebaseio.com",
      'img-src': "'self'",
      'style-src': "'self'",
      'report-uri': "'self' https://*.firebase.com https://*.firebaseio.com",
      'media-src': "'self'"
    },
  };

  ENV['simple-auth'] = {
    serverTokenRevocationEndpoint: '/revoke'
  };

  if (environment === 'development') {
    ENV.APP.LOG_RESOLVER = false;
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_TRANSITIONS = false;
    ENV.APP.LOG_TRANSITIONS_INTERNAL = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'auto';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  return ENV;
};
