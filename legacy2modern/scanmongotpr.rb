require 'mongo'
require 'json'
include Mongo
@connect = MongoClient.new('10.153.91.159',27017)
@db= @connect.db('khq')
@tpr = @db['programmes'].find({:type => 'TPR'},{:fields => {:programme => 1, '_id'  => 0}}).to_a
@tpr.each do |p| 
  puts p['programme']

end

