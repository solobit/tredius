// Generated by CoffeeScript 1.6.2
var CSON, DocPad, PluginTester, RendererTester, ServerTester, balUtil, expect, extendr, joe, pathUtil, pluginPort, test, testers, _ref, _ref1,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

pathUtil = require('path');

balUtil = require('bal-util');

extendr = require('extendr');

joe = require('joe');

expect = require('chai').expect;

CSON = require('cson');

DocPad = require(__dirname + '/docpad');

pluginPort = 2000 + String((new Date()).getTime()).substr(-6, 4);

testers = {
  CSON: CSON,
  DocPad: DocPad
};

testers.PluginTester = PluginTester = (function() {
  PluginTester.prototype.config = {
    pluginName: null,
    pluginPath: null,
    autoExit: true,
    testPath: null,
    outExpectedPath: null
  };

  PluginTester.prototype.docpadConfig = {
    port: null,
    growl: false,
    logLevel: ((__indexOf.call(process.argv, '-d') >= 0) ? 7 : 5),
    rootPath: null,
    outPath: null,
    srcPath: null,
    pluginPaths: null,
    enableUnlistedPlugins: false,
    enabledPlugins: null,
    skipUnsupportedPlugins: false,
    catchExceptions: false,
    environment: null
  };

  PluginTester.prototype.docpad = null;

  PluginTester.prototype.logger = null;

  function PluginTester(config, docpadConfig, next) {
    var defaultEnabledPlugins, tester, _base, _base1, _base2, _base3, _base4, _base5, _base6, _base7, _base8, _ref, _ref1, _ref2;

    if (config == null) {
      config = {};
    }
    if (docpadConfig == null) {
      docpadConfig = {};
    }
    tester = this;
    this.config = extendr.deepExtendPlainObjects({}, PluginTester.prototype.config, this.config, config);
    this.docpadConfig = extendr.deepExtendPlainObjects({}, PluginTester.prototype.docpadConfig, this.docpadConfig, docpadConfig);
    if ((_ref = (_base = this.docpadConfig).port) == null) {
      _base.port = ++pluginPort;
    }
    if ((_ref1 = (_base1 = this.config).testerName) == null) {
      _base1.testerName = this.config.pluginName;
    }
    (_base2 = this.config).testPath || (_base2.testPath = pathUtil.join(this.config.pluginPath, 'test'));
    (_base3 = this.config).outExpectedPath || (_base3.outExpectedPath = pathUtil.join(this.config.testPath, 'out-expected'));
    (_base4 = this.docpadConfig).rootPath || (_base4.rootPath = this.config.testPath);
    (_base5 = this.docpadConfig).outPath || (_base5.outPath = pathUtil.join(this.docpadConfig.rootPath, 'out'));
    (_base6 = this.docpadConfig).srcPath || (_base6.srcPath = pathUtil.join(this.docpadConfig.rootPath, 'src'));
    if ((_ref2 = (_base7 = this.docpadConfig).pluginPaths) == null) {
      _base7.pluginPaths = [this.config.pluginPath];
    }
    defaultEnabledPlugins = {};
    defaultEnabledPlugins[this.config.pluginName] = true;
    (_base8 = this.docpadConfig).enabledPlugins || (_base8.enabledPlugins = defaultEnabledPlugins);
    joe.describe(this.config.testerName, function(suite, task) {
      tester.describe = tester.suite = suite;
      tester.it = tester.test = task;
      tester.done = tester.exit = function() {};
      return typeof next === "function" ? next(null, tester) : void 0;
    });
    this;
  }

  PluginTester.prototype.testCreate = function() {
    var docpadConfig, tester;

    tester = this;
    docpadConfig = this.docpadConfig;
    this.test("create", function(done) {
      return DocPad.createInstance(docpadConfig, function(err, docpad) {
        if (err) {
          return done(err);
        }
        tester.docpad = docpad;
        tester.logger = docpad.logger;
        return tester.docpad.action('clean', function(err) {
          if (err) {
            return done(err);
          }
          return tester.docpad.action('install', function(err) {
            return done(err);
          });
        });
      });
    });
    return this;
  };

  PluginTester.prototype.testLoad = function() {
    var tester;

    tester = this;
    this.test("load plugin " + tester.config.pluginName, function(done) {
      return tester.docpad.loadedPlugin(tester.config.pluginName, function(err, loaded) {
        if (err) {
          return done(err);
        }
        expect(loaded).to.be.ok;
        return done();
      });
    });
    return this;
  };

  PluginTester.prototype.testServer = function(next) {
    var tester;

    tester = this;
    this.test("server", function(done) {
      return tester.docpad.action('server', function(err) {
        return done(err);
      });
    });
    return this;
  };

  PluginTester.prototype.testGenerate = function() {
    var tester;

    tester = this;
    this.test("generate", function(done) {
      return tester.docpad.action('generate', function(err) {
        return done(err);
      });
    });
    return this;
  };

  PluginTester.prototype.testEverything = function() {
    var tester;

    tester = this;
    this.testCreate();
    this.testLoad();
    this.testGenerate();
    this.testServer();
    if (typeof this.testCustom === "function") {
      this.testCustom();
    }
    this.finish();
    return this;
  };

  PluginTester.prototype.finish = function() {
    var tester;

    tester = this;
    if (tester.config.autoExit) {
      this.test('finish up', function(done) {
        done();
        tester.exit();
        if (tester.config.autoExit !== 'safe') {
          return process.exit();
        }
      });
    }
    return this;
  };

  return PluginTester;

})();

testers.ServerTester = ServerTester = (function(_super) {
  __extends(ServerTester, _super);

  function ServerTester() {
    _ref = ServerTester.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  return ServerTester;

})(PluginTester);

testers.RendererTester = RendererTester = (function(_super) {
  __extends(RendererTester, _super);

  function RendererTester() {
    _ref1 = RendererTester.__super__.constructor.apply(this, arguments);
    return _ref1;
  }

  RendererTester.prototype.testGenerate = function() {
    var tester;

    tester = this;
    this.suite("generate", function(suite, test) {
      test('action', function(done) {
        return tester.docpad.action('generate', function(err) {
          return done(err);
        });
      });
      return test('results', function(done) {
        return balUtil.scantree(tester.docpadConfig.outPath, function(err, outResults) {
          if (err) {
            return done(err);
          }
          return balUtil.scantree(tester.config.outExpectedPath, function(err, outExpectedResults) {
            if (err) {
              return done(err);
            }
            expect(outResults).to.eql(outExpectedResults);
            return done();
          });
        });
      });
    });
    return this;
  };

  return RendererTester;

})(PluginTester);

testers.test = test = function(testerConfig, docpadConfig) {
  var testerClass, _ref2, _ref3;

  testerConfig.pluginPath = pathUtil.resolve(testerConfig.pluginPath);
  if ((_ref2 = testerConfig.pluginName) == null) {
    testerConfig.pluginName = pathUtil.basename(testerConfig.pluginPath);
  }
  if ((_ref3 = testerConfig.testerPath) == null) {
    testerConfig.testerPath = pathUtil.join('out', "" + testerConfig.pluginName + ".tester.js");
  }
  testerConfig.testerPath = pathUtil.resolve(testerConfig.pluginPath, testerConfig.testerPath);
  testerClass = require(testerConfig.testerPath)(testers);
  new testerClass(testerConfig, docpadConfig, function(err, testerInstance) {
    if (err) {
      throw err;
    }
    return testerInstance.testEverything();
  });
  return testers;
};

module.exports = testers;
