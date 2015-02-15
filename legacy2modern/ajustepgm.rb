 file = ARGV.shift
 format = ARGV.shift||'1'
 f = File.open(file)
 regfileout = /(.+) OUT "(.+?)"/
 regfilein = /(.+) IN "(.+?)"/
 regnom = /^(.+?)\ /  
 content = File.readlines(f)
 h_file = {}
 h_fileout = {}
 h_filein = {}

 content.each do |ligne|
 	ligne.chomp!
 #    tscan = ligne.match regfile
 #    puts tscan[1]  if tscan
 #     puts ligne
      tc = ligne.match regnom
      puts tc[1]  if tc 
      end
