$(function() { 

 $('#o1').removeClass('onglet_inactif').addClass('onglet_actif').css('cursor','pointer');
 $('#o2').css('cursor','pointer');  
 $('#o3').css('cursor','pointer'); 
 $('.lapage').hide();
 $('#page1').show();
  $('#o1').mouseover(function(e){
                
              //  console.log(e);
                $('#o2').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('onglet_actif');
               // $('#lapage').text("texte de la l'onglet 1")    ; 
                $('#o3').removeClass().addClass('coin_inactif');
                   $('#page2').hide();;
                    $('#page3').hide();;   
                   $('#page1').slideDown('slow');
                                    
                           }
                
                   );

  $('#o2').mouseover(function(){
                $('#o1').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('onglet_actif');
             //   $('#lapage').text("texte de la l'onglet 2")   ;  
                
                $('#o3').removeClass().addClass('coin_inactif');
                   $('#page1').hide();
                    $('#page3').hide();   
                   $('#page2').slideDown('slow');
                                               }
                
                   );
  $('#o3').mouseover(function(){
                $('#o1').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('coin_actif');
                $('#o2').removeClass().addClass('onglet_inactif');
               //  $('#lapage').text("texte de la l'onglet 3") ;    
                    $('#page1').hide();
                    $('#page2').hide();   
                   $('#page3').slideDown('slow');
                   
                                               }
                   );
  
 });
