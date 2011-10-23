var http = require('http');
var util = require('util');
var fs   = require('fs');
var querystring = require('querystring');

var store = new Array();


http.createServer(function (request, response) {
  console.log( request.url );
   
  function send_response( data ){
    response.end( JSON.stringify( data ) );
  }
  
  switch( request.url ) {
    case '/setValue' : {
      console.log( 'ICI ????????? oui !!!!!!!!!!!!' );
      
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
      console.log( 'OU LA ........ oui !!!!!!!!!!!!' );
      var bod = '';
       request.on('data', function(chunk) {
         bod += chunk.toString();
       });
       request.on('end', function() {
         function decale() {
           var data = JSON.parse( bod );
           console.log( data );
           response.writeHead(200, {'content-type': 'application/json' } );
           send_response( { result : 'ok', valeur : store[ data.cle ] } );
         }
         setTimeout( decale, 5000 );
       });
    }break;
  }  
}).listen( 8888 );
