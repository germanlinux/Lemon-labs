 file = ARGV.shift
 f = File.open(file)
 regfile = /PROGRAM\((.+?)\)/
 content = File.readlines(f)
 content.each do |ligne| 
     tscan = ligne.match regfile
     puts tscan[1]  if tscan
 end
     
