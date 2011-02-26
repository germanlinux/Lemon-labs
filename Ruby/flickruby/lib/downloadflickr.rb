#!/usr/bin/ruby
require 'rubygems'
require 'yaml'
require 'net/http'
require 'thread'
require 'uri'
### charger les données dans une liste d objet
tmpdir= ARGV[0]
hash_url_of = YAML::load File.open("#{tmpdir}/url.yaml")
hash_thread = Hash.new
mes_threads =[]
### boucle infinie 
cp =1     #comtpeur de cycle
cpfile=0  #compteur de fichier
input_queue=true
while (input_queue) do 
    input_queue=true
    hash_url_of.each do |key,value|
        if hash_thread.has_key?(key) then 
            # la photo est telechargée ou en cours de telechargment par ce programme
            next
         end
         # construire le nom du fichier
         nomcomplet = tmpdir + "/#{value['set']}_#{key}"          
         next if File.exist?(nomcomplet) #la photo existe deja 
         next if mes_threads.size > 9 # deja 10 threads lances
         ##  ok le thread est a creer
         hash_thread[key] = 1 
         ### 
         my_t= Thread.new(value["url"],nomcomplet) do |urlt,nom|
           url = URI.parse(urlt)
         puts "download #{urlt}"
         res  = Net::HTTP.get_response url
         File.open(nom, "w") {|f| f << res.body }    
         end
         if my_t.nil? then 
             puts "Erreur creation thread sur #{url}"
             puts "reprogrammationen sur le prochain cycle"
             hash_thread.delete[key]
             else
                 cpfile+=1
                 mes_threads << my_t
         end
         
         ###
         
     end
     ## on verifie l'état des threads 
     ## si tous sont en cours on patiente 
     input_queue = false  if mes_threads.size== 0 ## cycle vide on arrete tout
     mes_threads.each do  |t| 
          puts t.status 
      end
      mes_threads.delete_if {|t| t.status == false }
      cpx= mes_threads.size
  puts "cycle en cours: #{cp} queue: #{cpx}  cumul: #{cpfile}"
      sleep 10
      cp += 1
end
puts "Terminé en #{cp-1}  cycles pour #{cpfile}"


