# ce programme parse les jcl et extrait les liaisons pgm/jcl/fichier
require 'mongo'
require 'json'
include Mongo
jcl = ARGV.shift
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
@pgm = @db['entites'].find({'_type' => 'JCL', 'source' => {'$exists' => true}},{:fields => {'jcl' => 1 , 'source' => 1, '_id' => 0}} ).to_a
@pgm.each do |pg|
    source = pg['source']
    @res ={}
    r_file = /DD DSN=(.+?),(.+)/
    r_debut_pgm  = /PGM=(PA.+)/ 
    r_fin_pgm  = /PGM=/ 
    fl=0 
    source.each_with_index do |l,cp|
     l.chomp!
   
     #recherche debut de programme
     tpgm = l.match r_debut_pgm 
     if tpgm then
       fl = 1   
       @nom=tpgm[1]
       @resf =[]
       next
      end
      if fl == 1 then 
        ###teste fjchier
        tfile  = l.match r_file 
        if tfile then
         @resf << tfile[1]
        end 
        ###teste fin jcl
        tfile  = l.match r_fin_pgm 
        if tfile then
         ### ecrire fichier en sortie 
            @res[@nom] = @resf
            
            t = {:pgm => @nom , :jcl => pg['jcl'] , :files => @resf}
            puts t.to_json
            @resf = {}
            @nom = nil
            fl = 0 
        end    
     end
   end
end
