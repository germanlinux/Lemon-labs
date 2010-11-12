require 'rubygems'
require 'json'
require 'couchdb'
require 'uri'
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
    uftclass = "Tempo_" + tclass
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
  request= "Tempo_" + table
   array_cle= eval "#{request}.find_by_sql \"SELECT #{cle} FROM #{table} \""
   puts array_cle.count
  array_cle
 end
#
#
 def _traitemnt_fact(id_array,table)
   request= "Tempo_" + table
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
 # apply filters
     art= filter(art)
     art= append(art)
#  apply options
     art=options(art)
# create json entry 
     art= json_formate(art)  
# all right , post it to couchdb, output , csv etc.
     send_to_target(art)  
   end

end
## send_to_target
#
 def send_to_target(art)
  if @config['target']['output'] then
    puts art
  elsif  @config['target']['couchdb'] then 
     res=@config['target']['couchdb'] 
     uri= URI.parse(res)
     host= uri.host
     port= uri.port
     path = uri.path
     cible= CouchDB::Server.new(host,port) 
     my_post  =   cible.post(path,art)
  end
 end 


## delete nil values
#
 def options(art)
   if @config['options'] then 
     if @config['options']['NoNil'] then 
         art= delete_nil(art)
     end
   end
   art
 end
 def delete_nil(art)
   art.each_key do  |cle|
       if !art[cle] then 
             art.delete(cle)
       end
   end 
  art
 end

## formate json
#
 def json_formate(art)
 # puts   art.inspect
    aux=  JSON(art).to_str
 #  puts  aux
  aux
 end

## filter on attribute and regexp
#
 def filter(art)
    if  @config['filters']  then 
        if @config['filters']['attributes'] then 
           art= filter_by_attribute(art)
       end           
       if @config['filters']['regexp'] then 
           art= filter_by_regexp(art)
  
       end           
    end  
    art  
        
 end
  def filter_by_attribute(art)
       tabattr= @config['filters']['attributes'].split(',')
             tabattr.each do |att|
                 art.delete(att) 
               end
    art 
 end  
##
##
  def filter_by_regexp(art)
    if @config['filters']['regexp'] then 
             tabattr= @config['filters']['regexp'].split(',')
              regexp =Array.new             
              tabattr.each do |att|
                regexp << Regexp.new(att)
              end
              art.each_key do |cle|
                  regexp.each do |motif|
                    art.delete(cle) if motif.match(cle)
                  end
               end  
        end           
   art
 end       
##
##
  def  append(art)
    if @config['append'] then 
        tabappend= @config['append']['attribute'].split(',')
        has = Hash[*tabappend.flatten]
        has.each_pair do |cle,valeur|  
           art[cle]= valeur 
           end
     end
    art

  end
# collecte (:table => table, :key => key_of_table) 
## retrive all id , then for each id retrive row and search on other dimensions
 def collecte(*arg) 
   table= arg[0][:table]
   cle = arg[0][:key]||'id'
 #  puts arg.inspect
   my_array=  collect_key(arg[0])
   parse
   complete_field_dim 
 _traitemnt_fact(my_array,table) 
 end
#
#
 def formate_hash(art,champs)
   ah = Hash.new
  #  puts  art.inspect
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
   request= "Tempo_" + un_lien.table 
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




