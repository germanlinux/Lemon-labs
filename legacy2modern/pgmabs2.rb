 file = ARGV.shift
 format = ARGV.shift||'1'
 f = File.open(file)
 regfileout = /(.+) OUT "(.+?)"/
 regfilein = /(.+) IN "(.+?)"/
 regnom = /\/.+\/(.+?).COB/  
 content = File.readlines(f)
 h_file = {}
 h_fileout = {}
 h_filein = {}

 content.each do |ligne|
 	ligne.chomp!
  h_file[ligne]  = 1
       
 end
# puts h_file
 Dir.glob("SOURCES khq/COBOL/*.COB").each do |f|
 #     puts f 
      nom = f.match regnom 
#      puts nom[1]
      if h_file.has_key?(nom[1])
#        puts "ok"
       else
          puts "#{nom[1]}"
       end
end
