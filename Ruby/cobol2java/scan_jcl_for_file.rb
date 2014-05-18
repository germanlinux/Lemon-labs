require 'mongo'
require 'json'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
@pgm = @db['entites'].find({'source' => {'$exists' => true}, '_type' => 'JCL'},{:fields => {'jcl' => 1 , 'source' => 1, '_id' => 0}} ).to_a
@pgm.each do |pg|
    source = pg['source']
    
    reg_file = /DD DSN=(.+?),(.+)/
    res ={}
    source.each do |l|
     tfile = l.match reg_file
     if tfile then 
     res[tfile[1]] = 1
     end
    end

ret = {:jcl => pg['jcl'] , :files => res.keys}
@db['entites'].update({'jcl' =>  pg['jcl']  }, {"$set" => {'files'  => res.keys}})
end