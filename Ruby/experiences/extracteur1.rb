require 'json'
class Ligne
     attr :rangs
     def initialize(array_of_field)
        @letter = array_of_field
        trf 
     end
     def trf 
      @rangs = []
      @letter.each do |une_lettre_ou_deux|
           une_lettre_ou_deux.upcase!
           tmp_rang = une_lettre_ou_deux[0].ord - 65
           if une_lettre_ou_deux[1] then 
               tmp_rang = tmp_rang + 26 + une_lettre_ou_deux[1].ord - 65
           end    
           @rangs << tmp_rang
        end
      end      
end
 @ligne_projet =  [ "ligne","projet",'Libelle',"Structure MOE Principale",'Secteur',
                    "Structure MOA Principale",'',"chantier",'description','type',"axe",
                    "status","Structures MOA","Structures MOE",
                    "decision","COPSI",'','',
                    "centrale%valide","MOED%valide",
                    "AMOE%valide","total MOE%valide",
                    "Charge Interne Valide","Assistance MOA Valide",
                    "Charges Structure MOA Valide","Dont Assistance MOA Valide",
                    "AMOE%valide","Dont Acquisition matériels et logiciels Valide",
                    "BUDGET%valide","centrale%planifie",
                    "MOED%Planifie","AMOE%Planifie",
                    "Total MOE%Planifie","Dont Charge Interne Planifie",
                    "Dont Assistance MOA Planifie","Charges Structure MOA Planifie",
                    "Dont Assistance MOA Planifie","Assistance MOE Planifie",
                    "Dont Acquisition matériels et logiciels Planifie","BUDGET%Planifie",
                    "Centrale%Reel","MOED%Reel","AMOE%Reel",
                    "Total MOE%Reel","Charge Interne Réel","Dont Assistance MOA Réel",
                    "Charges Structure MOA Réel","Dont Assistance MOA Réel","AMOE%Reel",
                    "Dont Acquisition matériels et logiciels Réel","BUDGET%Reel"  ]
@ligne_a_conserver = %w[a b c e h i j k l o s t u v ac ad ae af ag an ao ap aq ar ay]
@ligne_format      = %w[s s s s s s s s s s i i i i i   i  i  i  i  i  i  i  i  i i ]  
tmp_e =  Ligne.new @ligne_a_conserver
tmp_e.rangs.each { |e| @ligne_projet[e].downcase!  }
@content =[]
fcore = ARGV.pop
semaine = ARGV.pop.to_i
File.open(fcore, 'r:windows-1252:UTF-8') do |f1|
  @content = f1.readlines
end
@content.shift
@content.shift
@content.each do |e| 
    e.gsub!(/(\d+),(\d+)/,'\1.\2')
    e.gsub!(/\n/,'')
   
    
    m_e = e.split(/,/)
    h_sortie = {} 
    a_sortie = tmp_e.rangs.collect {|i| m_e[i]  }
    a_sortie.each_index {|i|
    if  @ligne_format[i] == 'i'  then 
            a_sortie[i]  = '0' if a_sortie[i].empty?
            a_sortie[i].gsub!(/\./,',')
            a_sortie[i].gsub!(/"/,'')
            t = a_sortie[i].to_f
            a_sortie[i] = t
        else 
          # puts a_sortie[i].inspect 
           a_sortie[i].gsub!(/"/,'')
        end    
    h_sortie[@ligne_projet[tmp_e.rangs[i]]] = a_sortie[i]
  }
    h_formate = {}
    h_sortie.each_key {|k| 
           rsub = /(.+)%(.+)/  
         
       if   k =~ /%/
             com =  rsub.match k
             gauche = com[1]
             droite = com[2]
             tmp_h= {}
             tmp_h = h_formate[droite] ||{}
             tmp_h[gauche] = h_sortie[k]
              h_formate[droite] = tmp_h 
             else
         h_formate[k] = h_sortie[k]
             end
    } 
    h_formate[:semaine] = semaine
    t = JSON.generate(h_formate)
    puts t
    end
