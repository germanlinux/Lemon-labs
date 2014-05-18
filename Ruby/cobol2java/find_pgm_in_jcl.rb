require 'mongo'
include Mongo
require 'json'
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
@jcl = @db['entites'].find({},{:fields => {'pgm' => 1, 'jcl' => 1 }} ).to_a
hash_of_pgm = {}
@jcl.each do |j|
    ##  
  next if j['pgm'].size == 0 
  j['pgm'].each do |p| 
    if  hash_of_pgm.key?(p)  then 
      list =  hash_of_pgm[p]   
      list << j['jcl']
      hash_of_pgm[p] = list 
    else
       hash_of_pgm[p] = [j['jcl']]
    end
  
  end
end
hash_of_pgm.keys.each  do |item|
   t ={:pgm => item, :_type => 'pgm' , :jcl => hash_of_pgm[item] }
   ts = t.to_json  
   @db['entites'].insert(t) 
   puts t.inspect
end      

