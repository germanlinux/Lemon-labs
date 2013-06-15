class Source
  attr :type, :nom_cobol, :total , :active  , :nature , :prodivtotal, :prodivactive
  def initialize(rep, file)
    @rep =  rep
    @file = file
  end
  def lire_amorce
    nf = @rep + @file
    f = File.open(nf)
    @content =[]
    20.times  do
      begin     
        line  = f.readline 
        @content << line
      rescue  
      end     
    end
  end

  def find_type
    r1 =   /PROGRAMME\s+(\w+)/
    r2 =   /PROGRAM-ID.\s+(\w+)/ 
    r3 = /DESCRIPTION DE L'ENREGISTREMENT\s+(\w+)/         
    type2 = type1 = type3 =  'undef'
        # est-ce-une grille
        r5 = /\s{7}01\s+(\w+)/
        r6 = /\s{7}\d\s+(\w+)-/  
        m5 = r5.match @content[0]
        if m5 then  
          @nom_cobol = m5[1] if m5
          @type = 'grille'
        else 
          @content.each  do |line|
            begin
              if @type == 'enregistrement' and !@prefixe then 
               m6 = r6.match line 
               @prefixe = m6[1] if m6
             end      
             m1 =  r1.match line 
             @nom_symb = m1[1] if m1
             m2 =  r2.match line 
             @nom_cobol = m2[1] if m2
             m3 =  r3.match line 
             type3 = m3[1] if m3
           rescue
           end 
           if m1 or m2 then @type = 'programme' end
             if m3 then @type = 'enregistrement'    end
             end
           end    
         end
         def compte
          nf = @rep + @file
            #puts nf
            @total = @commentaire = @active = 0
            rcom = /\s{6}\*.+/  

            File.open(nf, 'r:windows-1252:UTF-8') do |f1|  

              while line = f1.gets  
               puts line
               @total += 1
               com = rcom.match line
               if com then @commentaire = @commentaire + 1 
               else 
                 @active = @active + 1
               end 
             end 

           end

         end             
         def batch_tpr
          nf = @rep + @file
            #puts nf
            rtpr = /SINGRILLE/  
            @nature = 'batch'  
            File.open(nf, 'r:windows-1252:UTF-8') do |f1|  
              while line = f1.gets 
               stype = rtpr.match line
               if stype then 
                 @nature = 'TPR'
                 break
               end 
             end
           end                            
         end
         def to_hash
          t_hash = {:rep => @rep, 
            :fichier => @file, 
            :type => @type,
          } 
          t_hash[:nom_cobol] = @nom_cobol if @nom_cobol
          t_hash[:nom_symb] = @nom_symb if @nom_symb
          t_hash[:prefix] = @prefix if @prefix
          t_hash[:total] = @total if @total
          t_hash[:commentaire] = @commentaire if @commentaire > 0
          t_hash[:active] = @active if @active
          t_hash[:nature] = @nature if @nature and @type == 'programme'
#    t_hash[:prodivactive] = @prodivactive if @prodivactive > 0
#    t_hash[:prodivtotal] = @prodivtotal if @prodivtotal > 0

t_hash
end
  def procedure_division
    nf = @rep + @file  
    rpdiv = /\s{7}PROCEDURE DIVISION/ 
    rcom = /\s{6}\*.+/  
    pile = 0
    @prodivtotal = @prodivactive = 0 
    File.open(nf, 'r:windows-1252:UTF-8') do |f1|  
      while line = f1.gets      
        fpile = rpdiv.match line
        pile = 1 if fpile
        if pile == 1 then  
            @prodivtotal += 1  
            com = rcom.match line
            @prodivactive += 1 if com
        end
     end
    end    
  end     
end
class Entites
attr  :array_of_ent
 def initialize(een)
  @een = een
  @array_of_ent =[] 
  @een.each do |line|
    tmp_arr = line.unpack "A18A4A4A4A4A4A*"
#    puts tmp_arr.inspect
    tmp_arr.map {|e| e.strip!}
hj = {}
hj[:entite] = tmp_arr[0]
hj[:type] = tmp_arr[1]
hj[:commentaire] = tmp_arr[6]
  t_prop = tmp_arr[2]  
  if tmp_arr[2].match(/^\d+$/) then 
     t_prop = tmp_arr[2].to_i 
  end   
  hj[:prop1] = t_prop
  t_prop = tmp_arr[3]
  if tmp_arr[3].match(/^\d+$/) then 
     t_prop = tmp_arr[3].to_i 
  end
  hj[:prop2] = t_prop
  t_prop = tmp_arr[4]
  if tmp_arr[4].match(/^\d+$/) then 
     t_prop = tmp_arr[4].to_i 
  end
  hj[:prop3] = t_prop

  t_prop = tmp_arr[5]
  if tmp_arr[5].match(/^\d+$/) then 
     t_prop = tmp_arr[5].to_i 
  end
  hj[:prop4] = t_prop
  @array_of_ent << hj
#    puts tmp_arr.inspect
=begin
    tmp_e = ":IDENTIFIER, :TYPE, :PROP1 ,:NATURE, :PROP2,:NATURE :PROP3 ,:NATURE:PROP4,:NATURE,:COM"
#    puts tmp_arr
      type2 = :EMPTY if tmp_arr[2].empty?
      type3 = :EMPTY if tmp_arr[3].empty?
      type4 = :EMPTY if tmp_arr[4].empty?
      type5 = :EMPTY if tmp_arr[5].empty?
      type2 = :INTEGER if tmp_arr[2].match(/^\d+$/)
      type3 = :INTEGER if tmp_arr[3].match(/^\d+$/)
      type4 = :INTEGER if tmp_arr[4].match(/^\d+$/)
      type5 = :INTEGER if tmp_arr[5].match(/^\d+$/)
      type2||="STRING"
      type3||= "STRING" 
      type4||="STRING" 
      type5||="STRING" 


      result=  [ [:IDENTIFIER,tmp_arr[0]] , [:TYPE , tmp_arr[1]] , [type2,  tmp_arr[2]],[type3 ,tmp_arr[3]],
               [type4 ,tmp_arr[4]],[type5, tmp_arr[5]],[:commentaire ,tmp_arr[6]]] 
     puts result.inspect
=end
  end  

 end

end
