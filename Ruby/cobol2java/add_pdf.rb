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
pjcl = ARGV.shift 
filecontent = ARGV.shift
content = File.read(filecontent)
# connect mongo 
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('vfp')
@jcl =  @db['jcl'].find('jcl' => pjcl).to_a
my_id = @jcl[0]['_id']
puts my_id.inspect
my_entry = @jcl[0]
content_pdf  = BSON::Binary.new(content)
res = @db['jcl'].update({'_id' => my_id }, {"$set" => {'pdf' => content_pdf, 'pdf_file' => filecontent}})
