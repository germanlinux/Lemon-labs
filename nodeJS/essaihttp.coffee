http = require('http')
puts = console.log
http.createServer(  (request,res) =>
            message= "<h1>hello lemonode</h1>"
            buffer= request.headers
            puts buffer
            puts buffer['host']   
            for k of buffer
               message += "<p>" + k + "===>"  + buffer[k] + "</p>" 
            
            res.writeHead(200, { 'Content-Type' : 'text/html' ,'Content-length' : message.length })
            res.write(message)   
            res.end()
            puts "requete:" + request.url               
).listen(8090)
puts "le serveur ecoute sur le port 8090"

