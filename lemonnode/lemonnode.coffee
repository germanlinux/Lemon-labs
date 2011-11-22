http = require('http')
Validator= require('./authorization')
config = require('./config.js')
head   = require('./headers.js')
api_request = require('api_request')
# alias
puts = console.log
# fonctions internes
habilit = (reply,res,auto,origine,loginPortal,codeappli,cookie) ->  
   console.log("dans habilit")
   console.log(reply)
   auto.compute(reply,origine,loginPortal,codeappli,cookie)      
   console.log("en sortant d'habilit")
# version du lemon:nodeJS
version = "0.0"      
if config.getVersion() 
  puts "v#{version}" 
  return null

#load config: chargement de la configuration   
puts "Lancement de lemon:nodeJS"
puts "Debut chargement de la configuration" if config.isDebugOn()
my_conf= config.getConfigSync()
puts "acquisition de " + my_conf['global']['port']  if config.isDebugOn() 
puts "Fin chargement de la configuration"  if config.isDebugOn()
puts "Mise en service"  if config.isDebugOn()
my_cookie =  my_conf['global']['cookie'] 
loginPortal = my_conf['global']['portal']
my_globalPort =  my_conf['global']['port']  
# main loop 
http.createServer(  (request,response) =>
    puts  "request incoming:#{request.url}"
    puts  "headers incoming:" if config.isDebugOn()
    puts request.headers if config.isDebugOn()
    puts request if config.isDebugOn() 
    state = []
    origine = "http://" + request.headers['host']  + request.url 
    origine2 = origine + "_cookie=" + my_cookie
    state['end'] = 0
    puts request.connection.remoteAddress + ": " + request.method +
    " (HTTP method) " + request.url + " (url on) " + request.headers['host']  if config.isDebugOn()
    # recuperation host et port du  header host
    HP = head.getHostPort( request.headers )
    saveHost = request.headers['host']  
    request.addListener('end',  -> state['end'] = 1 )  
    puts "Cible VIP: #{HP['host']} sur port #{HP['port']}"
    ## alignement des headers
    config_location = my_conf[HP['host']]
  #  puts "dispatcher: codeappli => #{codeappli}"
    try 
    	targetPort= config_location['port']
    catch error 
        puts "Erreur la location n'existe pas ou est absente de l entete: #{HP['host']}"
        return null
    codeappli =  config_location['authorization']   
    myvalidator= new Validator   
    targetHost= config_location['hostname']
    target = targetHost + ":" + targetPort
    puts "Cible RIP :#{targetHost} sur port #{targetPort}" 
    if config_location['alias'] 
       target = config_location['alias'] + ':' + targetPort
    my_headers = head.cloneHeaders(request.headers,target)   
    puts  "headers outcoming:" if config.isDebugOn()
    puts my_headers if config.isDebugOn() 
    ## check session 
    my_session = head.getCookie(request.headers,my_cookie)
    if my_session 
           puts "session Ok: #{my_session}" if config.isDebugOn()
           # declaration des listeners
           myvalidator.on('expired',(redirection)->
                   console.log ("reprise de la boucle sur expiration")    
                   headerRedirection = 'location' : redirection 
                   response.writeHead(302,headerRedirection)
                   response.end()
                   return null )
           myvalidator.on('no-auth',(accessdeny)->
                   response.writeHead(403)
                   response.end()
                   return null )
           myvalidator.on('auth',(entete)->
                   add_header = head.addHeaders(my_headers,entete)
                   my_headers = add_header   
                   proxy = http.createClient(targetPort,targetHost)
                   #ajout entete user 
                   proxy_request = proxy.request(request.method, request.url, my_headers)
                   proxy_request.addListener('response',  (proxy_response) =>
                         # ajustement de l'entete host dans le sens retour
                         headers_retour = head.cloneHeaders(proxy_response.headers,saveHost)
                         # ajustement de l entete location en cas de redirection
                         if proxy_response.statusCode in [300..309] 
                                hd = headers_retour['location']   
                                headers_retour['location'] = head.ajustLocation(hd,target,HP['host'],my_globalPort)
                         ## TODO 
                         response.writeHead(proxy_response.statusCode,headers_retour)  
                         proxy_response.addListener('data',  (chunk) => response.write(chunk, 'binary') )
                         proxy_response.addListener('end',   =>  response.end() ) )
                   if state['end'] == 0   
                                request.addListener('end',  ->  proxy_request.end()) 
                   else 
                                proxy_request.end() 
                   )       
               
           # fin declaration des listeners
           # retrouver la session à partie du numero de cookie - retrieve session with cookie number
           r = new api_request('http', 'localhost', 8888)
           r.with_content_type('application/json').
           with_payload( { 'cle' :  my_session}).
             post('/getValue').on('reply',  (reply,res) -> habilit(reply,res,myvalidator,origine,loginPortal,codeappli,my_cookie) ) 
    else 
           puts "echec sur la récuperation de la session"
           origine64=  new Buffer(origine2)
           locationURL= loginPortal+"?url=" + origine64.toString('base64')  
           puts "Location de redirection: #{locationURL}"
           headerRedirection= 'location' : locationURL 
           response.writeHead(302,headerRedirection)
           response.end()
           return null 

).listen(my_conf['global']['port'] )
puts "le serveur lemon:nodeJS V#{version} ecoute sur le port #{my_conf['global']['port']} "

