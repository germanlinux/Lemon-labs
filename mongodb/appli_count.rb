require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'

require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 

@db = @connect.db('paye2')
t_appli =  @db['entites'].find({ '_type' => 'application' },{:fields => {'nom' => 1, 'sid' => 1}}).to_a

t_appli.each do |i|
     t_jcl =  @db['entites'].find({ '_type' => 'jcl' , 'appli_id' => i['sid']  },
        {:fields => {'sid' => 1, 'nb_exec' => 1, 'nb_fetch' => 1}}).to_a
t_count  = 0
t_count1 = 0
       t_jcl.each do |j|
       t_count += j['nb_exec']
       t_count1 += j['nb_fetch']
      end
 puts t_count 
 puts t_count1 
    
 @db['entites'].update({'sid' =>  i['sid'],'_type' => 'application'  },
  {"$set" => {'nb_jcl'  =>  t_jcl.size,'nb_fetch'  =>  t_count1, 'nb_exec' => t_count }})

 end



