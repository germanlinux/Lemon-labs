   # encoding=utf-8 
require 'json'
require './libsource'
fentite = ARGV.pop
content = File.readlines(fentite)
require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
mongo_client.database_info.each { |name| puts name.inspect}
db = mongo_client.db("cariatides")
coll = db.collection("references")
content.each do |mt|
#item = JSON.pretty_generate(mt)
#    puts item
    ts =JSON.parse(mt) 
    coll.insert(ts)
 end


