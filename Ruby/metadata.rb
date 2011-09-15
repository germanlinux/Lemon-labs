require 'rubygems'
require 'yaml'
class MetaData
# ouvre un fichier metadonnee 
# si le fichier n existe pas, il est cree
# sinon il est chargé dans une structure
attr_accessor :metadata, :file
 def initialize(mfile)
   @file= mfile + ".yaml"
   if ( File.exist?(@file)) then
      @metadata= YAML::load File.open('tomtom.yaml')   
    else
      @metadata= Hash.new  
   end
  end

  def write
  #  myhash =Hash.new
    File.open(@file,'w') do |out|
    YAML.dump(@metadata,out)   
   end
  end
  def directory_save
    @metadata['directory_save']||'Saisir un nom de repertoire'
  end
   def get_cpdir
    @metadata['cpdirectory']||'non calcule'
  end
   def get_cpfile
    @metadata['cpfile']||'non calcule'
  end
     def get_date
    @metadata['date']||'non disponible'
  end    
end

