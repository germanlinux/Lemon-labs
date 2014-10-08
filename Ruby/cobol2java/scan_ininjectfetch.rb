require 'mongo'
include Mongo
require 'json'
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
## recherche tous les jcl
jcl  = @db['JCL'].find(:type => 'JOB')
jcl.each do |un_jcl| 
     puts un_jcl['programme']
     next unless un_jcl['source']
end
