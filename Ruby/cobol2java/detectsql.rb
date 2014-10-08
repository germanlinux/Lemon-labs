require 'json'
require 'pathname'
require 'mongo'
include Mongo

#@connect = MongoClient.new("localhost",27017) 
@connect = MongoClient.new("10.153.91.159",27017) 
@db = @connect.db('khq')
jcl  = @db['JCL'].find().to_a ;
jcl.each do |j|
    puts j['programme']
    next if !j['source'] 
    @tab = j['source']
    @flagsql = 0
    @tab.each do |line| 
      @flagsql = 1 if line=~/CREATE|SELECT|INSERT/i
    end
    if @flagsql == 1    
     puts "#{j['programme']} SQL Found" 
     @db['JCL'].update({'programme' => j['programme']  }, {"$set" => {'SQL'  =>  'OUI'}})
    end 
 #chargement du jcl 

end
