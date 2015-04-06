require 'graphviz'
fileJCL = ARGV.shift
f = File.open(fileJCL)
regnom = /([^\/]+?)\.\w{3}/
tnomjcl  = fileJCL.match regnom
nom = tnomjcl[1]

content = File.readlines(f)
g = GraphViz::new( "KHQ_JCL" )
g[:rankdir] = "TB"
g[:sep] = "+4"
#g[:splines] = 'ortho'
g[:penwidth] = 20
@sortie ="#{nom}.png"
content.each_with_index  do |item,i|
	item.chomp!
	puts i
	tabitem = item.split('!')
	if tabitem[0] == 'node' 
		 	  nom =  tabitem[2]
		      style = 'filled'
    	if tabitem[3] == 'r' 
         shape ='component'
	  	 colors= "LightSlateGray" 
    	elsif  tabitem[3] == 't'     	 
		 colors = "grey" 
		 shape ='tab'
    	elsif 		tabitem[3] == 'p'     	 
		 colors = "burlywood" 
		 shape ='box'
    	end		          
		 g.add_node(nom,:shape => shape, :color => colors, :style => style).label = tabitem[1]
		 puts nom
	end
	if tabitem[0] == 'lien'    
     g.add_edges(tabitem[1],tabitem[2])
	end
end
g.output( :png =>  @sortie )		 
