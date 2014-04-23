## ce programme ajoute le source cobol desprogrammes aux entrees mongodb
require 'mongo'
require 'json'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@pgm =  @db['pgm'].find()
@pgm.each do |p|
    nomf = p['nom']+ '.txt'
   begin
   content = File.readlines(nomf)
   res = @db['pgm'].update({'_id' => p['_id'] }, {"$set" => {'source' => content}})
   rescue 
     puts "erreur : #{nomf}"
   end  
end
