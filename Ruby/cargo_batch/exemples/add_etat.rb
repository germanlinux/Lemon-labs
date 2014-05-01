## ce programme ajoute le source cobol desprogrammes aux entrees mongodb
require 'mongo'
require 'json'
include Mongo
if ARGV.size != 4 then 
    raise "parametre: famille entite modele conf"
end    
famille = ARGV.shift
entite  = ARGV.shift
etat    =  ARGV.shift
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
libelle = etat
if famille  == 'jcl' then 
    cle = famille
else 
    cle = 'nom' 
end
@ent =  @db[famille].find(cle => entite).to_a

    res = @db[famille].update({'_id' => @ent[0]['_id'] }, {"$set" => {'etat' => libelle}})
end

