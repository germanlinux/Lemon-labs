require 'json'
require 'mongo'
require 'date'
#require 'CSV'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
@opc  = @db['OPC'].find({:type => 'APPLICATION'}).to_a
    hash_jcl={}
    hash_par_nom={}

@opc.each do |une_appli|
 @tab = une_appli['enchainement']
 @tab.each do |unjcl|
    if hash_jcl.has_key?(unjcl) 
          hash_jcl[unjcl]+=1
          hash_par_nom[unjcl]<<une_appli['programme']
    else
          hash_jcl[unjcl]= 1
          hash_par_nom[unjcl]=[]
          hash_par_nom[unjcl]<<une_appli['programme']      
    end
 end
end
 hash_par_nom.keys.each  do |x|
    hash_par_nom[x].uniq!
end
 hash_par_nom.keys.each  do |x|
      puts "#{x} - #{hash_par_nom[x].size}  #{hash_par_nom[x]}"
@db['JCL'].update({'programme' =>  x  }, {"$set" => {'applications' => hash_par_nom[x]}})    
end