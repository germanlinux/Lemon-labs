// JavaScript Document
/* Include necessary modules */
var events = require('events');
var querystring = require('querystring');

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

function flasher( j, self ){
  return function () {
    self.emit( 'flash', "mon flash nomme " + j ); 
  };
}

signal.prototype.temporisateur = function() {
  var self= this;
  for (var i= 0; i<5;i++) {
    setTimeout( flasher( i, self ) , 1000 * i );        
  } 
  setTimeout(function(){self.emit('lemoment',"mon message");}, 15000);          
};

signal.prototype.tempopo = function( timing, eventname ) {
  var self= this;
  
  setTimeout(function(){ self.emit( eventname, eventname + " et marche" );}, timing );          

};


module.exports = signal;  
