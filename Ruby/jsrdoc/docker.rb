require 'rubygems'
$: << "lib/"
$: <<"."
require 'sourcehtml'
require 'metadata'
require 'graphviz'

#s1=  SourceHTML.new(ARGV[0])
#s1.recherchemotifjs
#s1.formatelignejs
fmd= MetaData.new(ARGV[1])
#fmd.write(s1.file, s1.javascript)
### ecriture pour graphviz 
## configuration generale
##
my_graph= fmd.metadata['Graphviz']
g = GraphViz.new(ARGV[1], "type" => "graph") 
g[:rankdir]    = my_graph['orientation']
g[:label]=  "#{ARGV[1].capitalize} project"
g[:labelloc]='t'
g.node[:shape] = my_graph['forme']
g.edge[:dir] = my_graph['direction']
##
## pour chaque node
##
hash_of_nodes =Hash.new
tab_of_keys = fmd.metadata.keys
tab_of_keys.each do |a_key|
 next if a_key == 'Graphviz'
 next if a_key == 'FreeMind'

 my_appli=a_key
 my_appli_info = fmd.metadata[my_appli]
 deb=g.add_node(my_appli, :style => 'filled', :color => 'chartreuse')
 my_node= Array.new
 hash_of_colorarrow= Hash.new

## create nodes
 my_appli_info.each do |line|
   type= line[1]
    color= my_graph['colors'][type]
    if line[2] then hash_of_colorarrow[line[0]]= line[2]  end
   if hash_of_nodes[line[0]] then ## il existe déjà
       tmp = hash_of_nodes[line[0]]
     else                         ## a creer et à ajouter
       tmp = g.add_node(line[0], :style => 'filled', :color => color)
       hash_of_nodes[line[0]]=tmp
     end
   my_node << tmp 
 end
 

## add arrow 
  my_node.each do |node|
     if hash_of_colorarrow[node.id] then 
       
      g.add_edge(deb,node, "style" => my_graph[hash_of_colorarrow[node.id]]['style'],"color"  => my_graph[hash_of_colorarrow[node.id]]['color']) 
    else
    g.add_edge(deb,node)
    end
 end   
end
g.output(:png  => "#{ARGV[1]}.png")


 
#puts my_node.size

puts "eric"
