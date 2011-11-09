{EventEmitter} = require('events')
puts = console.log
class Authorization extends EventEmitter 
  compute  :(reply,origine,loginPortal ,codeappli,cookie)  -> 
    puts "codeappli: #{codeappli}"
    if (reply.result == 'notok') 
          puts "session failed"
          origine64=  new Buffer(origine + "_cookie=" + cookie)
          locationURL= loginPortal+"?url=" + origine64.toString('base64')  
          puts "signal emited: expired ! Location de redirection: #{origine64}"
          @emit 'expired',locationURL 
    if  (reply.result == 'ok') 
          puts "session ok - suite des controles "
          # granted du couple application - habilitation
          origine64=  new Buffer(origine)
          locationURL= origine64.toString('base64')  
          linehabilitation = reply['valeur']['habilit']
          linehabilitation ?= []
          user =  reply['valeur']['user']
          if codeappli in linehabilitation
               puts "user #{user} granted on #{codeappli}"
               puts "signal emited: auth ! for #{origine64}"
               dente = user+':0'  
               entete= new Buffer(dente).toString('base64')  
               puts "entete avant encodage:#{dente}"
               puts "entete apres encodage:#{entete}" 
               @emit 'auth',entete
          else   
               puts "user #{user} NOT granted on #{codeappli}"
               puts "signal emited: no-auth ! Location de redirection: #{origine64}"
               @emit 'no-auth',locationURL
    
module.exports = Authorization
