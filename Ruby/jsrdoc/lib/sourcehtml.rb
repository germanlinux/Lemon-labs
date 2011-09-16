#!/usr/bin/ruby
$: <<"./"
require 'rubygems'
class SourceHTML 

attr_accessor :tableauligne, :lignejs, :javascript, :file
# ouvrir le fichier et le charge dans un tableau  
  def initialize(file)
  @file = file
  @tableauligne = Array.new  
 if( File.exist?(file)) then 
    @tableauligne= IO.readlines(file)
   else
     #raise "le fichier  #{file} n existe pas" 
   end
    @tableauligne.size  
end
 def motifjs(lignesource,motif) 
  regexp= Regexp.new(motif)
   res= regexp.match lignesource
 end

# recherche un motif parmis les ligne du tableau 
# et retourne une liste contenant un nb et un array  
  def recherchemotifjs
     @lignejs= Array.new
    motif ='script\s+type=\"text/javascript\"\s+src=\"(.+)\"' 
    # tmpsize= @tableauligne.size
    # cpt=0
    # cpt.up_to(tmpsize) do
     flag='none' 
     @tableauligne.each  do |ligne|     
       if ligne=~ /@js_framework/ then 
            flag='jsfw'
             next
       end
     if ligne=~ /@js_lib/ then 
            flag='jslib'
             next
       end
      
     if ligne=~ /@js_plugin/ then 
            flag='jspg'
            next
       end  
       scan= motifjs(ligne,motif) 
       if scan then 
          @lignejs << [flag,scan[1]]
          flag='none'
       end    
      end 
    puts @lignejs
  end 
 def formatelignejs
         @javascript =Array.new
         @lignejs.each do |item| 
        item[1]=~ /.+\/(.+\.js)$/
          @javascript << [$1,item[0]]  
       end 

 end

end

