require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@pgm = @db['pgm'].find({'nom' => {'$exists' => true}},{:fields => {'nom' => 1}} ).to_a
@pgm.each do |p|
    @array_of_jcl =[] 
    ## recherche jcl 
    @jcl = @db['jcl'].find({'pgm' => p['nom'] } ,{:fields => {'jcl' => 1}} ).to_a
    @jcl.each do |j| 
       @array_of_jcl << j['jcl'] 
    end
   if @array_of_jcl.size > 0 then 
      @db['pgm'].update({'nom' =>  p['nom']  }, {"$set" => {'jcl'  => @array_of_jcl}})
    puts @array_of_jcl.inspect
    end       

end



