require 'graphviz'
require 'mongo'
include Mongo
limite_b = ARGV.shift
limite_h = ARGV.shift
mon_png  = ARGV.shift

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye2')
@appli = @db['entites'].find({:_type => 'application'},{:fields => {'sid' => 1, 'nom' => 1}}).to_a
#@fic =@db['entites'].find({:_type => 'file'},{:fields => {'file' => 1, 'nb_jcl' => 1}}).to_a
hf ={}
#hf  =  Hash[@fic.map {|r| [r['file'],r['nb_jcl']] }] 
#puts hf.inspect
 
# initialize new Graphviz graph 
g = GraphViz::new( "PAYE2", "type" => :digraph , "use" => "twopi" ) 
g[:rankdir] = "LR"
g[:overlap] = true
g[:ranksep] = 5
g[:sep] = '+4'

@appli.each do |link|
  g.add_node(link['nom'], :color => "grey", :style => "filled").label = link['nom'] 
   # recherche_jcl 
      @fetch =  @db['entites'].find({:_type => 'fetch',:appli => link['nom']},{:fields => {'nom' => 1}}).to_a 
  @fetch.each do |f|
       no = f['nom']
   if !hf.has_key?(no) then  
       g.add_node(no,:shape => "box" , :color => "orange").label = no
       hf[no] = 1     
   end
    g.add_edges(link['nom'],no)
  end
end
     
g.output( :png =>  mon_png )    
