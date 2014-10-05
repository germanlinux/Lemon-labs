require 'json'
require 'pathname'
require 'mongo'
include Mongo
path = ARGV.shift
path+="*"
r_ext = /(.*)\.(\w+)/
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
Dir.glob(path).each do |filename| 
 t = Pathname.new(filename)
filename_t = t.basename
t_onlyname = filename_t.to_s.match r_ext
if t_onlyname
onlyname = t_onlyname[1] 
## recherche jcl 
pgm  = @db['programmes'].find(:programme => onlyname).to_a ;

if pgm.size == 0 
     puts "#{onlyname} : non trouve"
else
    puts "#{onlyname} : trouve"
    f= File.open(filename)
      tablig =[]
      content = File.readlines(f)
      content.each_with_index do |ligne,i|
          l2 = ligne.force_encoding("UTF-8")
          l2.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
          l2.encode!('UTF-8', 'UTF-16', :invalid => :replace)
          l2.chomp!
          tablig << l2
      end        
    @db['programmes'].update({'programme' =>  onlyname  }, {"$set" => {'source'  =>  tablig}})
 #chargement du jcl 
 
end    
end
=begin
 f= File.open(filename)
 content = File.readlines(f)
 content.each_with_index do |ligne,i|
    l2 = ligne.force_encoding("UTF-8")
    l2.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
    l2.encode!('UTF-8', 'UTF-16', :invalid => :replace)
    l2.chomp!
=end
end