require 'mongo'
require 'json'
include Mongo
mongo_client = MongoClient.new("localhost",27017)
db = mongo_client.db("coredb2013")
## charge les liaisons
@index = {}
@projets  = db.collection("projets")
@liaisons = db.collection("liaisons")
@liaisons.find.each { |paire|
   id_projet = paire['projet']
   @index[id_projet] =  paire['structure']
}
puts @index.inspect

## recherche projet sans esi 
@projets.find({:esi => nil}).each { |p| 
    id =p['_id']
    prj = p['projet']
     esi = @index[prj] 
       puts prj, esi, id
  @projets.update({:_id => id}, {:$set => {:esi => esi}})     
  }
## maj des projets

#shell mongo  db.stations.distinct('arrondissement')

