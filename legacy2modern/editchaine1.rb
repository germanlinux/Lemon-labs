require 'graphviz'
fileJCL = ARGV.shift
f = File.open(fileJCL)
content = File.readlines(f)
titre = ARGV.shift
g = GraphViz::new( "KHQ_JCL" )
g[:rankdir] = "TB"
g[:sep] = "+4"
#g[:splines] = 'ortho'
g[:penwidth] = 20
@sortie ="#{titre}.png"
shape ='component'
 style = 'filled'
colors= "LightSlateGray" 
g.add_node(titre,:shape => shape, :color => colors, :style => style).label = titre

shape = 'box'
g.add_node('technique',:shape => shape, :color => 'grey', :style => style).label = 'technique'
g.add_node('metier',:shape => shape, :color => 'orange', :style => style).label = 'métier'


prec = titre
content.each  do |i|
    i.chomp!
    tl =i.split(/\t/)
    if tl[3] == 'technique'
       colors = 'grey'
    else 
       colors  = 'orange'
    end
    label = "#{tl[0]}\n#{tl[2]}"         
    g.add_node(tl[0],:shape => shape, :color => colors, :style => style).label = label
 	g.add_edges(prec,tl[0])
 	prec = tl[0]
end
g.output( :png =>  @sortie )	