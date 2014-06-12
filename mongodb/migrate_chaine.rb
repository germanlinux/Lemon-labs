require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'
require 'driverSQLITE'
require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 

@db = @connect.db('paye2')
t_appli =  @db['entites'].find({ '_type' => 'application' },{:fields => {'nom' => 1, 'sid' => 1}}).to_a
h_appli={}
t_appli.each do |i|

    h_appli[i['sid']]  = i['nom']
end
Tjob.all.each do |t| 
    
    my_h = {:sid => t.id,
            :appli_id => t.appli_id,        
            :appli    => h_appli[t.appli_id],
            :nom => t.nom,
            :ordre => t.ordre,
            :fonction => t.fonction,
            :information => t.information,
            :_type       => 'jcl'
    }
    puts my_h
    res = @db['entites'].insert(my_h)
end
