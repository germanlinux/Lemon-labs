var signal=require('./signal_nomme.js');
var toto = new signal();
toto.on('lemoment',function(msg){
         console.log(msg);} );
toto.on('flash', function ( msg ) { console.log( msg ); } );

toto.temporisateur();

var leve = 'leve toi';
var tim  = 3000;

var top  = new signal();

top.tempopo(tim, leve);
top.once( leve, function ( msg ) { 
                console.log( msg );
                toto.removeAllListeners( 'flash' );
                toto.removeAllListeners( 'lemoment' );
              }
      );
