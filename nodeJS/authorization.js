(function() {
  var Authorization, EventEmitter, puts;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  EventEmitter = require('events').EventEmitter;
  puts = console.log;
  Authorization = (function() {
    __extends(Authorization, EventEmitter);
    function Authorization() {
      Authorization.__super__.constructor.apply(this, arguments);
    }
    Authorization.prototype.compute = function(reply, origine, loginPortal, codeappli, cookie) {
      var dente, entete, linehabilitation, locationURL, origine64, user;
      puts("codeappli: " + codeappli);
      if (reply.result === 'notok') {
        puts("session failed");
        origine64 = new Buffer(origine + "_cookie=" + cookie);
        locationURL = loginPortal + "?url=" + origine64.toString('base64');
        puts("signal emited: expired ! Location de redirection: " + origine64);
        this.emit('expired', locationURL);
      }
      if (reply.result === 'ok') {
        puts("session ok - suite des controles ");
        origine64 = new Buffer(origine);
        locationURL = origine64.toString('base64');
        linehabilitation = reply['valeur']['habilit'];
        if (linehabilitation == null) {
          linehabilitation = [];
        }
        user = reply['valeur']['user'];
        if (__indexOf.call(linehabilitation, codeappli) >= 0) {
          puts("user " + user + " granted on " + codeappli);
          puts("signal emited: auth ! for " + origine64);
          dente = user + ':0';
          entete = new Buffer(dente).toString('base64');
          puts("entete avant encodage:" + dente);
          puts("entete apres encodage:" + entete);
          return this.emit('auth', entete);
        } else {
          puts("user " + user + " NOT granted on " + codeappli);
          puts("signal emited: no-auth ! Location de redirection: " + origine64);
          return this.emit('no-auth', locationURL);
        }
      }
    };
    return Authorization;
  })();
  module.exports = Authorization;
}).call(this);
