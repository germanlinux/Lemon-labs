sns = ARGV.shift
monarchive = ARGV.shift
liste_ref  = ARGV.shift
my_cr = monarchive + "/README_mapset.TXT"

`rm  #{monarchive}/MAPSET/*BMS`
`rmdir  #{monarchive}/BMS`


`mkdir #{monarchive}/BMS`

File.open(my_cr,'w') do |file| 
  DATA.each do |line|
     file.write line
  end
  file.write "sns: #{sns}\n"
  file.write "archive: #{monarchive}\n"
  file.write "liste: #{liste_ref}\n"
 end


h_def = {}
content = File.readlines(liste_ref)
#content.pop
content.each do |i| 
 	i.chomp!
 	   h_def[i] = []
 end
puts "Nb de mapset a ecrire: #{h_def.keys.size}"
h_def.keys.each do |k|
	nomfichier = k + '.BMS'
	cheminorig =  "#{sns}/BMSCOB/#{nomfichier}"
    cible = "#{monarchive}/BMS/#{nomfichier}"
     `cp \"#{cheminorig}\"  #{cible}`
end    
__END__
# constitution d une archive en vue de moderniser une appplication
# 1: creer un repertoire qui abritera l archive (ex mkdir cobol)
# 2: recuperer et decompresse une archive du sns ou d un type identique
# 3: lancer le programme avec les parametres:   repertoire_sns mon_repertoire_archive le_fichier_liste_des_pgm
