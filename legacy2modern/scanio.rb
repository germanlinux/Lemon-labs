 file = ARGV.shift
 format = ARGV.shift||'1'
 f = File.open(file)
 regfileout = /(.+) OUT "(.+?)"/
 regfilein = /(.+) IN "(.+?)"/
 content = File.readlines(f)
 h_file = {}
 h_fileout = {}
 h_filein = {}

 content.each do |ligne|
 	ligne.chomp!
 #    tscan = ligne.match regfile
 #    puts tscan[1]  if tscan
      i_ligne = "SOURCES khq/PGM/#{ligne}.PGM"
 	if File.exist?("SOURCES khq/PGM/#{ligne}.PGM") 
    #	puts "#{ligne}"
    	finfo   = File.open(i_ligne)
    	ioinfo  = File.readlines(finfo)
    	sortie = ligne
        ioinfo.each do |l| 
     #   	 puts l
        	 tout = l.match regfileout 
        	 tin = l.match regfilein 
        	 if format == '1'
	        	 puts "#{ligne};#{tin[1]};IN;#{tin[2]}"  if tin
    	         puts "#{ligne};#{tout[1]};OUT;#{tout[2]}"  if tout
              end
             if format == '2'
                 sortie << ";#{tin[1]};IN;#{tin[2]}" if tin
                 sortie << ";#{tout[1]};OUT;#{tout[2]}" if tout
             end
             h_file[tin[2]] =  tin[1] if tin
             h_fileout[tout[2]]=1    if tout
             h_file[tout[2]] =  tout[1]  if tout
             h_filein[tin[2]]=1 if tin
        end    
       puts sortie if format =='2' 
 	else
   		puts "#{ligne} ABSENT"
 	end
end
if format =='3'
	h_file.keys.each do |k| 
       chaine = "#{k};#{h_file[k]};"
       if h_fileout.has_key?(k) 
       	  chaine << "1" 
       else
          chaine << "0" 
       end
       if h_filein.has_key?(k) 
       	  chaine << ";1" 
       else
          chaine << ";0" 
       end
    puts chaine        	  
    end
end

