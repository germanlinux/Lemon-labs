require 'pg'
filecontent = ARGV.pop
content = File.readlines(filecontent)

conn = PGconn.connect(:hostaddr => '127.0.0.1',:port => 5432, :dbname => "sag" , :user => "sag" ,:password => "sag")
##
ordre = []
ordre= %w(
          compte_cpte
          miseenpaiementdepense_mpdp
          dette_dett
          tiersassocie_tias
          operationcomptable_opco
          dossier_dosi 
          donneessagis_donn  
          decision_deci
          bilansuccession_bisu 
          decision_deci 
          equipe_equi 
          exercicecomptable_exco 
          utilisateurdunpole_util  
          tiers_tier 
          entitejuridique_entj
          pole_pole   
          referentiel_refe 
          adresse_adre)
h_ordre = {}
ordre.each do |item| 
    h_ordre[item] = 1 
end
banal= []

content.each do |mt|
    t = mt.split(';')
    if t[0] == "topadcommune_toco" or t[0] == "topadvoie_tovo"  then 
        puts "#{t[0]} non supprimee"
    else

        banal << t[0] if !h_ordre[t[0]]
    end    
end

banal.each do |item| 
     begin
      puts item.inspect
     rest = conn.exec("DELETE  FROM #{item}")
     #puts "#{item} supprimee"
     rescue
       puts "erreur sur #{item}"  
     end  
end
puts "table liees"
ordre.each do |item| 
     begin
      puts item.inspect
      rest = conn.exec("DELETE  FROM #{item}")
     #puts "#{item} supprimee"
     rescue
       puts "erreur sur #{item}"  
     end  
end
    

#rest = conn.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'sag' and table_type = 'BASE TABLE'")
#puts "Tables;#{rest.count}"

#rest.each do |t| 
#  table = t['table_name']
#     res = conn.exec("SELECT count(*) FROM  #{table}"    )
#     puts "#{table};#{res[0]['count']}"   
#end
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
#
#erreur sur adresse_adre
#erreur sur bilansuccession_bisu
#erreur sur compte_cpte
#erreur sur decision_deci
#erreur sur dossier_dosi
#erreur sur entitejuridique_entj
#erreur sur equipe_equi
#erreur sur exercicecomptable_exco
#erreur sur pole_pole
#erreur sur referentiel_refe
#erreur sur tiers_tier
#erreur sur utilisateurdunpole_util


#erreur sur adresse_adre
#erreur sur bilansuccession_bisu
#erreur sur decision_deci
#erreur sur entitejuridique_entj
#erreur sur pole_pole
#erreur sur referentiel_refe


#erreur sur adresse_adre


