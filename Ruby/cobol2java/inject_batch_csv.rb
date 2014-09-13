## ce programme injecte les liaison pgm / jcl/fichier 
require 'mongo'
require 'json'
require 'date'
include Mongo
file = ARGV.shift
stype = ARGV.shift
# pgm_batch
nb_header = ARGV.shift || 0
 nb_header_i = nb_header.to_i
content= File.readlines(file)
@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('khq')
r_comm  = /^\*/ 
@tabgen=[] 
date_int= Time.now
epoc_int = date_int.to_i
content.each_with_index do |p,cp| 
    p.chomp!
   next if cp < nb_header_i 
   p.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
   p.encode!('UTF-8', 'UTF-16', :invalid => :replace)
    @tab = p.split(/\t/)
    puts @tab.size
    if @tab.size == 1 
        # ligne simple commentaire
        @tabgen[2] << @tab[0] + "\n"  
    elsif @tab.size == 3
        @tabgen = @tab
        @tabgen[0].gsub!(/"/,'')
        @tabgen[2]<< "\n"
    elsif @tab.size == 4
          @tabgen = @tab
          @tabgen[0].gsub!(/"/,'' )
          @tabgen[2].gsub!(/"/,'' )
          @tabgen[3].gsub!(/"/,'' )
        mydate = Date.strptime(@tabgen[3],"%Y/%m/%d")
        _utc =  Time.utc(mydate.year, mydate.month, mydate.day)
         epoc = _utc.to_i 
        data = {:programme => @tabgen[0], :type => stype , :commentaires => @tabgen[2], :date => _utc, :epoc => epoc, :date_int => epoc_int   }
       # puts data.inspect 
        res = @db['programmes'].insert(data)
    else
        @tabgen[2]<< @tab[0] + "\n"
        @tabgen[3] = @tab[1] 
          @tabgen[0].gsub!(/"/,'' )
          @tabgen[2].gsub!(/"/,'' )
        @tabgen[3].gsub!(/"/,'' )
         mydate = Date.strptime(@tabgen[3],"%Y/%m/%d")
        _utc =  Time.utc(mydate.year, mydate.month, mydate.day) 
        epoc = _utc.to_i        
        data = {:programme => @tabgen[0], :type =>  stype, :commentaires => @tabgen[2], :date => _utc, :epoc => epoc , :date_int => epoc_int  }
        res = @db['programmes'].insert(data)
    end 
end

