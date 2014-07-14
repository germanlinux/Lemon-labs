require 'graphviz'
require 'mongo'
include Mongo
mon_png  = ARGV.shift
hf = {}
g = GraphViz::new( "PAYE2", "type" => :digraph , "use" => "twopi" ) 
g[:rankdir] = "LR"
g[:overlap] = true
g[:ranksep] = 10
g[:sep] = '+4'

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye2')
@fetch = @db['entites'].group(
  :key => ['nom'], 
  :initial => {appli:[]},
  :reduce => "function(obj,res){ if (res.appli.indexOf(obj['appli']) < 0 ) {  res.appli.push(obj['appli']); }  } " ,
  :cond =>  { :_type  => 'fetch'},
  ).to_a

#puts @fetch.size

@fetch.each do |f|
if f['appli'].size > 1  
   g.add_node(f['nom'], :color => "grey", :style => "filled").label = f['nom'] 
   f['appli'].each do |app|
    if !hf.has_key?(app)   
       g.add_node(app,:shape => "box" , :color => "orange").label = app
       hf[app] = 1     
     end
    g.add_edges(f['nom'],app,:arrowhead =>'none')
   end
end



#tab = f['appli']
#tab.each do |
puts " #{f['nom']};#{f['appli'].size}"
end
g.output( :png =>  mon_png )    
     
