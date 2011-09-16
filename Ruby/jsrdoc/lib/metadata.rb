#!/usr/bin/ruby
$: <<"./"
require 'rubygems'
require 'yaml'
class MetaData
# ouvre un fichier metadonnee 
# si le fichier n existe pas, il est cree
# sinon il est chargé dans une structure
attr_accessor :metadata, :file
 def initialize(mfile)
   @file= mfile + ".yaml"
   if !( File.exist?(@file)) then
      @metadata= YAML::load File.open('jsrdoc.yaml')   
    else
      @metadata= YAML::load File.open(@file)   
   end
  end

  def write(titre,chunk)
  #  myhash =Hash.new
    @metadata[titre]= chunk
    File.open(@file,'w') do |out|
    YAML.dump(@metadata,out)   
  end


  end

end

