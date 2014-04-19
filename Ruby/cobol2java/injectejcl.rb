require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
db = mongo_client.db("vfp")
jcl = db.collection("jcl")
pgm = db.collection("pgm")

filecontent = ARGV.pop
content = File.readlines(filecontent)

content.each do |mt|
   # puts mt.inspect
     mt.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
     mt.encode!('UTF-8', 'UTF-16', :invalid => :replace)
# mt.gsub!("\'","Z")
     ts =JSON.parse(mt)
     pg = ts['pgm']
     puts pg.inspect 
     pg.each  do |p|
      h ={} 
      h[:nom] = p 
      pgm.insert(h)
     end
     puts ts
    jcl.insert(ts) 
 end

