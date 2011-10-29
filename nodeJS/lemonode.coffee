http = require('http')
#sys  = require('sys')
config = require('./config.js')
head   = require('./header.js')
api_request = require('./api_request')

puts = console.log
#load config is requiered 
puts "Lancement de lemonode"
puts "Debut chargement de la configuration" if config.isDebugOn()
my_conf= config.getConfigSync()
puts "acquisition de " + my_conf['global']['port']  if config.isDebugOn() 
puts "Fin chargement de la configuration"  if config.isDebugOn()
puts "Mise en service"  if config.isDebugOn()
my_cookie =  my_conf['global']['cookie'] 
loginPortal = my_conf['global']['portal']
http.createServer(  (request,response) =>
    puts  "headers incoming:" if config.isDebugOn()
    puts request.headers if config.isDebugOn()
    puts request if config.isDebugOn() 
    origine = "http://" + request.headers['host'] + request.url+ "_cookie=" + my_cookie 
    puts request.connection.remoteAddress + ": " + request.method +
    " (HTTP method) " + request.url + " (url on) " + request.headers['host']  if config.isDebugOn()
    # recuperation host et port du  header host
    HP = head.getHostPort( request.headers )
    saveHost = request.headers['host']  
    puts "Cible VIP: #{HP['host']} sur port #{HP['port']}"
    ## aligne des headers
    config_location = my_conf[HP['host']]
    try 
    	targetPort= config_location['port']
    catch error 
        puts "Erreur la location n'existe pas ou est absente de l entete: #{HP['host']}"
        return null
    
    targetHost= config_location['hostname']
    target = targetHost + ":" + targetPort
    puts "Cible RIP :#{targetHost} sur port #{targetPort}" 
    my_headers = head.cloneHeaders(request.headers,target)   
    puts  "headers outcoming:" if config.isDebugOn()
    puts my_headers if config.isDebugOn() 
    ## check session 
    my_session = head.getCookie(request.headers,my_cookie)
    my_session ='rjkgfngkfkj' 
    if my_session 
           puts "session Ok" 
           # retrieve session with cookie number
           r = new api_request('http', 'localhost', 8888)
           r.with_content_type('application/json').
           with_payload( { 'cle' :  my_session}).
             post('/getValue').on('reply', (reply, res) -> 
              			console.log(reply))
				
           puts "ok je suis passe"
    else 
           puts "session failed cookie"
           origine64=  new Buffer(origine)
           locationURL= loginPortal+"?url=" + origine64.toString('base64')  
           puts "Location de redirection: #{locationURL}"
           headerRedirection= 'location' : locationURL 
           response.writeHead(302,headerRedirection)
           response.end()
           return null 

#    proxy = http.createClient(targetPort,targetHost)
#    proxy_request = proxy.request(request.method, request.url, my_headers)
#    proxy_request.addListener('response',  (proxy_response) =>
#          proxy_response.addListener('data',  (chunk) => response.write(chunk, 'binary') )
#          proxy_response.addListener('end',        =>  response.end() )
#          puts "passe #{saveHost}"
#          myHeadersOut = head.cloneHeaders(proxy_response.headers,saveHost)
#          puts myHeadersOut   
#          response.writeHead proxy_response.statusCode, myHeadersOut)
#    request.addListener('data', (chunk)     =>
#                          proxy_request.write(chunk, 'binary'))
#    request.addListener('end',  =>  proxy_request.end()) 
).listen(my_conf['global']['port'] )
puts "le serveur lemonodeJS V0.0 ecoute sur le port #{my_conf['global']['port']} "

