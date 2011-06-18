//javascript //
$(function() {
      var suite= new Array;
      var cumul=0;
      var nb=0; 
      $('#nombre_element').text(nb);    
      $('#cumul_element').text(cumul);
      $('#add_element').click(function() {
              var input = $('#new-element').val();
              cumul+= Number(input);
              nb+=1;
              $('#nombre_element').text(nb);    
              $('#cumul_element').text(cumul);
              $('#suite').append("<span id=c"+ nb+ "> " +  input +" </span>");
              suite[nb-1]= input;  
          });     
      $('#supp_element').click(function() {
              var tmp= suite[suite.length-1];
              cumul -= tmp;
               var tmpspan="#c"+ nb;   
              nb-=1;
              $('#nombre_element').text(nb);    
              $('#cumul_element').text(cumul);
              $(tmpspan).remove();
              suite =suite.slice(0,nb) ;
          });     
 

});
