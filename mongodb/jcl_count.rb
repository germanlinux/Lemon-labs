require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'

require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 

@db = @connect.db('paye2')
t_jcl =  @db['entites'].find({ '_type' => 'jcl' },{:fields => {'nom' => 1, 'sid' => 1}}).to_a
t_jcl.each do |i|
     t_fetch =  @db['entites'].find({ '_type' => 'fetch' , 'jcl_id' => i['sid']  },
        {:fields => {'sid' => 1, 'nb_exec' => 1}}).to_a
# @db['entites'].update({'sid' =>  i['sid'],'_type' => 'jcl'  }, {"$set" => {'nb_fetch'  =>  t_fetch.size}})
  t_count = 0
      t_fetch.each do |j|
           t_count += j['nb_exec']
      end
 puts t_count
 @db['entites'].update({'sid' =>  i['sid'],'_type' => 'jcl'  }, {"$set" => {'nb_fetch'  =>  t_fetch.size, 'nb_exec' => t_count}})

puts t_fetch.size
 end



