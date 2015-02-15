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
        i_ligne = "SOURCES khq/COBOL/#{ligne}.COB"
       if File.exist?(i_ligne)
          puts "ok"
       else

          puts "#{ligne} not ok"
       end
 end
          
