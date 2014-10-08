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
jcl  = @db['JCL'].find(:programme => onlyname).to_a ;

if jcl.size == 0 
     puts "#{onlyname}"
 end
end
end
