## ce programme injecte les liaison pgm / jcl/fichier 
require 'mongo'
require 'json'
require 'date'
include Mongo
file = ARGV.shift
nb_header = shift || 0 
content= File.readlines(file)
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
r_comm  = /^\*/ 
@tabgen=[] 
content.each_with_index do |p,cp| 
    p.chomp!
   next if cp < nb_header 
   p.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
   p.encode!('UTF-8', 'UTF-16', :invalid => :replace)
    @tab = p.split(';')
    if @tab.size == 1 
        # ligne simple
        @tabgen[2] << @tab[0] 
    elsif @tab.size == 3
        @tabgen = @tab
    elsif @tab.size == 4
        @tabgen = @tab
        mydate = Date.strptime(@tabgen[3],"%Y/%m/%d")
        _utc =  Time.utc(mydate.year, mydate.month, mydate.day)
        data = {:programme => @tabgen[0], :type => 'pgm_batch' , :commentaires => @tabgen[2], :date => _utc  }
       # puts data.inspect 
        res = @db['programmes'].insert(data)
    else
        @tabgen[2]<< @tab[0]
        @tabgen[3] = @tab[1]   
        mydate = Date.strptime(@tabgen[3],"%Y/%m/%d")
        _utc =  Time.utc(mydate.year, mydate.month, mydate.day)   
data = {:programme => @tabgen[0], :type => 'pgm_batch' , :commentaires => @tabgen[2], :date => _utc  }
        res = @db['programmes'].insert(data)
    end 
end

