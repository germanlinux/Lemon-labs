require 'json'
filecontent = ARGV.pop
content = File.readlines(filecontent)
herreur= {}
content.each do |mt|
#item = JSON.pretty_generate(mt)
#    puts item
    ts =JSON.parse(mt)
cle = ts['table'] + ts['cle'] + ts['id_value']
next if herreur.has_key?(cle)
puts "\n\n#{ts['table']} -- #{ts['cle']}--  #{ts['id_value']} "
herreur[cle] = 1
output = `grep "#{ts['lgrep']}" *sql`
output.split("\n").each do |line|

puts "---------------------------------------------------------------------------------------------------"
    puts line
puts "---------------------------------------------------------------------------------------------------"

end

end
puts herreur.size
