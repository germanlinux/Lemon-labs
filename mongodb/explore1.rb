require 'mongo'
require 'json'
include Mongo
@mongo_client = MongoClient.new("localhost",27017)

@db = @mongo_client.db("coredb2013")
@coll = @db['projets']
mt = reel = 0
@coll.find.each { |projet|# puts projet.inspect
  pr =   projet['libelle']
  mt +=   projet['planifie']['centrale']
  reel += projet['reel']['centrale']
  semaine = projet['semaine']
#   if reel > mt then 
 #     puts "Alerte #{pr}, #{mt} , #{reel}" 
 #  elsif reel * 52/semaine  > mt then 
 #     puts "Surc #{pr}, #{mt} , #{reel}" 
 #

  # end     
 }
puts reel , mt 