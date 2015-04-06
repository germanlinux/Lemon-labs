require 'graphviz'
fileJCL = ARGV.shift
f = File.open(fileJCL)
content = File.readlines(f)
g = GraphViz::new( "KHQ_JCL" )
g[:rankdir] = "TB"
g[:sep] = "+4"
#g[:splines] = 'ortho'
g[:penwidth] = 20
@sortie =''
content.each_with_index  do |item,i|
	item.chomp!
	puts i
	tabitem = item.split('!')
	next if tabitem[1]=='' 
	if tabitem[0] == 'node' 
		 	  nom =  tabitem[1]
		      style = 'filled'
		 colors = "grey" 
		 shape ='box'
		 if tabitem[4] 
		 	  shape = tabitem[4]
		 end	  
		 if tabitem[5] 
		 	  style = tabitem[5]
		 	  puts "je passe"
		 end	  

		 if  i == 0 
		    shape ='component'
		    colors= "LightSlateGray" 
		    @sortie = tabitem[1].dup

		    @sortie.gsub!(/\./, '_')
		    puts @sortie.inspect
		    puts tabitem[1].inspect
		    puts nom.inspect
		    @sortie+='.png'    
		 end   	 
		 if tabitem[1] =~ /programme:/
		     tabitem[1].gsub!( /programme:/,'' )
		 	 colors = 'lightblue2'
		 	  nom =  tabitem[1]

		 end	 
		 if tabitem[1] =~ /Sort/
		 	  colors = 'burlywood'
		 	  nom =  tabitem[2]
		 	  tabitem[3].gsub!(/£/,'\n') 
		 	  tabitem[1] = tabitem[3]
		 end	 
		 if tabitem[1] =~ /ICEGENER/
		 	  colors = 'orange'
		 	  nom =  tabitem[2]
		 	  tabitem[3].gsub!(/£/,'\n') 
		 	  tabitem[1] = tabitem[3]
		 end	 
		 if tabitem[1] =~ /IEBGENER/
		 	  colors = 'burlywood2'
		 	  nom =  tabitem[2]
		 	  tabitem[3].gsub!(/£/,'\n') 
		 	  tabitem[1] = tabitem[3]
		 end	 
        if tabitem[1] =~ /IDCAM/
		 	  nom =  tabitem[2]
		 	  colors = 'burlywood1'
              tabitem[1].gsub!(/£/,'\n') 
		 end	 

		 if tabitem[1] =~ /fichier:/
		     tabitem[1].gsub!( /fichier:/,'' )
		 	 colors = 'khaki'
		 	  nom =  tabitem[1]
		 end	 
		 if tabitem[1] =~ /fichierdelete:/
		 	 colors = 'gainsboro'
		 	 tabitem[1].gsub!( /fichierdelete:/,'' )
		 	 nom =  tabitem[1]

		 end	
		if tabitem[1] =~ /ORACLE/
		     tabitem[1].gsub!( /fichier:/,'' )
		 	 colors = 'orange'
		 	 nom =  tabitem[1]

		 end
		 
         puts nom
		 g.add_node(nom,:shape => shape, :color => colors, :style => style).label = tabitem[1]
		 puts nom
	end
	if tabitem[0] == 'lien'
		puts tabitem.size
		next if tabitem.size < 2
		if tabitem[3] 
			 penwidth = 5
			 color = 'red'
		else 
		     penwidth = 1
		     color = ''	
		 end     
    
     g.add_edges(tabitem[1],tabitem[2],:penwidth => penwidth, :color=> color)  if tabitem.size >2

	end

end
g.output( :png =>  @sortie )		 
