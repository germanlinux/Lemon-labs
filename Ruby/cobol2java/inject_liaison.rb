## ce programme injecte les liaison pgm / jcl/fichier 
require 'mongo'
require 'json'
include Mongo
file = ARGV.shift
content= File.readlines(file)

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye')
content.each do |p|
    p.chomp!
   ts =JSON.parse(p)
    puts ts
   res = @db['liaisons'].insert(ts)
end

