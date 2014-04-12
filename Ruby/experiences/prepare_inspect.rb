require 'pg'
conn = PGconn.connect(:hostaddr => '127.0.0.1',:port => 5432, :dbname => "sag" , :user => "sag" ,:password => "sag")
##
filecontent = ARGV.pop
rest = File.readlines(filecontent)
rest.each do |t| 
    t.chomp!
  table =t.split(';')
  nt = table[0]
     res = conn.exec("SELECT #{table[2]},#{table[3]},#{table[4]} FROM #{nt}  ORDER BY #{table[3]},#{table[4]} ;")

     res.each do |line| 
        a  = line[table[2]]
        b  = line[table[3]]
        c  = line[table[4]]
        
        puts "#{nt};#{a};#{b};#{c}"

    end

end
