regdecoupeExec = /^\/\/([^ ]+)\ +.*EXEC\ +PGM=([^,]+)/
regnom = /([^\/]+?)\.\w{3}/
fileJCL = ARGV.shift
mode =ARGV.shift ||'calc'

tnomjcl  = fileJCL.match regnom
nom = tnomjcl[1]
hashnode={}
f = File.open(fileJCL)
content = File.readlines(f)
node = ["node!#{nom}!#{nom}!r"]
content.each do |l|
	next if l=~ /^\/\/\*/
	l.chomp!
	if l.match regdecoupeExec 
		ts= l.match regdecoupeExec
		next if ts[1] =='PLANTAGE'
		suite =''
		if ts[2] == 'IDCAMS' or  ts[2] == 'REPRO' or  ts[2] == 'ICEGENER'
		   suite = ";non;non"
		end
		if ts[2] == 'SORT'
		   suite = ";non;oui;oui"
		end
		   
		puts "#{nom};#{ts[2]};#{ts[1]}#{suite}"  if mode == 'calc'
		if mode =='dot'
			  sg=  ts[1]
			  puts  ts[1]
		    if hashnode.has_key? sg
		    	sg += 'z'
		    	if hashnode.has_key? sg
		    	  sg += 'z'
		    	end
		    end
		    hashnode[sg] = 1	
			chaine = "node!#{ts[2]}!#{sg}!" 
            if  ['IDCAMS','SORT','ICETOOL','IEBGENER','ICEGENER','IEFBR14',
                 'ADRDSSU' ,'SRSBV010','CFTUTIL' ].include? ts[2] 
                 chaine+='t'
            else 
                 chaine  += 'p'
            end
         node<< chaine
         end                               
	end          
end
if mode == 'dot'
liens =[]
	 (0..node.size-2).each do |cp|
	 	     ts = node[cp].split('!')
	 	     ts2 = node[cp+1].split('!')
            liens <<  "lien!#{ts[2]}!#{ts2[2]}"
      end
 node.each do |n| 
 	 puts n
 end
liens.each do |l| 
 	 puts l
 end
  	 

 end     
