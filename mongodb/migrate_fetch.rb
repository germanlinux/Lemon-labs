require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'
require 'driverSQLITE'
require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 

@db = @connect.db('paye2')
t_jcl =  @db['entites'].find({ '_type' => 'jcl' },{:fields => {'nom' => 1,'appli' => 1, 'sid' => 1}}).to_a
h_jcl={}
t_jcl.each do |i|
    h_jcl[i['sid']]  = [i['appli'],i['nom']]
end
Tfetch.all.each do |t| 
    
    my_h = {:sid => t.id,
            :jcl_id => t.jcl_id,        
            :appli    => h_jcl[t.jcl_id][0],
            :jcl      => h_jcl[t.jcl_id][1],
            :nom => t.nom,
            :ordre => t.ordre,
            :fonction => t.fonction,
            :information => t.information,
            :_type       => 'fetch'
    }
    puts my_h
    res = @db['entites'].insert(my_h)
end
