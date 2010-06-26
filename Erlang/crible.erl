-module (crible).  
-export ([main/0,main2/0]). 
 loop2(Pid,Pid_out) ->
        receive 
          ok -> loop2(Pid,Pid_out);
         {nombre,Number} ->    ok,
                               % io:format(" ~w~n",[Number]),
                                Pid_out ! Number,
                                Pid ! next,
                                loop2(Pid,Pid_out); 
         {prime,Prime}  ->  io:format(" ~w",[Prime]),
                            loop2(Pid,Pid_out)
       after 5000 -> ok 
        end.
 loop() ->
        receive 
        ok  ->  ok;    
        Number -> io:format(" ~w~n",[Number]),
                  loop() 
         
      
      end.

 main()-> 
    _Pid =spawn(prime,generator_async,[self(),0,60000]),
     loop(),
    ok.
 main2()->
       Pid =spawn(prime,generator_sync,[self(),3,1000001]),
       Pid_first_link =  spawn(prime,un_filtre,[3,self(),{last,0}]),
       Pid ! next ,
        loop2(Pid,Pid_first_link).

