require 'active_record'
class Nosql
attr_accessor :links
#
#
  def initialize(my_hash)
     @config = my_hash
   ## ouverture de la connection
     ActiveRecord::Base.establish_connection(@config['Datasource'])
  end
#
#
  def get_list_dim
    @config['Tables']['table_dimension'].keys 
  end
## get_field (table) 
## return array of field  
 def get_field(my_dim)
      myclass = _create_class(my_dim)
  end
#
#
 def  _create_class(tclass)
    uftclass = "Tempo" + tclass
     eval "
        class #{uftclass} < ActiveRecord::Base
          set_table_name  \"#{tclass}\"
        end
       "
      fields= eval "#{uftclass}.column_names"
     
 end
## collect_key(:table => table, :key => key_of_table) 
## find all row and return array of id 
 def  collect_key(*arg)
   
  table= arg[0][:table]
  cle = arg[0][:key]||'id'
  t= _create_class(table)
  request= "Tempo" + table
   array_cle= eval "#{request}.find_by_sql \"SELECT #{cle} FROM #{table} \""
   puts array_cle.count
  array_cle
 end
#
#
 def _traitemnt_fact(id_array,table)
   request= "Tempo" + table
   my_field = get_field(table)
   if @config['Tables']['table_fact'] == table then 
      is_fact =1  
   else
      is_fact= 0
   end 

   cle_used= @config['Tables']['primarykey'] if is_fact==1
   cle_used= @config['Tables']['table_dimension'][table]['primarykey']  if is_fact==0

   id_array.each do |t_id|
     my_id= t_id.id
     un_article= eval "#{request}.find_by_sql  \"SELECT * FROM #{table} WHERE #{cle_used} = #{my_id} \""
     art= formate_hash(un_article,my_field)  
     art= complete_dim(art) if is_fact==1  
     puts art.inspect 
   end 
 end
# collecte (:table => table, :key => key_of_table) 
## retrive all id , then for each id retrive row and search on other dimensions
 def collecte(*arg) 
   table= arg[0][:table]
   cle = arg[0][:key]||'id'
   puts arg.inspect
   my_array=  collect_key(arg[0])
   parse
   complete_field_dim 
 _traitemnt_fact(my_array,table) 
 end
#
#
 def formate_hash(art,champs)
   ah = Hash.new
    puts  art.inspect
  champs.each do |cle|
     ah[cle] = art[0].send(cle)
   end
  ah
  end     
#
#
 def parse 
   my_extract= @config['Tables']['table_dimension']
   my_acces = my_extract.keys 
   my_array= Array.new()
   my_acces.each do |une_table|
     father= my_extract[une_table]['foreignkey']
     son= my_extract[une_table]['primarykey']
     a= Link.new(une_table,father,son) 
     my_array << a 
   end
  @links= my_array
 end
#
#
 def collecte_all
  table= @config['Tables']['table_fact']
  id = @config['Tables']['primarykey']
  collecte(:table=> table , :key=> id)
 end 
#
#
 def complete_dim(art) 
   @links.each do |un_lien|
       arr = un_lien.attributes
       ajoute= suite(art,un_lien) 
       arr.each do |cle|
           cle_loc= cle    
          if art[cle]  then 
             cle_loc= un_lien.table + "_" + cle         
          end
             art[cle_loc] = ajoute.send(cle)
        end
      
       end
    art
 end
#
#
 def complete_field_dim
   @links.each do |un_link|
     un_link.attributes= get_field(un_link.table)
  end 
 end
#
#
 def suite(art,un_lien)
  cle_a_utilisee= un_lien.fact
  valeur_cle= art[cle_a_utilisee]
   if valeur_cle then 
   cle_dim= un_lien.local
   request= "Tempo" + un_lien.table 
   un_article=  eval "#{request}.find_by_sql  \"SELECT * FROM #{un_lien.table} WHERE #{cle_dim} = #{valeur_cle} \""
   end 
   un_article[0]
 end
#
#
 def  collecte_dim(une_dim)
    parse
    complete_field_dim
    table= une_dim
    cle_used= @config['Tables']['table_dimension'][table]['primarykey']  
    my_array_of_id=  collect_key(:table => table, :key => cle_used)
    _traitemnt_fact(my_array_of_id,table)
  end 
end
#
#
#
class Link
 attr_accessor :table,:fact,:local,:attributes
#
#
 def initialize (table,father,son) 
  @table= table
  @fact= father
  @local= son 
 end

end




