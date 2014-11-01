#script ruby
require 'date'
#regexp pour calculer le code retour
#reg_retour = /(\d+)/

#commande pour decompresser
com_tar = "tar -xvf "
#commande pour creer un repertoire
com_mkdir = "mkdir"
#nom du repertoire de travail
rep_tmp = "tmpeg"
# option tar complete 
tar_opt = " -C #{rep_tmp}"
#nom du repertoire de collecte
#rep_collecte = "targz_recu"
rep_collecte = "fichiers"

Dir.glob("#{rep_collecte}/*tgz").each do |file|
	puts "#{file} trouve"
    #info sur le fichier


    my_size = File.stat(file).size
    nom_archive  = /\/(.+)/.match(file)[1]


    date_int= Time.now
    epoc_int = date_int.to_i
    df = /(\d+)\.tgz/.match(nom_archive)[1]
    date_nom_file =  Date.strptime(df, '%y%m%d').to_time  
    epoc_journee = date_nom_file.to_i   
	puts "preparation de la decompression"
    output = %x(#{com_mkdir} #{rep_tmp})
    reponse = $?
    raise "erreur dans la creation du repertoire temporaire"  if reponse.exitstatus != 0
    tcom ="#{com_tar} #{file} #{tar_opt}"
    ouput = %x(#{com_tar} #{file} #{tar_opt})
    reponse = $?
    raise "erreur dans la decompression de #{file}"  if reponse.exitstatus != 0   
    # ici les fichiers sont decompresse dans le repertoire temporaire
    #calcul du nombre de fichier du cote Zos et linux
    nbfz = Dir.glob("#{rep_tmp}/file_z/*").size
    nbfx = Dir.glob("#{rep_tmp}/file_x/*").size
    @archive = {:archive => nom_archive, :date => date_int , :epoc => epoc_int, :date_journee => date_nom_file,
        :epoc_journee => epoc_journee, :nb_fichier_z => nbfz , :nb_fichier_x => nbfx }
    # recup_fichier_z
    @listz=[]
    @hashz={}
    puts @archive.inspect
    @poidsX=0
    @poidsZ=0

    puts "explore z files"
    Dir.glob("#{rep_tmp}/file_z/*").each do |file| 
       my_size = File.stat(file).size
       my_content = File.readlines(file)
       nbligne = my_content.size
       nom  = /file_z\/(.+)/.match(file)[1]
       atmp = nom.split('_') 
         ddate= Date.strptime(atmp[0], '%y%m%d').to_time  
         epoc_ddate = date_nom_file.to_i   

       @un_file = {:fichiercomplet => nom, :archive => nom_archive, :size => my_size, :ligne => nbligne, :host => atmp[1], 
            :famille => atmp[2], :chaine =>  atmp[3], :fichier => atmp[4], :occurs =>  atmp[5], :date_journee => date_nom_file,
        :epoc_journee => epoc_journee, :date_passage => ddate, :epoc_passage => epoc_ddate       
        }
       puts @un_file.inspect
       @listz << nom
       @hashz[nom] = @un_file
       @poidsZ += my_size
       
    end 
    puts "explore x files"
@listx = []
@hashx = {}
    Dir.glob("#{rep_tmp}/file_x/*").each do |file| 
       my_size = File.stat(file).size
       my_content = File.readlines(file)
       nbligne = my_content.size
       nom  = /file_x\/(.+)/.match(file)[1]
         atmp = nom.split('_') 
         ddate= Date.strptime(atmp[0], '%y%m%d').to_time  
         epoc_ddate = date_nom_file.to_i   
       @un_file = {:fichiercomplet => nom, :archive => nom_archive, :size => my_size, :ligne => nbligne, :host => atmp[1], 
            :famille => atmp[2], :chaine =>  atmp[3], :fichier => atmp[4], :occurs =>  atmp[5].to_i, :date_journee => date_nom_file,
        :epoc_journee => epoc_journee, :date_passage => ddate, :epoc_passage => epoc_ddate       

        }
       puts @un_file.inspect 
        @listx << nom
       @hashx[nom] = @un_file 
       @poidsX += my_size
       end 
#TODO controle niveau 1
#meme nb de fichier

flag_nbfile = 0
if @listz.size == @listx.size then flag_nbfile = 1 end
#meme fichier
@poidsXabsent=0
@poidsZabsent=0
@poidsZEDIabsent =0
@poidsZCFTabsent =0
@poidsXEDIabsent =0
@poidsXCFTabsent =0

@listXabsent=[]
@listz.each do |nomz| 
    nomx = nomz.sub('_z_','_x_' )
    if !@hashx.has_key?(nomx) 
       @listXabsent << nomx 
       
       @poidsXabsent += @hashz[nomz][:size]
   end
end
puts @listXabsent.inspect
@listZabsent=[]
@listx.each do |nomx|  
    nomz = nomx.sub('_x_','_z_' )
    if !@hashz.has_key?(nomz) 

        @listZabsent << nomz
       @poidsZabsent += @hashx[nomx][:size]

   end

end
puts @listZabsent.inspect
puts @poidsZabsent
puts @poidsXabsent
@archive[:zabsent] = @listZabsent
@archive[:xabsent] = @listXabsent
@archive[:xpoidsabsent] = @poidsXabsent
@archive[:zpoidsabsent] = @poidsZabsent
@archive[:poidsZ] = @poidsZ
@archive[:poidsX] = @poidsX


puts @poidsX + @poidsXabsent
puts @poidsZ + @poidsZabsent




#meme taille

#meme nb de ligne

#TODO controle niveau 2



end	

 