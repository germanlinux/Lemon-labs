require 'rubygems'
$: << "lib/"
$: <<"."
require 'sourcehtml'
require 'builder'
require 'metadata'
#require 'graphviz'
fmd= MetaData.new(ARGV[1])
### ecriture pour freemind 
## configuration generale
##
my_map= fmd.metadata['FreeMind']
my_Xmldoc = Builder::XmlMarkup.new()
my_Xmldoc.map( 'version' =>my_map['version']) {|b|
  b.node('TEXT' => "#{ARGV[1].capitalize} project" ) {
        hash_of_nodes =Hash.new
        tab_of_keys = fmd.metadata.keys
        tab_of_keys.each do |a_key|
           next if a_key == 'Graphviz'
           next if a_key == 'FreeMind'
        
        my_appli=a_key
        my_appli_info = fmd.metadata[my_appli]
        b.node('TEXT' => my_appli) {|c|
        my_node= Array.new
        my_appli_info.each do |line|
          nom = line[0]
          c.node('TEXT' =>line[0])   
          end   
        }
      end  
 }
}
xml=  my_Xmldoc.target!
 File.open("#{ARGV[1]}.mm",'w') do |out| 
         out.write(xml)
end

 
