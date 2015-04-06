require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
#@connect = MongoClient.new("10.153.91.159",27017) 
@db = @connect.db('khq2')

regnom = /(.+?)\.COB/
recopy  = /\ COPY +(.+?)[\.| ]/  
h_copy = {}
hash_of_pgm={}
file = ARGV.shift
f = File.open(file)
content1 = File.readlines(f)
content1.each do |l|
             next if l.match /DISPLAY/
             next if l.match '\*'
            tmap = l.match recopy
             if tmap  
                h_copy[tmap[1]] = 1
                pgm  = @db['copy'].find(:nom => tmap[1]).to_a
                pg = l.match regnom
                if pgm.size != 1 
                	puts "#{tmap[1]} absent pour #{pg[1]}"
                end
                h_copy[tmap[1]] = 1
                if hash_of_pgm.has_key?  pg[1]
                    hash_of_pgm[pg[1]] <<  tmap[1]
                else 
                   hash_of_pgm[pg[1]]  =  [tmap[1]]
                end        
			end
end
hash_of_pgm.keys.each do |k|
	 t =  hash_of_pgm[k] 
	 t.uniq!
	 @db['programme'].update({:nom => k},{"$set" => {'copy' => t}})
end


h_copy.keys.each do |k| 
 @db['copy'].update({:nom => k},{"$set" => {'actif' => 'oui'}})
end
