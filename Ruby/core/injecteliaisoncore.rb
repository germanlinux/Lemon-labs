require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
#mongo_client.database_info.each { |name| puts name.inspect}
db = mongo_client.db("coredb2014")
liaisons = db.collection("liaisons")

filecontent = ARGV.pop
content = File.readlines(filecontent)

content.each do |mt|
    puts mt.inspect
#item = JSON.pretty_generate(mt)
#    puts item
     ts =JSON.parse(mt)
     liaisons.insert(ts) 
 #   
 end

