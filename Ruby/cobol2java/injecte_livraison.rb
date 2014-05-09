#lire le fichier 
#pour chaque ligne
# rechercher le job 
# mettre à jour job 
#sinon creer job status "nouveau"
# pour chaque job , prendre un pgm
# rechercher dans les pgm
# mettre à jour pgm
#si existe pas creer pgm status "nouveau"
require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
@db = mongo_client.db("vfp")
livraisons = @db.collection("livraison")
filecontent = ARGV.pop
content = File.readlines(filecontent)

content.each do |mt|
puts mt.inspect
#item = JSON.pretty_generate(mt)
#    puts item
    ts =JSON.parse(mt)
    livraisons.insert(ts)
end
