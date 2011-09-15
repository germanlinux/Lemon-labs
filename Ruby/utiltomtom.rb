require 'find'
class Sauvegarde
attr_accessor :directory, :path, :file, :contenu
  def initialize(path)
   @path= path
   @directory=0
   @file= 0
  end
  def analyse
    @contenu= Hash.new
    Find.find(@path) do |f|
     if File.ftype(f) == 'directory' then 
        @directory= @directory + 1
      else
        @file= @file + 1
      end
    infof= File.stat(f).size
    infom = File.stat(f).mtime
     tmp_h= Hash.new
     tmp_h['size'] = infof 
     tmp_h['mdate']= infom  
    @contenu[f]=tmp_h
    end


  end

end

class InfoTOMTOM
attr_accessor :file ,:tableauinfo, :info, :map
  def initialize(file)
    @file= file
    if @tableauinfo.nil? then 
      if( File.exist?(file)) then 
        @tableauinfo= IO.readlines(file)
       else
         raise "le fichier  #{file} n existe pas" 
      end
    end
  end

  def get_info_produit
   @tableauinfo.each do |line|
     if line=~ /^Item description = (.+)/ then 
      @info= $1
      @info.chomp!
      return @info
    end   
  end  
  end 
  def  get_info_map
   @map= Array.new
  @tableauinfo.each do |line|
    if line=~ /^Map\s+(\d+) name = (.+)/ then 
      @map << [$1,$2.chomp!]
    end   
   end
     @map
  end  
 def get_info_application
   @map= Array.new
  @tableauinfo.each do |line|
    if line=~ /^Application version\s+=(.+)/ then 
      @map << ['Application version',$1.chomp!]
    end   
    if line=~ /^Application build\s+=(.+)/ then 
      @map << ['Application build',$1.chomp!]
    end   

   end
     @map
 

 end   
end
 
