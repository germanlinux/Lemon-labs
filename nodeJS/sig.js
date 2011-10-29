var signal=require('./signal.js');
var sonde = new signal();
// mise en place des listener et des fonctions de retour 
sonde.on('ici',function(msg){
        console.log(msg)} );

sonde.on('lemoment',function(msg){
        console.log(msg)} );
// lancement des opérations
sonde.temporisateur();
sonde.maint();
