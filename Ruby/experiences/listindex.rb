require 'pg'
conn = PGconn.connect(:hostaddr => '127.0.0.1',:port => 5432, :dbname => "sag" , :user => "sag" ,:password => "sag")
##
filecontent = ARGV.pop
rest = File.readlines(filecontent)
rest.each do |t| 
  table =t.chomp
     res = conn.exec("SELECT count(*) FROM  #{table}"    )
     puts "#{table};#{res[0]['count']}"  if res[0]['count'].to_i > 0 
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

