var fs = require('fs');
var yaml = require('yaml');
var cpdir =0;
var cpfile=0;
var table_of_entrees=[];
var BASE='';
function monEntree(y,s,t) {
 this.type = y;
 this.size = s ;
 this.mtime = t ;
 this.toYAML = function() {
  return "    type: " + this.type +"\n    size: " + this.size +"\n    mdate: " + this.mtime+"\n"; 
 }; 
}
function explore(rep) {
  parcourir(rep,'/');
}
function parcourir(rep,rel) {
     //   nom = rep + rel;   
         
        if (rel != '/') { rel +=  '/';}
        var   nom = rep + rel;
//console.log( 'TOTO>>' + nom );   
	var files = fs.readdirSync(nom) ;
	var stats;
	for (var e in files) {
                 var nom_element  = rel +  files[ e ];
                 var nom_complet  = rep + nom_element;
                 var ma_cle = nom_element.substring(1,nom_element.length);   
                 console.log(nom_complet + " ===> " + nom_element + "===>" + ma_cle); 
             //   var nom_relatif = files[ e ];
		try {  
			stats = fs.statSync( nom_complet);
		} 
 		catch(err) {
   			console.log ('erreur lecture --->' + nom_element + '--->' + err);
  			continue;   
		}
                var t_s		= stats.size;
		//console.log("eric"+ t_s) ;                  
                var t_mtime 	= stats.mtime;
                // var t_obj 	= new monEntree(t_s,t_mtime); 
                // console.log(t_obj);
                var type='';  
                 
                if (stats.isDirectory() ) { type="Directory" ;} else {type="File"; }
                table_of_entrees[ma_cle]= new monEntree(type,t_s,t_mtime);
       		if (stats.isDirectory() ) {
                        cpdir++;  
 //			console.log('trouve -->' +  nom_element + '--> Repertoire');
                        parcourir(rep,nom_element);
                  
        	} else {
                        cpfile++;   
 //           		console.log('trouve -->' +  nom_element + '--> Fichier');
        	} 
	}
} 
myrep = process .argv[2];
BASE= myrep;
explore(myrep);
//console.log('Repertoires:' + cpdir);
//console.log('Fichiers:' + cpfile);
/*for (t in table_of_entrees) {
    console.log (t + ':' + table_of_entrees[t].size);
}
*/
console.log("---");
console.log("content:")
console.log("directory_save: " + BASE)
/*
for (t in table_of_entrees) {
        console.log("  " + t); 

	console.log(table_of_entrees[t].toYAML());
}
*/ 
var ma_date= new Date();
console.log("cpdirectory: " + cpdir);
console.log("cpfile: " + cpfile);
console.log("date: " + ma_date);

//### ecriture du fichier ####
var nt= "tomtom4node.yaml";
buffer ="";
buffer += "cpdirectory: " + cpdir + "\n";
buffer += "cpfile: " + cpfile + "\n" ;
buffer += "date: " + ma_date + "\n";
for (var t in table_of_entrees ) {
    buffer += t+":\n"; 
    buffer += table_of_entrees[t].toYAML() ;
}
   
 fs.writeFile( nt, buffer, 'utf8', function (err) {
 if(err) {
        console.log(err);
    } else {
        console.log("The file was saved!");
    }
 });

