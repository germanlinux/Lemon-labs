regnom = /\/.+\/(.+?).COB/
remap  = /\ MAP ?\('(.+?)'/  
h_map = {}
file = ARGV.shift
f = File.open(file)
content1 = File.readlines(f)
# puts h_file
 Dir.glob("SOURCES khq/COBOL/*.COB").each do |f|
 #     puts f 
      nom = f.match regnom 
      #puts nom[1]
      finfo   = File.open(f)
      content  = File.readlines(finfo)
      content.each do |l| 
             l.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
             l.encode!('UTF-8', 'UTF-16', :invalid => :replace)
            tmap = l.match remap
             if tmap  
                # puts "#{nom[1]};#{tmap[1]}"
                h_map[tmap[1]] = 1

              end
      end


end
h_map.keys.each do |k|
   puts k
end   
puts "-----------"
regnom2 = /^(.+?)\ /  
content1.each do |lig|
     lig.chomp!
puts lig
     tc = lig.match regnom2
     if tc 
      nm = tc[1]
     if h_map.has_key?(nm)
        puts "#{nm} OK"
      else   
        puts "#{nm} NOT OK"
      end
     end 
end      
