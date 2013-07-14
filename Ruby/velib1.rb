require 'mongo'
require 'json'
include Mongo
@mongo_client = MongoClient.new("localhost",27017)
@db =  @mongo_client.db('velibdb') 
@stations = @db["stations"]
(75001..75020).each { |arrondissement|
   arr= arrondissement.to_s
   puts arr
   rech = @stations.find({:address => /#{Regexp.quote(arr)}/}).each { |p| 
       id =p['_id']
       @stations.update({:_id => id}, {:$set => {:arrondissement => arrondissement}})     
    }
}

rech = @stations.find({:arrondissement => nil}).each { |p| 
       id =p['_id']
       @stations.update({:_id => id}, {:$set => {:arrondissement => 'banlieue'}})     
    }
#shell mongo  
#db.stations.distinct('arrondissement')#db.stations.find({arrondissement: 75001},{'state.total_slots' : 1})
#db.stations.group ({key : { synthese:1} , reduce: function (curr, res) { res.total += curr.state.total_slots; res.libre += curr.state.available_slots }, initial: { total :0, libre : 0 }},
#db.stations.find({},{address:1}).sort({'state.total_slots' :-1 }).limit(1)
