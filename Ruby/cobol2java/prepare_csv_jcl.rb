require 'json'
require 'mongo'
require 'date'
#require 'CSV'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
@opc  = @db['JCL'].find({:type => 'JOB'}).to_a
@opc.each do |une_appli|
    
    mydate = DateTime.strptime(une_appli['epoc'].to_s,"%s")
    strdate = mydate.strftime("%d/%m/%Y")
     taille = 0
     taille = une_appli['applications'].size  if une_appli['applications']
    puts "#{une_appli['programme']};#{taille};#{une_appli['SQL']};#{strdate}"
end
