require 'mongo'
require 'json'
include Mongo
@mongo_client = MongoClient.new("localhost",27017)
@db = @mongo_client.db("coredb2013")
@coll = @db['projets']
arr = @coll.group( :initial => {cmax:0} ,:reduce =>  "function(obj,prev) { if(prev.cmax < obj.semaine) prev.cmax = obj.semaine; }" )
puts arr.inspect

