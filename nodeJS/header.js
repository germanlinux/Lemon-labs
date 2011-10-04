var sys  = require("sys");

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
  var cook = String( header.cookie ).split('=');
  if( cook[0] === name ){
    return cook[ 1 ];
  } else {
    return false;
  }
};

exports.cloneHeaders = function ( header, myhost ){
  var tmp     = header;  
  var T = String( myhost ).split( ':' );
  if (T[1] == 80) { 
  tmp['host'] = T[0];
   }  else { tmp['host'] = myhost; }
  return tmp;      
};





//// C FINI
/////////////////////////////////////////////////////////////////////////////////////////////
