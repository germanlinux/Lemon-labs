require 'json'
require 'mongo'
include Mongo
#
## Ce programme recherche une entree dans la base mongodb 
## Pour y ajouter un document pdf
##  1) lecture du fichier du document PDF
##  2) recherche de l'entree pour son nom
##  3) creation d une donnée BSON de type binaire
##  4) MAJ de l'entree
#
prog = ARGV.shift 
filecontent = ARGV.shift
configuration =  ARGV.shift
content = File.read(filecontent)
# connect mongo 
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@pgm =  @db['pgm'].find('nom' => prog).to_a
my_id = @pgm[0]['_id']
puts my_id.inspect
my_entry = @pgm[0]
content_img  = BSON::Binary.new(content)
res = @db['pgm'].update({'_id' => my_id }, {"$set" => {'modele' => content_img, 'conf_step' => configuration}})
