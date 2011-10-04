http = require('http')
#sys  = require('sys')
config = require('./config.js')
head   = require('./header.js')


debug= true
puts = console.log
#load config is requiered 
puts "Lancement de lemonode"
puts "Debut chargement de la configuration"
my_conf= config.getConfigSync()
puts "acquisition de " + my_conf['global']['port'] 
puts "Fin chargement de la configuration"
puts "Mise en service"
my_cookie =  my_conf['global']['cookie'] 
http.createServer(  (request,response) =>
    puts  request.headers if debug
    puts request.connection.remoteAddress + ": " + request.method +
    " (HTTP method) " + request.url + " (url on) " + request.headers['host']  if debug
    # recuperation host et port du  header host
    HP = head.getHostPort( request.headers )
    puts "Cible VIP: #{HP['host']} sur port #{HP['port']}"
    ## aligne des headers
    config_location = my_conf(HP['host'])
    targetPort= config_location['port']
    targetHost= config_location['hostname']
    target= targetHost + ":" + targetPort
    puts "Cible RIP :#{targetHost} sur port #{targetPort}" 
    my_headers = head.cloneHeader(request.headers,target)   
    ## check session 
    my_session = head.getCookie(request.headers,my_cookie) 
    if my_session 
           puts "session Ok" 
    else 
           puts "session failed cookie"
    
    proxy = http.createClient(targetPort,targetHost)
    proxy_request = proxy.request(request.method, request.url, my_headers)
    proxy_request.addListener('response',  (proxy_response) =>
          proxy_response.addListener('data',  (chunk) => response.write(chunk, 'binary') )
          proxy_response.addListener('end',        =>  response.end() )
          response.writeHead proxy_response.statusCode, proxy_response.headers)
    request.addListener('data', (chunk)     =>
                          proxy_request.write(chunk, 'binary'))
    request.addListener('end',  =>  proxy_request.end()) 
).listen(my_conf['global']['port'] )
puts "le serveur ecoute sur le port #{my_conf['global']['port']} "

