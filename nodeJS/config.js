var sys  = require("sys");
var path = require("path");
var fs   = require("fs");
var util = require('util');

var namef = './conf/lemonode.cfg';
var _debug = false
var typeConf = '';

var flagLOADED = false;
var dataFILE   = null;

// fonction auto-exec --> determination du type de config / fichier / URL /...
( function () {
  for (i= 0 , l= process.argv.length ; i < l ; i++) { 
        if (process.argv[i].indexOf('-f') > -1) { 
              namef = process.argv[i+1];
	      console.log("Utilisation du fichier de configuration:  " +namef);	   
           //   continue;
           }
        if (process.argv[i].indexOf('-d') > -1) { 
              _debug = true;
	      console.log("mode debug ON  ");	   
           //   continue;

           }

  }
  if( path.existsSync( namef ) ){
    typeConf = 'file';
  } else {
    // autre type de config       
    typeConf = 'URL';
  }
} )();


/**
 *  ASYNCHRONE
 * lit la config et la retourne dans un appel à callback
 */
exports.getConfig = function ( callback ){
  fs.readFile( namef, 'utf8', function (err, data) {
    if (err) {
      throw err;
    }  
    var conf = JSON.parse( data );
    callback( conf );
  });
};

// avec fichier
//-----------------
function confFile(){
  var data   = fs.readFileSync( namef, 'utf8' );
  flagLOADED = true;
  dataFILE   = JSON.parse( data );
  if (_debug) {
  console.log("Chargement et traduction du fichier de configuration :" + namef + " =>ok ") ;
   }
  return  dataFILE;
}

// avec URL
//-----------------------
function confURL(){
  var data = '{ "global" : { "port" : 8080 } }';
  dataFILE = JSON.parse( data );
  return  dataFILE;
}

/**
 * config SYNCHRONE
 */
exports.getConfigSync = function (){
  switch( typeConf ){
  case 'file' : {
    return confFile(); 
  } 
  case 'URL': {
    return confURL();
  }
  }
};

/**
 * retourne l'URL cible
 */
exports.getCible = function ( location ){
  if( !flagLOADED ){
    return false;
  }  
  var res = dataFILE[ location ]['hostname'];
  if( dataFILE[ location ]['port'] ){
    if( dataFILE[ location ]['port'] != 80 ){
      res += ':' + dataFILE[ location ]['port'];
    }
  }
  return res;
};
exports.isDebugOn = function (){
  return _debug;
};

//// C FINI
/////////////////////////////////////////////////////////////////////////////////////////////
