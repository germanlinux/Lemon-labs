## ce programme ajoute le source cobol desprogrammes aux entrees mongodb
require 'mongo'
require 'json'
include Mongo
file = ARGV.shift
content= File.readlines(file)

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
libelle = "A PORTER"
content.each do |p|
    p.chomp!
@jcl =  @db['jcl'].find('jcl' => p).to_a
    res = @db['jcl'].update({'_id' => @jcl[0]['_id'] }, {"$set" => {'etat' => libelle}})
end

