require 'json'
require './libsource'
filecontent = ARGV.pop
enveloppe = File.read(filecontent)
#puts enveloppe
t_env  =JSON.parse(enveloppe)
rep = t_env['lib']
metadonnee =[]
files = t_env['contents']
pdtotal = pdactive =0
programme = grille = 0
files.each do |f|
    nf = rep + f    
    tnf =File.expand_path(nf)
    source = Source.new(rep,f)
    source.lire_amorce
    source.find_type
    source.compte
    source.batch_tpr
 #   source.procedure_division 

 #   if source.type =="programme" then 
 #         pdtotal += source.prodivtotal
 #         pdactive += source.prodivactive
 #   end
    metadonnee << source.to_hash
end
t = JSON.pretty_generate(:lib => rep , :contents => files, :metadonnees => metadonnee) 
#puts pdtotal,pdactive
puts t
