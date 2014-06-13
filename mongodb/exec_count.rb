require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'

require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 

@db = @connect.db('paye2')
t_fetch =  @db['entites'].find({ '_type' => 'fetch' },{:fields => {'nom' => 1, 'sid' => 1}}).to_a

t_fetch.each do |i|
     t_exec =  @db['entites'].find({ '_type' => 'exec' , 'fetch_id' => i['sid']  },{:fields => {'sid' => 1}}).to_a
 @db['entites'].update({'sid' =>  i['sid'],'_type' => 'fetch'  }, {"$set" => {'nb_exec'  =>  t_exec.size}})
puts t_exec.size
 end



