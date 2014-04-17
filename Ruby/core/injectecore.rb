require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
db = mongo_client.db("coredb2014")
projets = db.collection("projets")
filecontent = ARGV.pop
content = File.readlines(filecontent)

content.each do |mt|
    puts mt.inspect
     ts =JSON.parse(mt)
     projets.insert(ts) 
 end

