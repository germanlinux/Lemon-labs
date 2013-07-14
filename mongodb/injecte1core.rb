require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
db = mongo_client.db("coredb2013")
projets = db.collection("projets")
chantiers = db.collection("chantiers")
filecontent = ARGV.pop
content = File.readlines(filecontent)

content.each do |mt|
    puts mt.inspect
#item = JSON.pretty_generate(mt)
#    puts item
     ts =JSON.parse(mt)
     if mt =~ /\"ligne\":\"Projet\"/ then 
     projets.insert(ts) 
     else 
     chantiers.insert(ts) 
     end     
 #   
 end

