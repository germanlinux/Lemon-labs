#require 'yaml'
class Set
    attr_accessor :title , :id, :secret, :photos
    def initialize (title,id,secret,photos) 
        @title= title
        @id = id
        @secret = secret
        @photos= photos
    end   
    def to_s
         "#{id}:\n  title: #{title}\n  secret: #{secret}\n  photos: #{photos}\n" 
    end
    def self.catalogue(ql,path)
        File.open("#{path}/sets.yaml",'w') do |out|
            ql.each do |un_set| 
                out.write(un_set.to_s)
            end
        end    
    end      
    def self.photos(ql,path)
        File.open("#{path}/photos.yaml",'a') do |out|
            ql.each do |un_set|
                out.write(un_set.to_s)
            end
        end    
    end      
end
class Photo
    attr_reader :url
    attr_accessor :status, :id,:title, :idset,:url, :originalformat
    def initialize ( id, originalsecret,title,originalformat, farm,server,idset)
        @id= id
        @originalsecret= originalsecret
        @title= title
        @originalformat= originalformat
        @farm= farm
        @server= server
        @idset= idset
        @url = "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{originalsecret}_o.#{originalformat}"
        @status = 'empty'
        
    end
     def to_s
         "#{id}:\n  title: #{title}\n  extension: #{originalformat}\n  set: #{idset}\n  url: #{url}\n" 
    end
            

end


