class Glissiere
    def initialize 
      @premier = true
      @sequence = false
      @courant_table = nil
      @courant_rang = nil
      @courant_id = nil
      @courant_poste = nil
      @prec_poste= nil
      @prec_rang = nil


    end
    def erreur
       @erreur
    end
    def empile( array)
      @courant_table = array[0]
      @courant_id = array[1].to_i
      @courant_poste = array[2].to_i
      @courant_rang = array[3].to_i
      @erreur = false
      if array.size == 2  then 
        return
       end 
      if @courant_poste != @prec_poste then 
        @premier = true
        @sequence = false   
       end
       if @courant_poste == 0 then 
         @premier = true
         @sequence = false   
       end
          
      if @premier and @courant_poste == 0  
        @erreur = "Table #{@courant_table} : id : #{@courant_id} -- Absence du la cle" 
        end
      if @premier and @courant_rang != 0 then 
         @erreur = "Table #{@courant_table} : id : #{@courant_id} -- commence a : #{@courant_rang} au lieu de 0" 
      end
      if @sequence and  @courant_rang != @prec_rang + 1 
            @erreur = "Table #{@courant_table} : id : #{@courant_id} -- ne respecte pas la sequence : #{@courant_rang} au lieu de #{@prec_rang + 1}  " 
      end
      @premier = false
      @sequence = true 
      @prec_rang = @courant_rang
      @prec_poste = @courant_poste      
    end



 end
 

filecontent = ARGV.pop
rest = File.readlines(filecontent)
glissiere = Glissiere.new 
rest.each do |t| 
    t.chomp!
    table =t.split(';')
    glissiere.empile (table)
    if glissiere.erreur then 
        puts glissiere.erreur
    end
 end

