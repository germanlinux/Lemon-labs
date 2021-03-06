require 'graphviz'
require 'mongo'
include Mongo
limite_b = ARGV.shift
limite_h = ARGV.shift

mon_png = "graph_" + limite_b +"_" + limite_h+ ".png" 
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@liaisons = @db['jcl'].find({},{:fields => {'jcl' => 1, 'files' => 1, 'etat' => 1}}).to_a
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
if link['files'] and link['files'].size > limite_b.to_i then
  if link['etat'] =~ /RECETTE/ then 
    color = "green" 
    else
    color = "red"
  end       
  g.add_node(link['jcl'],:color => color, :style => "filled").label = link['jcl'] 
  @files = link['files']
  @files.each do |f| 
    next if hf[f] > limite_h.to_i 
    g.add_node(f,:shape => "box" , :color => "orange").label = f
    g.add_edges(link['jcl'],f)
  end
end
     
end
g.output( :png =>  mon_png )    
