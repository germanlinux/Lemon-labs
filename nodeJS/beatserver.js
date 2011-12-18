var http   = require('http');
var util   = require('util');
var fs     = require('fs');
var server = null;

if( process.argv.length != 4 ){
  console.log( 'usage: node server.js port milli_secs' );
  console.log( 'port = port sur lequel Node doit ecouter' );
  console.log( 'milli_secs = delai en milli-secondes entre chaques tentatives, avec la valeur "0" le serveur ne s arrete pas' );
  console.log('Pour stopper le programme à distance: inserer la chaine STOPNODE dans une URL'); 
  process.exit(255);
}

var iport  = Number( process.argv[ 2 ]);
var delay  = Number( process.argv[ 3 ]);
var message = fs.readFileSync('exemple.png');

function try_create( stime ){
  server = http.createServer(function (req, res) {
    if (req.url.indexOf('STOPNODE') > 0)  {  process.exit(0) ;}  
    res.writeHead(200, {'Content-Type':  'image/png' ,'Content-length' : message.length });
    res.end(message);
  }).listen( iport, function() {
    console.log( stime +  ' OPERA\'s dead, Node Server started at http://0.0.0.0:'+ iport + '/');
  });
  
  server.on('error', function() {
    console.log( stime +  ' OPERA\'s RUNNING ..... Node Server NOT STARTED');
    server = null;
  });

  return true;
}

function checkTime(i){
  if (i<10) {
    i ="0" + i;
  }
  return i;
}
var flag = false; 

function startTime() {
  var today = new Date();
  var h = today.getHours();
  var m = today.getMinutes();
  var s = today.getSeconds();

  m = checkTime(m);
  s = checkTime(s);
  var stime = h+":"+m+":"+s;
  if (delay !== 0) {
        setTimeout( startTime, delay );
  }
  if( ! flag ){
    if( try_create( stime ) ){
      flag = true;
    }
  } else {
    flag = false;
    if( server ){
      server.close();
      console.log( stime + ' Server closed !!' );
      server = null;
    }  
  }  
}

startTime();
