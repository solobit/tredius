// Generated by CoffeeScript 1.6.2
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(BasePlugin) {
  var CoffeekupPlugin, _ref;

  return CoffeekupPlugin = (function(_super) {
    __extends(CoffeekupPlugin, _super);

    function CoffeekupPlugin() {
      _ref = CoffeekupPlugin.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    CoffeekupPlugin.prototype.name = 'coffeekup';

    CoffeekupPlugin.prototype.config = {
      coffeecup: {
        format: false
      },
      environments: {
        development: {
          coffeecup: {
            format: true
          }
        }
      }
    };

    CoffeekupPlugin.prototype.renderCoffeeKup = function(opts, next) {
      var ck, ckOptions, content, templateData;

      templateData = opts.templateData, content = opts.content;
      ck = require('coffeecup');
      ckOptions = require('extendr').deepExtendPlainObjects({}, this.config.coffeekup, this.config.coffeecup);
      opts.content = ck.render(content, templateData, ckOptions);
      return next();
    };

    CoffeekupPlugin.prototype.render = function(opts, next) {
      var inExtension, outExtension;

      inExtension = opts.inExtension, outExtension = opts.outExtension;
      if (inExtension === 'coffee' && (outExtension === 'js' || outExtension === 'css') === false) {
        return this.renderCoffeeKup(opts, next);
      } else {
        return next();
      }
    };

    return CoffeekupPlugin;

  })(BasePlugin);
};