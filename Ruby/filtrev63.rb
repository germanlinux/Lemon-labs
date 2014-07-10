#!/usr/bin/ruby
ARGF.each_line do |l|
     if l !~ /INSERT/
       then 
        puts l
        next
     end    
  ## gestion des chengement de la table dossier  
    if l =~ /estouvert/ 
     then 
       l.sub!(/estouvert/,'isdossiercree')
     end  
    if l=~ /depensenormale_dpno /
     then
      table_pour_l = l.split(',')
      table_pour_l[6]  = 'refe_id_leobjetdepense'
      #table_pour_l[27] = 22 
      l = table_pour_l.join(',')
      l.sub!(/'REPRISE'/ ,'22')
#      table_pour_l.each_with_index do |t,i| 
#         puts "#{i} => #{t}"
#       end
    end   
    if l=~ /parcelle_parc /
      then 
       table_pour_l = l.split(',')
       table_pour_l.insert(5, ' issaisielotouverte')
       table_pour_l.insert(13, '\'1\'')
        l = table_pour_l.join(',')
  
    end   
    if l=~ /depconsignormale_dcon /
     then
      table_pour_l = l.split(',')
      table_pour_l[8]  = 'refe_id_leobjetdepense'
      table_pour_l[-5] = 22 
      table_pour_l.insert(4,'dateservicefait') 
      table_pour_l.insert(15,' NULL') 
      table_pour_l[15] = table_pour_l[16]
      
      #table_pour_l[13] = table_pour_l[14]
      l = table_pour_l.join(',')
     end     
  
     puts l
end
