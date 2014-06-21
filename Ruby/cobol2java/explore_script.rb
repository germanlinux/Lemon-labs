file = ARGV.shift
content = File.readlines(file)
h_nom={}
content.each do |ligne|
   ligne.chomp! 
  tab = ligne.split('/')
  nom_script = tab[-1]
  h_nom[nom_script] = 1 
  pgm = tab[-3]
  script =  File.readlines(ligne)
  taille = script.size
  h_nom[nom_script] = taille 
  
  libelle ="TODO"
  script1 =""
  if taille  == 1 then libelle  = "VIDE"
   elsif  script[1]=~ /^rm/       then libelle ="suppression de fichier"   
   elsif script[1]=~ /^sort/     then libelle ="Tri fichier simple"     
   elsif script[1]=~ /^\\cp/     then libelle ="copie de fichier"     
   elsif script[1]=~ /^cat.+sort/     then libelle ="Tri fichier enchaine"     
   elsif script[1]=~ /EBCD/     then libelle ="Transformation EBCDIC"     
   elsif script[1]=~ /^>/     then libelle ="Redirection"     
   elsif script[1]=~ /^cut.+SEP/     then libelle ="Mise au format CSV"     
   elsif script[1]=~ /gawk.+sort/     then libelle ="Transformation et tri"     
   elsif script[1]=~ /gawk/           then libelle ="Transformation T1" 
   elsif script[1]=~ /export/           then libelle ="Copie de fichier" 
   elsif script[1]=~ /cut/           then libelle ="fichier tronqué" 
   elsif script[1]=~ /^awk/           then libelle ="Transformation T2" 
   elsif script[1]=~ /^sed.+sort/        then libelle ="Substitution et transformation" 
   elsif taille > 5 then libelle ="script complexe d eclatement et de Transformation"
   else script1 = script
   end
  puts "#{pgm};#{nom_script};#{libelle}"
  
end
h_nom.keys.each do |k|
if     h_nom[k] == 1 then libelle = "vide" 
else 
    libelle = "ecrit"
end    
puts "#{k};#{libelle}"
end


   
