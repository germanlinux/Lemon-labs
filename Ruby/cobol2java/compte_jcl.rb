require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@files = @db['file'].find({},{:fields => {'jcl' => 1, 'file' => 1 }}).to_a
@files.each do |f|
    puts f.inspect 
     @db['file'].update({'file' => f['file']} , {"$set" => {'nb_jcl'  =>  f['jcl'].size  }})
  end
