require 'json'
class Erreur
def initialize (fichier, nb, ligne, table , cle,value, motif, lgrep  )
      @fichier = fichier
      @rang = nb
      @ligne= ligne
      @table = table
      @cle = cle
      @id_value =value
      @lgrep = lgrep
      @motif = motif
end
def to_json 
     h={}
     h[:fichier]  = @fichier
     h[:rang]  = @rang
     h[:ligne]  = @ligne
     h[:table]  = @table
     h[:cle]  = @cle
     h[:id_value]  = @id_value
     h[:lgrep]  = @lgrep
     h[:motif]  = @motif
     chaine = h.to_json     
end 
end  
class LigneSQL
   def initialize (pline,pnb)
      @line = pline
      @rang = pnb
      @tabelem = @line.split(' ')
      @table = @tabelem[2]
      cle = @tabelem[3]
      @id= cle[1..-2]

      fl_deb = false
       @value_sql= []
       @value_grep =[]
        @tabelem.each_with_index do |item, i |
        @value_sql  << item if fl_deb
        @value_grep << item unless fl_deb
          if item == "VALUES"  then 
             fl_deb = true
             @value_grep << @tabelem[i+1] 
           end
      end
      @value_string = @value_sql.join(" ")
      @value_grep_string = @value_grep.join(" ")
      tmpch = @value_sql[0]
      @value_sql[0] =  tmpch[1..-2]
      tmpch = @value_sql[-1]
       @value_sql[-1] =  tmpch[0..-3]
     end
    def recherche_table
       @table
    end
   
    def recherche_cle
       @id
    end
    def get_value_string
     @value_string
    end
 def get_value_array
     @value_sql
    end
 def get_grep
    @value_grep_string
end   
 def get_value_id
   @value_sql[0]
 end
end

class FichierSQL
    def initialize (file)
      @linesql = File.readlines (file)
    end
     def get_line_by_number(nb)
      @linesql[nb-1]
     end 
end


filecontent = ARGV.pop
content = File.readlines(filecontent)

content.each_with_index do |line, i | 
      tab = line.split(':')
      if tab[0] == 'psql' then 
           @sqlfile = tab[1]
           @fichiersql = FichierSQL.new (@sqlfile) unless @fichiersql
           @lineerror = tab[2] 
           ## allez chercher la ligne dans le fichier 
           
           @ll = @fichiersql.get_line_by_number(@lineerror.to_i)
           ligne= LigneSQL.new(@ll , @lineerror.to_i)
           @table= ligne.recherche_table
           @cle = ligne.recherche_cle
           @l1 = ligne.get_grep
           @id_value= ligne.get_value_id
          
       end
        motif ='inconnu'
       if tab[0] == 'DETAIL' then 
        if  tab[1].scan(/already exists/) then motif = 'doublon'
        end  
       end
       if tab[0] == 'LINE' then
         motif = "syntax error"
       end
       if motif != 'inconnu' then 
         obj_erreur = Erreur.new(@sqlfile, @lineerror.to_i ,@ll ,  @table, @cle,@id_value,motif,  @l1 )
       end
        if obj_erreur then 
          puts  obj_erreur.to_json 
          obj_erreur = nil 
        end
       if tab.size == 1 then 
          next
       end      


         
      end
