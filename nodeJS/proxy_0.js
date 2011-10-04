var http = require('http');
var sys  = require('sys');

function proxy_lem( port ){
  
  http.createServer(function(request, response) {
    
    sys.log(request.connection.remoteAddress + ": " + request.method + " " + request.url);
    
    var proxy         = http.createClient(80, request.headers['host']);
    var proxy_request = proxy.request(request.method, request.url, request.headers);
    
    //------------------------------------------------------------------------- 11111111
    proxy_request.addListener( 'response', function (proxy_response) {
      
      //-------- 11
      proxy_response.addListener('data', function(chunk) {
        response.write(chunk, 'binary');
      });
      //-------- fin 11
      
      //-------- 11 11
      proxy_response.addListener('end', function() {
        response.end();
      });
      //-------- fin 11 11
      
      response.writeHead(proxy_response.statusCode, proxy_response.headers);
    });
    //------------------------------------------------------------------------- fin 1111111
    
    //------------------------------------------------------------------------- 222222222
    request.addListener('data', function(chunk) {
      proxy_request.write(chunk, 'binary');
    });
    //------------------------------------------------------------------------- fin 222222222
    
    //------------------------------------------------------------------------- 333333333
    request.addListener('end', function() {
      proxy_request.end();
    });
    //------------------------------------------------------------------------- fin 333333333
    
  }).listen( port );
}  

function config_lem( conf ){
  console.log( conf );
  console.log( 'port = ' + conf.port );
  proxy_lem( conf['port'] );
}

var conf = require('./config.js').getConfigSync();
console.log( conf );
console.log( "port = " + conf['base']['port'] );
proxy_lem( conf['base']['port'] );

// require('./config.js').getConfig( config_lem );

