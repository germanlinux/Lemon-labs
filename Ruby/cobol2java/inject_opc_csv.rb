require 'mongo'
require 'json'
require 'date'
include Mongo
filtre = [1 , 2 ,6]
file = ARGV.shift
stype = ARGV.shift
# pgm_batch
nb_header = ARGV.shift || 0
 nb_header_i = nb_header.to_i
content= File.readlines(file)
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
r_comm  = /^\*/ 
date_int= Time.now
epoc_int = date_int.to_i
content.each_with_index do |p,cp| 
    p.chomp!
   next if cp < nb_header_i 
   p.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
   p.encode!('UTF-8', 'UTF-16', :invalid => :replace)
    @tab = p.split(/\t/)
    filtre.each do |i|  
      @tab[i].gsub!(/"/,'' )
    end
   mydate = Date.strptime(@tab[6],"%d/%m/%y")
  _utc =  Time.utc(mydate.year, mydate.month, mydate.day)
  epoc = _utc.to_i 
  data = {:programme => @tab[1],:type => stype ,:libelle => @tab[2] ,:date => _utc, :epoc => epoc, :date_int => epoc_int   }
        puts data.inspect 
        res = @db['OPC'].insert(data)

end

