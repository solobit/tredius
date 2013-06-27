// Generated by CoffeeScript 1.6.2
var Backbone, Collection, Events, Model, QueryCollection, View, emit, extendr, log, queryEngine, _ref, _ref1, _ref2, _ref3,
  __slice = [].slice,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

extendr = require('extendr');

queryEngine = require('query-engine');

Backbone = queryEngine.Backbone;

log = function() {
  var args;

  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  args.unshift('log');
  this.emit.apply(this, args);
  return this;
};

emit = function() {
  var args;

  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  return this.trigger.apply(this, args);
};

Events = (function() {
  function Events() {}

  Events.prototype.log = log;

  Events.prototype.emit = emit;

  return Events;

})();

extendr.extend(Events.prototype, Backbone.Events);

Model = (function(_super) {
  __extends(Model, _super);

  function Model() {
    _ref = Model.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Model.prototype.log = log;

  Model.prototype.emit = emit;

  Model.prototype.setDefaults = function(defaults) {
    var key, set, value, _ref1;

    set = {};
    for (key in defaults) {
      if (!__hasProp.call(defaults, key)) continue;
      value = defaults[key];
      if (this.get(key) === ((_ref1 = this.defaults) != null ? _ref1[key] : void 0)) {
        set[key] = value;
      }
    }
    this.set(set);
    return this;
  };

  return Model;

})(Backbone.Model);

Collection = (function(_super) {
  __extends(Collection, _super);

  function Collection() {
    this.destroy = __bind(this.destroy, this);    _ref1 = Collection.__super__.constructor.apply(this, arguments);
    return _ref1;
  }

  Collection.prototype.log = log;

  Collection.prototype.emit = emit;

  Collection.prototype.destroy = function() {
    this.emit('destroy');
    this.off().stopListening();
    return this;
  };

  return Collection;

})(Backbone.Collection);

View = (function(_super) {
  __extends(View, _super);

  function View() {
    _ref2 = View.__super__.constructor.apply(this, arguments);
    return _ref2;
  }

  View.prototype.log = log;

  View.prototype.emit = emit;

  return View;

})(Backbone.View);

QueryCollection = (function(_super) {
  __extends(QueryCollection, _super);

  function QueryCollection() {
    this.destroy = __bind(this.destroy, this);    _ref3 = QueryCollection.__super__.constructor.apply(this, arguments);
    return _ref3;
  }

  QueryCollection.prototype.log = log;

  QueryCollection.prototype.emit = emit;

  QueryCollection.prototype.Collection = QueryCollection;

  QueryCollection.prototype.setParentCollection = function() {
    var parentCollection;

    QueryCollection.__super__.setParentCollection.apply(this, arguments);
    parentCollection = this.getParentCollection();
    parentCollection.on('destroy', this.destroy);
    return this;
  };

  QueryCollection.prototype.destroy = function() {
    this.emit('destroy');
    this.off().stopListening();
    return this;
  };

  return QueryCollection;

})(queryEngine.QueryCollection);

module.exports = {
  queryEngine: queryEngine,
  Backbone: Backbone,
  Events: Events,
  Model: Model,
  Collection: Collection,
  View: View,
  QueryCollection: QueryCollection
};