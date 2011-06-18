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
              $('#suite').append(" "+ input);
              suite[nb-1]= input;  
          });     
 

});
