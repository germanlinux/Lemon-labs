require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
@jcl = @db['entites'].find({'files' => {'$exists' => true}},{:fields => {'jcl' => 1, 'files' => 1}} ).to_a
hash_of_file = {}
@jcl.each do |j|
   
    ## recherche jcl 
    j['files'].each do |f| 
      hash_of_file[f]  = 1 
    end
  end
hash_of_file.keys.each do |k| 
    @db['entites'].insert({'_type' => 'file' , 'file' => k})
 end
    

