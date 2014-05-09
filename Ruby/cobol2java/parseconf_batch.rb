require 'json'
require 'nokogiri' 
require 'pathname'
datelivraison = ARGV.shift
fichierarchive = ARGV.shift
result ={}
result['fichier'] = fichierarchive
result['date'] = datelivraison
result['conf_step'] =[]
result['job']  = []
result['step'] = []
Dir.glob("conf_batch/*.xml").each do |filename| 
  t = Pathname.new(filename)
  @conffile = t.basename  
  f = File.open(filename)
  doc = Nokogiri::Slop (f)
  f.close
  copy =  doc.document.html.body.children[0]
  my_type = copy.children[0].name
  if my_type == 'job' then 
   result['conf_step'] << filename
   result['job'] << copy.children[0]['id']
   st =[]
   copy.children[0].children.each do |fils|
    if fils.name == 'step' then 
      st << fils['id']
    end
   end
   result['step'] << st
  end 
end
ts = result.to_json
puts ts

