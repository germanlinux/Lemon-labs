## ce programme ajoute le source cobol desprogrammes aux entrees mongodb
require 'mongo'
require 'json'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@pgm =  @db['jcl'].find()
@pgm.each do |p|
   if p['pdf_file'] then 
      libelle = 'A MODERNISER'
     else
      libelle = 'A PORTER' 
    end
    res = @db['jcl'].update({'_id' => p['_id'] }, {"$set" => {'etat' => libelle}})
end
