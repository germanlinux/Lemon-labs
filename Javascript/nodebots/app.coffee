mqtt = require 'mqtt'
mosca_host = 'localhost'
mosca_port = '1883'
client_settings = 
  keepalive: 1000
  protocolId: 'MQIsdp'
  protocolVersion: 3
  clientId: 'client-2'

express = require  'express'
routes  = require './routes'
http    = require 'http'
app = express()
client = mqtt.createClient(mosca_port, mosca_host, client_settings);
myMiddleware = (req, res, next) ->
   if (req.method == 'GET')  
      console.log "hi , I am here"
   ## keep executing the router middleware
   next()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser(uploadDir : "./")
  app.use express.methodOverride()
  app.use app.router
  app.use myMiddleware
  app.use express.static(__dirname + '/public')

app.get '/', routes.index
app.get  '/y/:nb' , (req,res) -> 
   nb = req.params.nb
   console.log nb
   client.publish 'laser/cat',"axey:#{nb}"  
   res.send 'ok'    
app.get  '/x/:nb' , (req,res) -> 
   nb = req.params.nb
   console.log nb
   client.publish 'laser/cat',"axex:#{nb}"  
   res.send 'ok'    
app.get  '/laser/:nb' , (req,res) -> 
   nb = req.params.nb
   console.log nb
   client.publish 'laser/cat',"laser:#{nb}"  
   res.send 'ok'    

server = http.createServer(app)
server.listen app.get('port'),() ->
	  console.log "Express server listening on port " + app.get('port')

