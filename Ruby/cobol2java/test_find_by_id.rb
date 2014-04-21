require 'mongo'
include Mongo
  @connect = MongoClient.new("localhost",27017) 
  @db = @connect.db('vfp')
 # @jcl =  @db['jcl'].find().sort({:jcl => 1}).to_a;    
 @jcl =  @db['jcl'].find( '_id'  => BSON::ObjectId("5352d84751514034cc000035")).to_a
 puts @jcl[0]
 puts "toto"
