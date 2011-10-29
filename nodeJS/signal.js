var events = require('events');

/*
* Define a non-enumerable function to allow ease of extending objects.
*/
Object.defineProperty(Object.prototype, "extend", {
  enumerable: false,
  value: function (from) {
    var props = Object.getOwnPropertyNames(from);
    var dest = this;
    props.forEach(function(name) {
      var descriptor = Object.getOwnPropertyDescriptor(from, name);
      Object.defineProperty(dest, name, descriptor);
    });
    return this;
  }
});

/*
* Define the main api_request contsructor, also inheirit from EventEmmitter
*/
function signal (data) {
  // Call EventEmitter constructor on this context
  events.EventEmitter.call(this);
 } 
signal.super_ = events.EventEmmitter;
signal.prototype = Object.create(
  events.EventEmitter.prototype,
    {
      constructor: {
      value: signal,
      enumerable: false
      }
    } 
   );


signal.prototype.temporisateur = function() {
         var self = this;
         setTimeout(function(){self.emit('lemoment',"mon message");},5000);          
};

signal.prototype.maint = function() {
        this.emit('ici',"maintenant");          
};


module.exports = signal;  
