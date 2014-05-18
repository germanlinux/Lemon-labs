require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
@file = @db['entites'].find({'_type' => 'file'}).to_a
@file.each do |f|
    @hash_of_pgm ={}
    ## recherche pgm dans les liaisons
    @link = @db['liaisons'].find({'files' => f['file']},{:fields => {'pgm' => 1}}).to_a
    @link.each do |l| 
       @hash_of_pgm[l['pgm']] = 1  
    end
   if @hash_of_pgm.keys.size > 0 then 
     @db['entites'].update({'file' =>  f['file']  }, {"$set" => {'pgm'  =>  @hash_of_pgm.keys}})
    puts @hash_of_pgm.keys.sort.inspect
    end       

end



