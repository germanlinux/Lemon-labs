 file = ARGV.shift
 format = ARGV.shift||'1'
 f = File.open(file)
 regfileout = /(.+) OUT "(.+?)"/
 regfilein = /(.+) IN "(.+?)"/
 regnom = /EXEC CICS\ /  
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
       if File.exist?(ligne)
       		g= File.open(ligne)
       		content2 = File.readlines(g)
       		content2.each  do |l|
       	     l.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
             l.encode!('UTF-8', 'UTF-16', :invalid => :replace)
            tcics = l.match recics
             if tcics  
                # puts "#{nom[1]};#{tmap[1]}"
                h_map[tcics[1]] = 1

              end


       else

          puts "#{ligne} not ok"
       end
 end
          
