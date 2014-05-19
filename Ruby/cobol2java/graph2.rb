require 'graphviz'
require 'mongo'
include Mongo
limite = ARGV.shift
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@liaisons = @db['jcl'].find({},{:fields => {'jcl' => 1, 'files' => 1}}).to_a
@fic =@db['file'].find({},{:fields => {'file' => 1, 'nb_jcl' => 1}}).to_a
hf ={}
hf  =  Hash[@fic.map {|r| [r['file'],r['nb_jcl']] }] 
puts hf.inspect
 
# initialize new Graphviz graph 
g = GraphViz::new( "VFP", "type" => :digraph , "use" => "twopi" ) 
g[:rankdir] = "LR"
g[:overlap] = true
g[:ranksep] = 2
g[:sep] = '+4'

@liaisons.each do |link|
if link['files'] then    
  g.add_node(link['jcl'],:color => "red", :style => "filled").label = link['jcl'] 
  @files = link['files']
  @files.each do |f| 
    next if hf[f] > limite.to_i 
    g.add_node(f,:shape => "box" , :color => "orange").label = f
    g.add_edges(link['jcl'],f)
  end
end
     
end
g.output( :png =>  "graph1.png" )    