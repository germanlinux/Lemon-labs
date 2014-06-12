require 'rubygems'
require 'json'
$LOAD_PATH << 'lib/'
require 'driverSQLITE'
require 'mongo'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye2')
Tapplication.all.each do |t| 
    my_h = {:sid => t.id, 
            :nom => t.nom,
            :ordre => t.ordre,
            :fonction => t.fonction,
            :information => t.information,
            :_type       => 'application'
    }
    puts my_h
    res = @db['entites'].insert(my_h)
end

