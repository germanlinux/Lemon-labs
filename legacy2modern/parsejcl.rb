class Sort 
    def initialize (label, nom , tligne)
    	    regSortinout= /DD +DSN=(.+),/
        	regSort= /SORT FIELDS=(.+) ?/
	        regInclude= /INCLUDE COND=(.+\),?)/
          regSuite = /^\ +(.+) |$/
        @ligne = tligne
        @nom = nom
        @label = label
    	@ligne.each_with_index do |l,v| 
        	 if l =~/SORTIN/  then 
              
        	 	  ts = l.match regSortinout  
                  @input  = ts[1]
             end
             if l =~/SORTOUT/  then 
        	 	  ts = l.match regSortinout  
                  @output  = ts[1]
             end
             if l =~/SORT FIELDS/  then 
        	 	  ts = l.match regSort  
                  @critere  = ts[1]
                  if l[-1] == ',' 
                  	@critere << @ligne[v+1]
                  	@critere.gsub!(/ +/,'')
                  end	
             end
             if l =~/INCLUDE/  then 
        	 	  ts = l.match regInclude
                  @include =''
                  @include  = ts[1] if ts
                  if l[-1] == ','
                    l2 = @ligne[v+1]
                    l2.gsub!(/\d+$/,'')
                  	@include << l2
                  	@include.gsub!(/ +/,'')
                  elsif l[-1]=~ /\d/
                    l2 = @ligne[v+1]
                     l2.gsub!(/\d+$/,'')
                     	@include << l2
                    @include.gsub!(/ +/,'')
                   end 
             end
        end
        @include ||= 'aucune'
    end
  def export
   "#{@nom}-#{@label}:\n -Input:#{@input}\n -Output:#{@output}\n -Critere:#{@critere}\n -Restriction:#{@include}"
  end	
def export_json
	@hash ={:nom => @nom, :label => @label , :input => @input, :output => @output , :critere => @critere  , :include => @include  }   
  end	
def noeud_dot
chaine =""  
chaine  =  "node!Sort!#{@label}!Sort£Critere:#{@critere}£Include:#{@include}!Mdiamond\n"
chaine +=  "node!#{@input}!!!ellipse\n"
chaine +=  "node!#{@output}!!!ellipse\n"
#chaine +=  "node!Critere:#{@critere}!\n"
#chaine +=  "node!Include:#{@include}!\n"  if @include !="aucune"


chaine  
end 
def label 
   @label
end    
def lien
   chaine=''
   chaine +="lien!#{@input}!#{@label}\n"
   chaine +="lien!#{@label}!#{@output}\n"
   #chaine +="lien!#{@label}!Critere:#{@critere}\n"
   #chaine +="lien!#{@label}!Include:#{@include}\n"  if @include !="aucune"
   chaine
end  

end
#---------------------------------------
class Idcams 
#---------------------------------------  
  def initialize (label, nom , tligne)
  	@ligne = tligne
    @nom = nom
    @label = label
    regcond = /COND=(.+)/
    regDelete= /DELETE.+\((.+)\)/
    regDel= /DEL (.+?)\ /
    
    @ligne.each_with_index do |l,v|
         if l=~  /COND=/ 
          ts  = l.match regcond
          @cond = ts[1]
         end 
    		if l =~ /DELETE/ 
    		 ts = l.match regDelete
    		 @file_delete = ts[1] if ts
    		 end
         if l =~ /DEL / 
         ts = l.match regDel
         @file_delete = ts[1]
         end      	
    end
    @cond||='aucune' 
  end
  def export
   "#{@nom}-#{@label}:\n  - Supression de : #{@file_delete} - Condition:#{@cond}"
  end
  def export_json 
    @hash = {:nom => @nom, :label => @label ,:file => @file_delete} 	
end
def noeud_dot
  chaine =""  
  chaine  =  "node!IDCAMS-DELETE£#{@file_delete}£condition:#{@cond}!#{@label}\n"
 # chaine +=  "node!fichierdelete:#{@file_delete}!!!dashed!\n"
  chaine  
end 
def label 
   @label
end    
def lien
#   chaine=''
#   chaine +="lien!#{@label}!#{@file_delete}!w\n"
#   chaine
end  

end
class Icetool

 def initialize (label, nom , tligne)
 end
 def export
    "#{@nom}-#{@label}"
 end
 def export_json 
    @hash = {:nom => @nom, :label => @label}	
end
def noeud_dot
  chaine =""  
  chaine  =  "node!ICETOOL\n"
  chaine  
end 
end

class Iebgener
 def initialize (label, nom , tligne)
  regSysutil=/DD DSN=(.+),/
  regSysutil2= /SYSUT2/
  @ligne = tligne
  @nom = nom
  @label = label
  @ligne.each_with_index do |l,v| 
     if l =~/SYSUT1/  then 
          if l =~ /DD DUMMY/ 
             @util1 = ''
          else 
            ts = l.match regSysutil1 
            @util1 = ts[1]  
          end
     end     
     if l =~/SYSUT2/  then 
          if l =~ /DD DUMMY/ 
             @util2= ''
          else 
            ts = l.match regSysutil 
            @util2 = ts[1]  
          end
     end        
 end 

 end
 
 def export
    "#{@nom}-#{@label}:\n -Util1 (input) :#{@util1}\n - Util2 (output) :#{@util2}\n"
 end
 def export_json 
    @hash = {:nom => @nom, :label => @label}  
end
def noeud_dot
  chaine =""  
  chaine  =  "node!IEBGENER!#{@label}!IEBGENER!\n"
  if @util1.size  < 3 
      chaine+=''
  else 
      chaine+= "node!#{@util1}!!!ellipse\n"
  end
  chaine    += "node!#{@util2}!!!ellipse\n"
  chaine 
end
def label 
   @label
end    
def lien
   chaine=''
   if @util1.size > 3
     chaine +="lien!#{@util1}!#{@label}\n"
    end
   chaine +="lien!#{@label}!#{@util2}\n"
   chaine
end  

end

class Icegener
 def initialize (label, nom , tligne)
  regSysutil=/DD DSN=(.+),/
  regSysutil2= /SYSUT2/
  regcond = /COND=(.+)/
  @ligne = tligne
  @nom = nom
  @label = label
  @ligne.each_with_index do |l,v| 
        if l=~  /COND=/ 
          ts  = l.match regcond
        @cond = ts[1]
         end 
     if l =~/SYSUT1/  then 
          if l =~ /DD DUMMY/ 
             @util1 = ''
          else 
            ts = l.match regSysutil1 
            @util1 = ts[1]  
          end
     end     
     if l =~/SYSUT2/  then 
          if l =~ /DD DUMMY/ 
             @util2= ''
          else 
            ts = l.match regSysutil 
            @util2 = ts[1]  
          end
     end

 end 
     @cond ||='aucune'
 end
 
 def export
    "#{@nom}-#{@label}:\n -Util1 (input) :#{@util1}\n - Util2 (output) :#{@util2}\n"
 end
 def export_json 
    @hash = {:nom => @nom, :label => @label}  
end
def noeud_dot
  chaine =""  
  chaine  =  "node!ICEGENER!#{@label}!ICEGENER£condition:#{@cond}!\n"
  if @util1.size  < 3 
      chaine+=''
  else 
      chaine+= "node!#{@util1}!!!ellipse\n"
  end
  chaine    += "node!#{@util2}!!!ellipse\n"
  chaine 
end
def label 
   @label
end    
def lien
   chaine=''
   if @util1.size > 3
     chaine +="lien!#{@util1}!#{@label}\n"
    end
   chaine +="lien!#{@label}!#{@util2}\n"
   chaine
end  

end


class Program       
 def initialize (label, nom, tligne)
  @label = label
  @nom = nom
  @ligne = tligne
  @files ={}
  @acces ={}

  regDSN= /^\/\/(.+?)\ .+DSN=(.+?),/
  @ligne.each_with_index do |l,v| 
        	 if l =~/ DD +DSN=/  then 
        	 	  ts = l.match regDSN
        	 	  
                  nom = ts[1]
                  fichier = ts[2]
                  if fichier =~/ORACLE/ 
                  	 nom = 'ORACLE'
                  	 fichier ="acces BDD"
                  end	 
                  @files[nom] = fichier
                  @acces[nom] = 'Indetermine'
                  if l =~ /DISP=SHR/ and nom != 'ORACLE'
                    @acces[nom] = 'E/S'
                  end
                  if l =~ /DISP=OLD/ 
                   @acces[nom] = 'E'
                  end
                  if l[-1] = ',' and @ligne[v +1] =~ /CATLG,CATLG/
                  	 @acces[nom] = 'S'
                  end  
                  if l[-1] = ',' and @ligne[v +1] =~ /DISP\=MOD/
                  	 @acces[nom] = 'S'
                  end  

             end
        end
 end

 def export
 	chainepgm = ""
 	@files.keys.each do |k|
 	  chainepgm += "#{k} : #{@files[k]} en  #{@acces[k]}\n  "
 	end  
    "#{@nom}- Programme: #{@label}:\n  #{chainepgm}"
 end	 
def export_json

 	tab =[]
 	@files.keys.each do |k|
 	  th = {:nom => k, :file => @files[k] , :accces  => @acces[k]}
 	  tab << th

 	end  
    @hash = {:nom => @nom, :label => @label,:es => tab }
     end	 
def noeud_dot
  chaine =""

  @files.keys.each do |k|
    chaine += "node!#{@files[k]}!!!ellipse\n"
  end  
   chaine += "node!programme:#{@nom}\n"   
 end 
def label 
   @nom
end
def lien 
  chaine=''
   @files.keys.each do |k|
    if @acces[k] =='E' 
    chaine += "lien!#{@files[k]}!#{@nom}\n"
     else
    chaine += "lien!#{@nom}!#{@files[k]}\n"
     end
  end  
  chaine
end

end 


class Step
	@@liste = []
	@@titre = ""
	attr_accessor :label , :nom ,:type
	

	def initialize (label, nom , tligne)
    @label = label
    @label.gsub!(/ +$/,'')
    @nom = nom
    @ligne = tligne
    if ['IDCAMS','SORT','ICETOOL','IEBGENER','ICEGENER'].include? @nom 
    	@type = 'step technique' 
    	tmpnom= @nom.capitalize 
        myclazz = Object.const_get(tmpnom)
        eg = myclazz.new  @label,@nom, @ligne
    else
        @type = 'programme'
        eg = Program.new @label, @nom , @ligne	
    end
     @@liste << eg
    end
    def Step.list 
       @@liste
    end  
    def Step.size 
      @@liste.size
    end  
     def Step.setTitre(file) 
      @@titre = file
    end  
     def Step.getTitre 
      @@titre
    end  
     def Step.noeud_titre 
      chaine =""  
      chaine +="node!#{@@titre}"
      chaine
    end  
     def Step.lien
      chaine=''
       chaine +="lien!#{@@titre}!#{@@liste[0].label}!10\n"
       lgl = @@liste.size
       (0..size-2).each do |cp|
            chaine +="lien!#{@@liste[cp].label}!#{@@liste[cp+1].label}!10\n"
      end
      chaine
     end    
     def Step.lien2
      chaine=''
       @@liste.each do |it| 
         chaine +="lien!#{@@titre}!#{it.label}\n"
      end
      chaine
     end    
end


#lire le fichier
# le charge dans un tableau
#boucle tableau
#flag debut de bloc ?
#traitement  bloc et recherche fin de bloc
#recherche debut de bloc
regDebutFinBlock = /EXEC /
regComment = /^\/\/\*/
regdecoupeExec = /^\/\/(.+) +?EXEC PGM=(.+)/
fileJCL = ARGV.shift
Step.setTitre(fileJCL)
f = File.open(fileJCL)
content = File.readlines(f)
flagDB =0 
@tsuite = []
#puts content.size
content.each do |ligne|
	ligne.chomp!
   next if ligne.match regComment 	
  if ligne.match regDebutFinBlock  and flagDB ==0 
  	 @ligneBlock = []
  	 @ligneBlock << ligne
  	 flagDB = 1
  	 #etiquette # exec #
  	 tsplit = ligne.match regdecoupeExec
     #puts tsplit[1]
     #puts tsplit[2]
     @tsuite = tsplit[2].split(',') if tsplit
     @tsuite = tsplit[2] unless @tsuite
     #puts @tsuite[0] 
     @tsuite[1] = tsplit[1]  if tsplit

     next
   end
   
  if ligne.match regDebutFinBlock  and flagDB ==1 
  	flagDB = 0
  	 toto = Step.new @tsuite[1], @tsuite[0] , @ligneBlock
     redo
  	 #puts toto.inspect
  elsif flagDB ==1 
    @ligneBlock << ligne 	 
  end
end
if flagDB == 1
	toto = Step.new @tsuite[1], @tsuite[0] ,@ligneBlock
  	 #puts toto.inspect
 end
 Step.list.each do |o|
 	# puts  o.export
 end
puts Step.noeud_titre
 Step.list.each do |o|
 	 puts  o.noeud_dot
 end
puts Step.lien
 Step.list.each do |o|
   puts  o.lien if o.lien
 end

# puts "#{Step.size} steps" 


