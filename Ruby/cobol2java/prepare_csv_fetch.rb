require 'json'
require 'mongo'
require 'date'
#require 'CSV'
include Mongo

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
@opc  = @db['JCL'].find({:type => 'FETCH'}).to_a
@opc.each do |une_appli|
    
    mydate = DateTime.strptime(une_appli['epoc'].to_s,"%s")
    strdate = mydate.strftime("%d/%m/%Y")

    puts "#{une_appli['programme']};#{une_appli['SQL']};#{strdate}"
end
