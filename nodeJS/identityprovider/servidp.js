var http = require('http');
var util = require('util');
var fs   = require('fs');
var uuid = require('node-uuid');
var querystring = require('querystring');
var api_request = require('./api_request');

var len_base = 0;

var lecookin = '';

http.createServer(function (request, response) {

  // senders respons
  //-----------------------------------------
  function send_response( data ){
    response.end( JSON.stringify( data ) );
  }
  
  //////////////////////////////////////////////////////////////
  // SERVER
  if (request.headers['x-requested-with'] == 'XMLHttpRequest') { // AJAX ?????
     console.log( request.url );
     if( request.url == "/gimcookin" ){
       send_response( { result : 'ok', cookname : lecookin } );
       return;
     } 
     
     if( request.url == "/verify" ){
       var body = '';
       request.on('data', function(chunk) {
         body += chunk.toString();
       });
       request.on('end', function() {
         var deco = querystring.parse(body);
         console.log( deco );
         if( deco.user == 'demo' && deco.pass == 'demo' ){
           var suid = uuid();
           // creation profil user
           // envoi au stockage avec la cle uid
           // si stock OK
 
           
           var r = new api_request('http', 'localhost', 8888);
           
           r.with_content_type('application/json').
             with_payload( { 'cle' :  suid, 'valeur' : { 'user' : 'jean.valjean', 'habilit' : ['opera', 'monintranet'] } } ).
             post('/setValue').on('reply', function(reply, res) {
               console.log( reply );
               send_response( { result : 'ok', habilit : 'ok', luid : suid  } );
           });
           
           
           return;
         }   
         if( deco.user == 'nopass' && deco.pass == 'nopass' ){
                var suid = uuid();
           // creation profil user
           // envoi au stockage avec la cle uid
           // si stock OK
           var r = new api_request('http', 'localhost', 8888);
           
           r.with_content_type('application/json').
             with_payload( { 'cle' :  suid, 'valeur' : { 'user' : 'inspecteur.javert', 'habilit' : ['opera'] } } ).
             post('/setValue').on('reply', function(reply, res) {
               console.log( reply );
               send_response( { result : 'ok', habilit : 'ok', luid : suid  } );
           });
           
           
           return;
         }
         
         send_response( { result : 'bad', habilit : 'bad' } );
         
       });
     }
  } else { //------------------------------------------------------ HTTP
    console.log('URL-->' + request.url);
    var TReq = request.url.split( '?' );
    if( TReq.length > 1 ){
      var url = TReq[ 1 ].split( '=' );
      url = url[ 1 ];
      var buf = new Buffer( url, 'base64' );
      url     = buf.toString('utf8');
      url     = url.split( '_cookie=' );
      lecookin = url[1];
      console.log( 'URL DECO -->' + url[0] );
      response.writeHead(200, {'content-type': 'text/html' } );
      
      var readS1 = fs.createReadStream( './ident1.html' );
      
      readS1.on('data', function(data) {
        response.write( data );
      });
      readS1.on('end', function() {
         response.write( url[0] );
         var readS2 = fs.createReadStream( './ident2.html' );
         readS2.on('data', function(data) {
           response.write( data );
         });
         readS2.on('end', function(data) {
           response.end();
         });   
       });
      return;
    } else {
      util.pump(fs.createReadStream( '.' + request.url), response);
    }  
  }
}).listen( 3333 );
