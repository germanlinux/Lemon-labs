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
@link = @db['liaisons'].group(
  :key => ['appl1', 'appl2'], 
  :initial => {:count  => 0},
  :reduce => "function(obj,res){ res.count+=1; } " ,
  ).to_a

#puts @fetch.size
#db.liaisons.group({key: {appl1 :1,appl2 :1} , reduce : function(cur,result) {result.count +=1}, initial:{count : 0}} )

@link.each do |l|
   if hf.has_key?(l['appl1']) 
     g.add_node(l['appl1'], :color => "grey", :style => "filled").label = l['appl1'] 
     hf[l['appl1']] = 1
   end
   if hf.has_key?(l['appl2']) 
     g.add_node(l['appl2'], :color => "grey", :style => "filled").label = l['appl2'] 
     hf[l['appl2']] = 1
   end
  next if l['count'] < 3  

    g.add_edges(l['appl1'],l['appl2'],:penwidth=>l['count'],:arrowhead =>'none')

end



#tab = f['appli']
#tab.each do |
#puts " #{f['nom']};#{f['appli'].size}"
g.output( :png =>  mon_png )    
     
