-module (prime).
-export ([generator_async/3,generator_sync/3,un_filtre/3]).

generator_async(Canal,Compteur,Maximum) when Compteur == Maximum -> Canal ! ok;
generator_async(Canal,Compteur,Maximum) ->
   Cpt= Compteur +1,  
   Canal ! Cpt,
   generator_async(Canal,Cpt,Maximum).

generator_sync(Canal,Compteur,Compteur) -> Canal ! ok;
generator_sync(Canal,Compteur,Maximum) -> 
    Cpt= Compteur +2,
   receive 
   next ->  Canal ! {nombre,Cpt},
   generator_sync(Canal,Compteur+2,Maximum)   
   end.
   

test(Nombre,Filtre)  when (Nombre rem Filtre == 0) -> true;
test(_,_) -> false.
un_filtre(Filtre,Owner,Link)->
    {Etat,Next}= Link, 
      receive 
        Nombre -> Result= test(Nombre,Filtre),
                  case Result  of 
                    true  -> un_filtre(Filtre,Owner,Link);
                    false ->  ok,
                              case Etat == last of
                                false -> Next ! Nombre,
                                un_filtre(Filtre,Owner,Link);
                                true  ->  Owner ! {prime,Nombre}, 
                                Chanel = spawn(prime,un_filtre,[Nombre,Owner,{last,0}]),
                                 un_filtre(Filtre,Owner,{link,Chanel}) 
                               end
                      
                     end 
     after 5000 -> ok 
 end.
