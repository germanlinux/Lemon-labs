require 'pg'
conn = PGconn.connect(:hostaddr => '127.0.0.1',:port => 5432, :dbname => "sag" , :user => "sag" ,:password => "sag")
##
rest = conn.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'sag' and table_type = 'BASE TABLE'")
puts "Tables;#{rest.count}"

rest.each do |t| 
  table = t['table_name']
     res = conn.exec("SELECT count(*) FROM  #{table}"    )
     puts "#{table};#{res[0]['count']}"   
end
=begin
SELECT 
  columns.column_name, 
  columns.data_type, 
  columns.table_name
FROM 
  information_schema.columns 
WHERE 
  columns.table_name = 'adresse_adre';
=end

