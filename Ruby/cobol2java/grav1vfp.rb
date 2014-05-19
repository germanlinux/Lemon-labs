require 'graphviz'
require 'mongo'
include Mongo
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@liaisons = @db['jcl'].find({},{:fields => {'jcl' => 1, 'files' => 1}}).to_a
# initialize new Graphviz graph 
g = GraphViz::new( "VFP", "type" => "graph" ) 
g[:rankdir] = "LR"

@liaisons.each do |link|
if link['files'] then    
  g.add_node(link['jcl']).label = link['jcl'] 
  @files = link['files']
  @files.each do |f| 
    g.add_node(f,:shape => "box").label = f
    g.add_edges(link['jcl'],f)
  end
end
     
end
g.output( :png =>  "graph1.png" )    