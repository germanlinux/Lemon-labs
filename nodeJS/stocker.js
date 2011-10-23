var http = require('http');
var util = require('util');
var fs   = require('fs');
var querystring = require('querystring');

var store = new Array();


http.createServer(function (request, response) {
  console.log( request.url );
  
  var tuget = request.url.split('?');
  if( tuget[1] ){
    var tcle = tuget[1].split('=');
    if( store[ tcle[ 1 ] ] ) {
      RES = JSON.stringify( { result : 'ok', valeur : store[ tcle[ 1 ] ] } );
    } else {
      RES = JSON.stringify( { result : 'notok', forcle : tcle[ 1 ] } );
    }
    response.writeHead(200, {'content-type': 'application/json' } );
    response.end( RES );
    ////////////////////// FIN DU GET
    return;
  }
  
  // si on arrive ici c un POST
  
  switch( request.url ) {
    case '/setValue' : {
      var bod = '';
      request.on('data', function(chunk) {
        bod += chunk.toString();
      });
      request.on('end', function() {
        var data = JSON.parse( bod );
        console.log( data );
        store[ data['cle'] ] = data['valeur'];
        response.writeHead(200, {'content-type': 'application/json' } );
        response.end( JSON.stringify( { result : 'ok', valeur : store[ data['cle'] ] } ) );
      });
    } break;
    
    case '/getValue' : {
      var bod = '';
       request.on('data', function(chunk) {
         bod += chunk.toString();
       });
       request.on('end', function() {
         var data = JSON.parse( bod );
         console.log( data );
         var RES = '';
         if( store[ data['cle'] ] ) {
           RES = JSON.stringify( { result : 'ok', valeur : store[ data['cle'] ] } );
         } else {
           RES = JSON.stringify( { result : 'notok', forcle : data['cle'] } );
         }
         response.writeHead(200, {'content-type': 'application/json' } );
         response.end( RES );
       });
    }break;
  }  
}).listen( 8888 );
