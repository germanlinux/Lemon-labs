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
    def self.catalogue(ql)
        File.open('sets.yaml','w') do |out|
            ql.each do |un_set| 
                out.write(un_set.to_s)
            end
        end    
    end      
    def self.photos(ql)
        File.open('photos.yaml','a') do |out|
            ql.each do |un_set|
                out.write(un_set.to_s)
            end
        end    
    end      
end
=begin
tab = Array.new
a= Set.new( 'er','eg','10')
b= Set.new( 'erx','egx','11')
    tab<<a
tab<<b

Set.catalogue(tab)
myset = YAML::load(File.open('sets.yaml'))
puts "eric"
=end  
