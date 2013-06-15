# encoding=utf-8 
require 'json'
require './libsource'
filecontent = ARGV.pop
flag = ARGV.pop
enveloppe = File.read(filecontent)
#puts enveloppe
t_env  =JSON.parse(enveloppe)
rep = t_env['lib']
metadonnee =[]
files = t_env['contents']
pdtotal = pdactive =0
h_unique ={}
programme = grille = 0
cp1 =cp2 =0
files.each do |f|
    nfentite = rep + f 
    nfarc = nfentite + '' 
    nfarc[-3,3] = 'EAR'
   
    contentf = File.readlines(nfentite)
#    contentr = File.read(nfentite)
    lentite =  Entites.new(contentf) 
    my_ent = lentite.array_of_ent 
#    puts my_ent
    flag_une = 0
    my_ent.each do |une|
         cp1 += 1
          
         nom = une[:entite]
#        puts nom
     if flag_une == 0 then 
     @ent_pere = [nom,nfentite]
     flag_une =1
   #  puts @ent_pere.inspect
     end   
     if !h_unique.has_key?(nom) then
     #   puts une.inspect 
      une[:commentaire].gsub!(/\s/,'Y')   
   
   
      une[:commentaire].gsub!(/\W/,'e')   
      une[:commentaire].gsub!(/Y/,' ')
      une.delete(:commentaire) if  une[:commentaire].empty?
      if une[:prop1].class == String then 

        une.delete(:prop1) if une[:prop1].empty?
      end
      
      if une[:prop2].class == String then 
        une.delete(:prop2) if une[:prop2].empty?
      end
      if une[:prop3].class == String then 
        une.delete(:prop3) if une[:prop3].empty?
      end
      if une[:prop4].class == String then 
        une.delete(:prop4) if une[:prop4].empty?
      end
       if !flag then  
        t = JSON.generate(une)
        puts t
       end
        h_unique[nom] = [@ent_pere] 
        cp2 += 1  
     else 
        h_unique[nom] << @ent_pere
     end   
#puts cp1,cp2
    end
end
if flag  then
  h_unique.each_pair do |name, val|   
  t = JSON.generate({:entite => name , :ref => val})
  puts t
end
end