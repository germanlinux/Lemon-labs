{EventEmitter} = require('events')
querystring = require('querystring')


class Signal extends EventEmitter 
 maint: -> 
   @emit 'ici','maintenant' 

 temporisateur: ->
   setTimeout ( => @emit 'lemoment',"le message est arrive") , 5000 	


module.exports = Signal
