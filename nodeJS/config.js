var sys  = require("sys");
var path = require("path");
var fs   = require("fs");
var util = require('util');

var namef = './conf/lemonode.cfg';

var typeConf = '';

var flagLOADED = false;
var dataFILE   = null;

// fonction auto-exec --> determination du type de config / fichier / URL /...
( function () {
  if( path.existsSync( namef ) ){
    typeConf = 'file';
  } else {
    // autre type de config       
    typeConf = 'URL';
  }
} )();


/**
 *  ASYNCHRONE
 * lit la config et la retourne dans un appel � callback
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

//// C FINI
/////////////////////////////////////////////////////////////////////////////////////////////
