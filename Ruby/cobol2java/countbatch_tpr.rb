require 'json'
require 'pathname'
require 'mongo'
include Mongo
path = ARGV.shift
path+="*"
r_ext = /(.*)\.(\w+)/

@nbb =0
@nbt =0
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
  puts  "#{onlyname} : non trouve"
  next
end 
f= File.open(filename)
content = File.readlines(f)

if pgm[0]['type'] == "TPR" 
     @nbt += content.size
     puts "#{onlyname} : TPR trouve"
else
     @nbb += content.size
     puts "#{onlyname} : batch trouve"
end
end
end
puts @nbb
puts @nbt