$(function() { 

 $('#o1').removeClass('onglet_inactif').addClass('onglet_actif').css('cursor','pointer');  
 $('#o2').css('cursor','pointer');  
 $('#o3').css('cursor','pointer'); 

  $('#o1').hover(function(e){
                
            //    console.log(e);
                $('#o2').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('onglet_actif');

                $('#o3').removeClass().addClass('coin_inactif');
                   
                                               },
                function(){
                $(this).removeClass().addClass('onglet_inactif')}
                
                   );

  $('#o2').hover(function(){
                $('#o1').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('onglet_actif');
                $('#o3').removeClass().addClass('coin_inactif');
                                               },
                function(){
                $(this).removeClass().addClass('onglet_inactif')}
                
                
                   );
  $('#o3').hover(function(){
                $('#o1').removeClass().addClass('onglet_inactif');
                $(this).removeClass().addClass('coin_actif');
                $('#o2').removeClass().addClass('onglet_inactif');
                                               },
                function(){
                $(this).removeClass().addClass('coin_inactif')}
                
                   );
  

 });
