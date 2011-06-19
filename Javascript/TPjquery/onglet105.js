$(function() { 
 $('#o1').removeClass('onglet_inactif').addClass('onglet_actif').css('cursor','pointer');  
 $('#o2').css('cursor','pointer');  
 $('#o3').css('cursor','pointer'); 
 $('#lapage').text("texte de la l'onglet 1");
  $('#o1').mouseover(function(e){
                
              //  console.log(e);
                $('#o2').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('onglet_actif');
                $('#lapage').text("texte de la l'onglet 1")    ; 
                $('#o3').removeClass().addClass('coin_inactif');
                   
                                               }
                
                   );

  $('#o2').mouseover(function(){
                $('#o1').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('onglet_actif');
                $('#lapage').text("texte de la l'onglet 2")   ;  
                
                $('#o3').removeClass().addClass('coin_inactif');
                                               }
                
                   );
  $('#o3').mouseover(function(){
                $('#o1').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('coin_actif');
                $('#o2').removeClass().addClass('onglet_inactif');
                 $('#lapage').text("texte de la l'onglet 3") ;    
                
                                               }
                
                   );
  

 });
