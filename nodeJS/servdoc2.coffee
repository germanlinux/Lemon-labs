http = require('http')
util = require('util')
fs   = require('fs')
path = require('path')

puts = console.log 
# declaration 
inMemoryData   = []
inMemoryHeader = []

if  !process.argv[2] 
   console.log('USAGE: node servdoc.js 8080')
   return
iport = Number( process.argv[2] )

if  !process.argv[3] 
   console.log('USAGE: node servdoc.js 8080 rep')
   return
rep = process.argv[3] 
# IE6 affiche la page d erreur applicative personnalisee que si elle pese un certain poids 
err = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />'

server = http.createServer (request, response) ->
  if inMemoryData[request.url] 
   data   = inMemoryData[request.url]
   header = inMemoryHeader[request.url]
   response.writeHead 200,{'content-type': header}
   response.end data
   puts " #{request.url} found in memory"
  else     
   TDoc = request.url.split('/')
   if  TDoc[1] == rep 
        # test si le fichier existe
        fs.stat '.' + request.url , (error , stats) -> 
             if error 
                response.writeHead(404, {'content-type': 'text/html' } )
                response.end( err + "FICHIER NON TROUVE !!")
             else 
                ext = path.extname( request.url )
                switch( ext )
                   when '.doc' 
                        response.writeHead(200, {'content-type': 'application/msword' } )
                        inMemoryHeader[request.url] = 'application/msword'  
                   when  '.pdf'  
                        response.writeHead(200, {'content-type': 'application/pdf' } )
                        inMemoryHeader[request.url] = 'application/pdf'
                   else 
                        response.writeHead(200, {'content-type': 'text/html' } )
                        inMemoryHeader[request.url] =  'text/html'
                util.pump(fs.createReadStream( '.' + request.url), response)
                fs.readFile '.' + request.url, (error,dataf) -> 
                      inMemoryData[request.url] = dataf
                      puts " #{request.url} stored"
 
   else 
        response.writeHead(404, {'content-type': 'text/html' } )
        response.end( err + "FICHIER NON AUTORISE !!")
server.listen( iport, ->  console.log( 'SERVER NODE OK SUR LE PORT : ' + iport) )

