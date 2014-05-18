require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
@file = @db['entites'].find({'_type' => 'file'},{:fields => {'file' => 1}} ).to_a
@file.each do |f|
    @array_of_jcl =[] 
    ## recherche jcl 
    @jcl = @db['entites'].find({'files' => f['file'] } ,{:fields => {'jcl' => 1}} ).to_a
    @jcl.each do |j| 
       @array_of_jcl << j['jcl'] 
    end
   if @array_of_jcl.size > 0 then 
      @db['entites'].update({'file' =>  f['file']  }, {"$set" => {'jcl'  => @array_of_jcl}})
    puts @array_of_jcl.inspect
    end       

end
