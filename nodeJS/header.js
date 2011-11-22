//var sys  = require("sys");

exports.getHostPort = function ( header ){
  var T = String( header.host ).split( ':' );
  var r = {};
  r.host = T[0];
  if( T[1] ){
    r.port = T[ 1 ];
  } else {
    r.port = 80;
  }
  return r;
};

exports.getCookie = function ( header, name ){
  if( !header.cookie ){
    return false;
  } 
  console.log(header.cookie); 
  var cook = String( header.cookie ).split(';');
   console.log(cook);
   var cp= 0;
  while (cp < cook.length ) {
    var book = cook[ cp ].split('=');
     console.log(book);
     if (book[ 0 ] === name) {
        return book[ 1 ];
       } 
     cp++ ; 
   } 
   return false;
};

exports.cloneHeaders = function ( header, myhost ){
  var tmp     = header;  
  var T = String( myhost ).split( ':' );
  if (T[1] == 80) { 
  tmp['host'] = T[0];
   }  else { tmp['host'] = myhost; }
  return tmp;      
};

exports.addHeaders = function ( headers, entete ){
  var tmp     = headers;  
  tmp['authorization'] = entete; 
  return tmp;      
};





//// C FINI
/////////////////////////////////////////////////////////////////////////////////////////////
