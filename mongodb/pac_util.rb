require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'

require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 

@db = @connect.db('paye2')
t_exec =  @db['entites'].find({ '_type' => 'exec' },{:fields => {'step' => 1, 'sid' => 1,'pgm' => 1}}).to_a

t_exec.each do |i|
    puts i['step'] 
   if i['step'] == i['pgm']  then 
    @db['entites'].update({'sid' =>  i['sid'],'_type' => 'exec'  },
      {"$set" => {'type'  => 'prog'}})
   else 
     @db['entites'].update({'sid' =>  i['sid'],'_type' => 'exec'  },
      {"$set" => {'type'  => 'util'}})
   end

 end



