define("gold/app", 
  ["ember","ember/resolver","ember/load-initializers","gold/config/environment","exports"],
  function(__dependency1__, __dependency2__, __dependency3__, __dependency4__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    var Resolver = __dependency2__["default"];
    var loadInitializers = __dependency3__["default"];
    var config = __dependency4__["default"];
    var App;

    Ember.MODEL_FACTORY_INJECTIONS = true;

    App = Ember.Application.extend({
      modulePrefix: config.modulePrefix,
      podModulePrefix: config.podModulePrefix,
      Resolver: Resolver
    });

    loadInitializers(App, config.modulePrefix);

    __exports__["default"] = App;
  });
define("gold/collections/indexed", 
  ["fireplace","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var IndexedCollection = __dependency1__.IndexedCollection;
    __exports__["default"] = IndexedCollection;
  });
define("gold/collections/object", 
  ["fireplace","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var ObjectCollection = __dependency1__.ObjectCollection;
    __exports__["default"] = ObjectCollection;
  });
define("gold/components/cdv-nav-bar", 
  ["ember","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];

    __exports__["default"] = Ember.Component.extend({
      tagName: 'header'
    });
  });
define("gold/data-adapters/main", 
  ["fireplace/system/debug-adapter","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Adapter = __dependency1__["default"];

    __exports__["default"] = Adapter;
  });
define("gold/initializers/export-application-global", 
  ["ember","gold/config/environment","exports"],
  function(__dependency1__, __dependency2__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    var config = __dependency2__["default"];

    function initialize(container, application) {
      var classifiedName = Ember.String.classify(config.modulePrefix);

      if (config.exportApplicationGlobal) {
        window[classifiedName] = application;
      }
    };
    __exports__.initialize = initialize;
    __exports__["default"] = {
      name: 'export-application-global',

      initialize: initialize
    };
  });
define("gold/initializers/in-app-livereload", 
  ["gold/config/environment","ember-cli-cordova/initializers/in-app-livereload","exports"],
  function(__dependency1__, __dependency2__, __exports__) {
    "use strict";
    /* globals cordova */

    var config = __dependency1__["default"];
    var reloadInitializer = __dependency2__["default"];

    var inAppReload = reloadInitializer.initialize;

    var initialize = function(container, app) {
      if(typeof cordova === 'undefined' ||
          config.environment !== 'development' ||
          (config.cordova &&
            (!config.cordova.liveReload || !config.cordova.liveReload.enabled))) {
        return;
      }

      return inAppReload(container, app, config);
    };
    __exports__.initialize = initialize;
    __exports__["default"] = {
      name: 'cordova:in-app-livereload',
      initialize: initialize
    };
  });
define("gold/initializers/store", 
  ["exports"],
  function(__exports__) {
    "use strict";
    __exports__["default"] = {
      name: 'fireplace:inject-store',

      initialize: function(container, application) {
        application.inject('controller',   'store', 'store:main');
        application.inject('route',        'store', 'store:main');
        application.inject('data-adapter', 'store', 'store:main');
        application.inject('collection',   'store', 'store:main');
        application.inject('component',    'store', 'store:main');
      }
    };
  });
define("gold/router", 
  ["ember","gold/config/environment","exports"],
  function(__dependency1__, __dependency2__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    var config = __dependency2__["default"];
    var Router;

    Router = Ember.Router.extend({
      location: config.locationType
    });

    Router.map(function() {});

    __exports__["default"] = Router;
  });
define("gold/routes/application", 
  ["ember","simple-auth/mixins/application-route-mixin","exports"],
  function(__dependency1__, __dependency2__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    var ApplicationRouteMixin = __dependency2__["default"];
    __exports__["default"] = Ember.Route.extend(ApplicationRouteMixin);
  });
define("gold/routes/member", 
  ["ember","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    var memberRoute;

    memberRoute = Ember.Route.extend({
      actions: {
        signIn: function() {
          var controller;
          controller = this.controllerFor('member');
          return this.get('torii').open('facebook-connect').then(function(authorization) {
            return controller.set('hasFacebook', true);
          });
        }
      },
      model: function(params) {
        return null;
      },
      setupController: function(controller, model, params) {
        return console.log('route:member.setupController.params = ' + params);
      }
    });

    __exports__["default"] = memberRoute;
  });
define("gold/stores/main", 
  ["fireplace","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Store = __dependency1__.Store;

    __exports__["default"] = Store;
  });
define("gold/templates/application", 
  ["exports"],
  function(__exports__) {
    "use strict";
    __exports__["default"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
    this.compilerInfo = [4,'>= 1.0.0'];
    helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
      var buffer = '', stack1;


      data.buffer.push("<h2 id=\"title\">Welcome to Ember.js</h2>");
      stack1 = helpers._triageMustache.call(depth0, "outlet", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      return buffer;
      
    });
  });
define("gold/templates/cdv-generic-nav-bar", 
  ["ember","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    __exports__["default"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
    this.compilerInfo = [4,'>= 1.0.0'];
    helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
      var buffer = '', stack1, escapeExpression=this.escapeExpression, self=this;

    function program1(depth0,data) {
      
      var buffer = '', stack1;
      data.buffer.push("\n  <button ");
      data.buffer.push(escapeExpression(helpers.action.call(depth0, "leftButton", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
      data.buffer.push(">\n    ");
      stack1 = helpers['if'].call(depth0, "nav.leftButton.icon", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(2, program2, data),contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n    ");
      stack1 = helpers._triageMustache.call(depth0, "nav.leftButton.text", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n  </button>\n");
      return buffer;
      }
    function program2(depth0,data) {
      
      var buffer = '';
      data.buffer.push("\n      <i ");
      data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
        'class': (":icon nav.leftButton.icon")
      },hashTypes:{'class': "STRING"},hashContexts:{'class': depth0},contexts:[],types:[],data:data})));
      data.buffer.push("></i>\n    ");
      return buffer;
      }

    function program4(depth0,data) {
      
      var buffer = '', stack1;
      data.buffer.push("\n  <h1>\n    ");
      stack1 = helpers._triageMustache.call(depth0, "nav.title.text", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n  </h1>\n");
      return buffer;
      }

    function program6(depth0,data) {
      
      var buffer = '', stack1;
      data.buffer.push("\n  <button ");
      data.buffer.push(escapeExpression(helpers.action.call(depth0, "rightButton", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
      data.buffer.push(">\n    ");
      stack1 = helpers['if'].call(depth0, "nav.rightButton.icon", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(7, program7, data),contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n    ");
      stack1 = helpers._triageMustache.call(depth0, "nav.rightButton.text", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n  </button>\n");
      return buffer;
      }
    function program7(depth0,data) {
      
      var buffer = '';
      data.buffer.push("\n      <i ");
      data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
        'class': (":icon nav.rightButton.icon")
      },hashTypes:{'class': "STRING"},hashContexts:{'class': depth0},contexts:[],types:[],data:data})));
      data.buffer.push("></i>\n    ");
      return buffer;
      }

      stack1 = helpers['if'].call(depth0, "nav.leftButton.text", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n\n");
      stack1 = helpers['if'].call(depth0, "nav.title.text", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(4, program4, data),contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n\n");
      stack1 = helpers['if'].call(depth0, "nav.rightButton.text", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(6, program6, data),contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n");
      return buffer;
      
    });
  });
define("gold/templates/components/cdv-nav-bar", 
  ["ember","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    __exports__["default"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
    this.compilerInfo = [4,'>= 1.0.0'];
    helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
      var buffer = '', stack1;


      stack1 = helpers._triageMustache.call(depth0, "yield", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      data.buffer.push("\n");
      return buffer;
      
    });
  });
define("gold/templates/index", 
  ["exports"],
  function(__exports__) {
    "use strict";
    __exports__["default"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
    this.compilerInfo = [4,'>= 1.0.0'];
    helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
      


      data.buffer.push("<h4>Index</h4>Gold");
      
    });
  });
define("gold/templates/member", 
  ["exports"],
  function(__exports__) {
    "use strict";
    __exports__["default"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
    this.compilerInfo = [4,'>= 1.0.0'];
    helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
      var stack1, escapeExpression=this.escapeExpression, self=this;

    function program1(depth0,data) {
      
      
      data.buffer.push("<h2>Logged in with Facebook</h2>");
      }

    function program3(depth0,data) {
      
      var buffer = '';
      data.buffer.push("<a ");
      data.buffer.push(escapeExpression(helpers.action.call(depth0, "signIn", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
      data.buffer.push(" href=\"#\">Sign in</a>");
      return buffer;
      }

      stack1 = helpers['if'].call(depth0, "hasFacebook", {hash:{},hashTypes:{},hashContexts:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],data:data});
      if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
      else { data.buffer.push(''); }
      
    });
  });
define("gold/tests/gold/tests/helpers/resolver.jshint", 
  [],
  function() {
    "use strict";
    module('JSHint - gold/tests/helpers');
    test('gold/tests/helpers/resolver.js should pass jshint', function() { 
      ok(true, 'gold/tests/helpers/resolver.js should pass jshint.'); 
    });
  });
define("gold/tests/gold/tests/helpers/start-app.jshint", 
  [],
  function() {
    "use strict";
    module('JSHint - gold/tests/helpers');
    test('gold/tests/helpers/start-app.js should pass jshint', function() { 
      ok(true, 'gold/tests/helpers/start-app.js should pass jshint.'); 
    });
  });
define("gold/tests/gold/tests/test-helper.jshint", 
  [],
  function() {
    "use strict";
    module('JSHint - gold/tests');
    test('gold/tests/test-helper.js should pass jshint', function() { 
      ok(true, 'gold/tests/test-helper.js should pass jshint.'); 
    });
  });
define("gold/tests/helpers/resolver", 
  ["ember/resolver","gold/config/environment","exports"],
  function(__dependency1__, __dependency2__, __exports__) {
    "use strict";
    var Resolver = __dependency1__["default"];
    var config = __dependency2__["default"];

    var resolver = Resolver.create();

    resolver.namespace = {
      modulePrefix: config.modulePrefix,
      podModulePrefix: config.podModulePrefix
    };

    __exports__["default"] = resolver;
  });
define("gold/tests/helpers/start-app", 
  ["ember","gold/app","gold/router","gold/config/environment","exports"],
  function(__dependency1__, __dependency2__, __dependency3__, __dependency4__, __exports__) {
    "use strict";
    var Ember = __dependency1__["default"];
    var Application = __dependency2__["default"];
    var Router = __dependency3__["default"];
    var config = __dependency4__["default"];

    __exports__["default"] = function startApp(attrs) {
      var application;

      var attributes = Ember.merge({}, config.APP);
      attributes = Ember.merge(attributes, attrs); // use defaults, but you can override;

      Ember.run(function() {
        application = Application.create(attributes);
        application.setupForTesting();
        application.injectTestHelpers();
      });

      return application;
    }
  });
define("gold/tests/test-helper", 
  ["gold/tests/helpers/resolver","ember-qunit"],
  function(__dependency1__, __dependency2__) {
    "use strict";
    var resolver = __dependency1__["default"];
    var setResolver = __dependency2__.setResolver;

    setResolver(resolver);

    document.write('<div id="ember-testing-container"><div id="ember-testing"></div></div>');

    QUnit.config.urlConfig.push({ id: 'nocontainer', label: 'Hide container'});
    var containerVisibility = QUnit.urlParams.nocontainer ? 'hidden' : 'visible';
    document.getElementById('ember-testing-container').style.visibility = containerVisibility;
  });
define("gold/transforms/boolean", 
  ["fireplace/transforms/boolean","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Transform = __dependency1__["default"];
    __exports__["default"] = Transform;
  });
define("gold/transforms/date", 
  ["fireplace/transforms/date","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Transform = __dependency1__["default"];
    __exports__["default"] = Transform;
  });
define("gold/transforms/hash", 
  ["fireplace/transforms/hash","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Transform = __dependency1__["default"];
    __exports__["default"] = Transform;
  });
define("gold/transforms/number", 
  ["fireplace/transforms/number","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Transform = __dependency1__["default"];
    __exports__["default"] = Transform;
  });
define("gold/transforms/string", 
  ["fireplace/transforms/string","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Transform = __dependency1__["default"];
    __exports__["default"] = Transform;
  });
define("gold/transforms/timestamp", 
  ["fireplace/transforms/timestamp","exports"],
  function(__dependency1__, __exports__) {
    "use strict";
    var Transform = __dependency1__["default"];
    __exports__["default"] = Transform;
  });
/* jshint ignore:start */

define('gold/config/environment', ['ember'], function(Ember) {
  var prefix = 'gold';
/* jshint ignore:start */

try {
  var metaName = prefix + '/config/environment';
  var rawConfig = Ember['default'].$('meta[name="' + metaName + '"]').attr('content');
  var config = JSON.parse(unescape(rawConfig));

  return { 'default': config };
}
catch(err) {
  throw new Error('Could not read config from meta tag with name "' + metaName + '".');
}

/* jshint ignore:end */

});

if (runningTests) {
  require("gold/tests/test-helper");
} else {
  require("gold/app")["default"].create({"firebaseUri":"https://linguis.firebaseio.com/","linguisEndpoint":"","LOG_RESOLVER":true,"LOG_ACTIVE_GENERATION":true,"LOG_TRANSITIONS":true,"LOG_TRANSITIONS_INTERNAL":true,"LOG_VIEW_LOOKUPS":true});
}

/* jshint ignore:end */
//# sourceMappingURL=gold.map