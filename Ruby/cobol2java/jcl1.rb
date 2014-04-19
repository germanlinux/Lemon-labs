require 'json'
########## lecture des jcl IBM Z/OS
# extraction du nom de jcl 
r1  = /\/\/(.+?)\s/  
# extraction du nom des programmes du jcl
r2  = /PGM=(VFP.+?)\s/ 

Dir.glob("jcl/*.txt").each do |filename| 
 f= File.open(filename)
@tabpgm = []
hash={}
content = File.readlines(f)
content.each_with_index do |ligne,i|
    l2 = ligne.force_encoding("UTF-8")
    if i == 0  then 

        tjcl =  l2.match r1 
        @jcl = tjcl[1] 
    end 
    begin
    tpgm = ligne.match r2
    rescue
    end   
    if tpgm then 
          @tabpgm << tpgm[1]
     end
 end
hash[:jcl] = @jcl
hash[:pgm] = @tabpgm
hash[:source] = content
puts hash.to_json
end      