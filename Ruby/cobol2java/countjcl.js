var toto =  function() {
 db.JCL.group({
         key: {'type': 1} ,
         cond : { source: { $exists : 1 }},
         reduce : function(cur,result) {result.cumul += cur.source.length},
         initial:{cumul : 0},
         

     } ).forEach(printjson);
 
};

toto();
