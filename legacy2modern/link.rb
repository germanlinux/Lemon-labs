 fileDEF = ARGV.shift
 f = File.open(fileDEF)
 fileRES = ARGV.shift
 fr = File.open(fileRES)
 h_def = {}
 


 regfile = /(.+)\.COB/
 regsspgm = /'(.+)'/
 content = File.readlines(f)
 content.each do |i| 
 	i.chomp!
 	   h_def[i] = []
 end
    
 contentr = File.readlines(fr)
 
 contentr.each do |ligne|
 ligne.chomp!
 tnom = ligne.match regfile
 lig = tnom[1]
#puts ligne
 tsuite =   ligne.match regsspgm
 if !tsuite
 	next  
      tsuite = [] 
     tsuite[1] = ['KHQROWI3', 'KHQROWI2']
 end    
 if h_def.has_key? lig 
 	h_def[lig] << tsuite[1]
 #	puts "#{lig} : #{tsuite[1]}"
  else 
 # 	puts "non #{lig}"
 end
end

h_def.keys.each do |k|
   if h_def[k].size > 0
    puts "#{k};#{h_def[k].flatten.uniq.join(';')}"
   end   
 # puts "#{k};1;0" if h_def[k] == 1
 # puts "#{k};0;1" if h_def[k] == 10
end
h_link = {}
h_def.keys.each do |k|
   if h_def[k].size > 0
    h_def[k].flatten.uniq.each do |k|
    h_link[k] = 1	 
   end   
end
end
h_link.keys.each do |k|
	 puts k


end
