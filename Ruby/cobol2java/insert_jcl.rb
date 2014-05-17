require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
filecontent = ARGV.shift
content = File.readlines(filecontent)
db = mongo_client.db("paye")
entites = db.collection("entites")
content.each do |mt|
    puts mt.inspect
#item = JSON.pretty_generate(mt)
#    puts item
    ts =JSON.parse(mt)
    entites.insert(ts) 
    puts ts
 end
    