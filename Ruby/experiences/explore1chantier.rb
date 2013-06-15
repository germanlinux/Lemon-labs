require 'mongo'
require 'json'
include Mongo
@mongo_client = MongoClient.new("localhost",27017)
@db = @mongo_client.db("coredb2013")
@coll = @db['chantiers']
puts "type,projet,chantier,Valide,totalMOE,centrale,moed"
@coll.find.each { |chantier|# puts projet.inspect
#  puts chantier.inspect
  pr =   chantier['projet']
  ch =  chantier['chantier']
  mt =   chantier['valide']['total moe']

  
  reelt = chantier['reel']['total moe'] 
  reelc = chantier['reel']['centrale']
  reeld = chantier['reel']['moed']
  
    

  semaine = chantier['semaine']
   if reelt > mt then 
      puts "Alerte, #{pr},#{ch}, #{mt} , #{reelt}, #{reelc} , #{reeld}" 
   elsif reelt * 52/semaine  > mt then 
      puts "Sur-consommation, #{pr}, #{ch}, #{mt} ,  #{reelt}, #{reelc} , #{reeld}" 
   end     
 }
