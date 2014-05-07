require 'json'
require 'nokogiri' 
filename = ARGV.shift 
datelivraison = ARGV.shift
fichierarchive = ARGV.shift
f = File.open(filename)
doc = Nokogiri::Slop (f)
f.close
result ={}
copy =  doc.document.html.body.children[0]
my_type = copy.children[0].name

if my_type == 'job' then 
   result['fichier'] = fichierarchive 
   result['date'] = datelivraison
   result['job'] = copy.children[0]['id']
   st =[]
   copy.children[0].children.each do |fils|
    if fils.name == 'step' then 
      st << fils['id']
     end
      
   end 
   result['step'] = st
   ts =result.to_json
    puts ts
end
