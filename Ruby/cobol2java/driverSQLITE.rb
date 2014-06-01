require 'data_mapper'
require 'json'
DataMapper::setup(:default, "sqlite3:DB/BD_NPAY_V21.sqlite")
###################################################################################################################

class Tapplication
  include DataMapper::Resource
  storage_names[:default] = "T_APPLI"
  property :id, Serial , :field => 'APPLI_ID'
  property :nom ,String ,:field => 'APPLI_NOM'
  property :ordre ,Integer  ,:field => 'APPLI_ORDRE'
  property :fonction ,Text , :lazy => false,:field => 'APPLI_FONCT'
  property :information ,Text , :lazy => false, :field => 'APPLI_INFO'
  #def to_serialize
  # {:id => @id , :nom => @nom , :ordre => ordre , :fonction => @fonction  , :information => @information}  
  #end
  DataMapper.finalize
end
class Tpgm
  include DataMapper::Resource
  storage_names[:default] = "T_PGM" 
  property :id, String , :field => 'PGM_ID', :key => true
  property :num ,Integer ,:field => 'PGM_NUM',  :key => true
  property :programme ,String  ,:field => 'PGM_PROGR'
  property :membre ,String,:field => 'PGM_MEMBRE'
  property :titre ,Text , :lazy => false, :field => 'PGM_TITRE'
  property :type ,String,:field => 'PGM_TYPE'
  property :bib ,String,:field => 'PGM_BIB'
  DataMapper.finalize
end  
class Tjob
  include DataMapper::Resource
  storage_names[:default] = "T_JOB" 
  property :id, Integer , :field => 'JOB_ID', :key => true
  property :appli_id, Integer , :field => 'JOB_APPLI' 
  property :ordre, Integer , :field => 'JOB_ORDRE'
  property :nom, String , :field => 'JOB_NOM'
  property :fonction, Text, :lazy => false,   :field=> 'JOB_FONCT'
  property :information, Text, :lazy => false,   :field=> 'JOB_INFO'
  DataMapper.finalize
end  