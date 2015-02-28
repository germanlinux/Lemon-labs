 fileDEF = ARGV.shift
 f = File.open(fileDEF)
 fileRES = ARGV.shift
 fr = File.open(fileRES)
 h_def = {}
 
 regfile = /(.+)\.COB/
 content = File.readlines(f)
 content.each do |i| 
 	i.chomp!
 	   h_def[i] = 1
 end
    
 contentr = File.readlines(fr)
 
 contentr.each do |ligne|
 ligne.chomp!
 tnom = ligne.match regfile
 lig = tnom[1]
 #puts lig
 if h_def.has_key? lig 
 	h_def[lig] = 10
 	puts lig
  else 
 # 	puts "non #{lig}"
 end
end
h_def.keys.each do |k|

 # puts "#{k};1;0" if h_def[k] == 1
 # puts "#{k};0;1" if h_def[k] == 10
end
