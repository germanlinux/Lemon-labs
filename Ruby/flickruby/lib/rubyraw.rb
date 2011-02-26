require 'rubygems'
require 'flickraw'
require 'yaml'
require 'set_p'

### load yaml ###
path= ARGV[0]
flicklite_config= YAML::load(File.open('flicklite.conf'))
puts flicklite_config.inspect
FlickRaw.api_key =flicklite_config['api-key']
FlickRaw.shared_secret =flicklite_config['api-secret']
frob= flickr.auth.getFrob
puts "frob => #{frob}"
auth_url = FlickRaw.auth_url :frob => frob,:perms => 'read'
browser =flicklite_config['browser']
system(browser,"#{auth_url}")
puts "Press Enter when you are finished."
STDIN.getc
puts "ok"
flickr.auth.getToken :frob => frob
login = flickr.test.login
puts login.username
puts login.id
### recuperation des sets ###
res = flickr.photosets.getList
#puts res.inspect
#puts res.size

# Pour chaque set
tab_of_sets = Array.new
res.each do |un_set|
   tab_of_sets << Set.new(un_set['title'],un_set['id'],un_set['secret'],un_set['photos'])
end
Set.catalogue(tab_of_sets,path)


#puts tab_of_sets.inspect

#File.open('sets.yaml','w') do |out|
#    out.write(tab_of_sets.to_yaml
#    end

### recuperation des noms de  photos  ###
# stockage des photos sous la forme /flicklite/nomduset_photo.jpeg
tab_of_sets.each do |un_set|
   ### recuperer les noms des photos
   lesp=  flickr.photosets.getPhotos :photoset_id => un_set.id
   #puts lesp.inspect
   tab_of_photo = Array.new
   lesp["photo"].each do |une_photo|
      tab_of_photo << Set.new(une_photo['title'],un_set.id+"_"+une_photo['id'],une_photo['secret'],0)
   end
   Set.photos(tab_of_photo,path)
end
### ouvrir le fichier tmp
catalogue_photo= YAML::load(File.open("#{path}/photos.yaml"))

puts "loading"
### lire un article
## instancer un objet:
table_picture_of = Array.new
catalogue_photo.each do |key,value|
   puts value
   my_idset,my_idphoto= key.split('_')

   res=  flickr.photos.getInfo :photo_id => my_idphoto , :secret => value['secret']
   originalsecret= res['originalsecret']
   originalformat= res['originalformat']
   farm= res['farm']
   server=res['server']

   table_picture_of << Photo.new( my_idphoto, originalsecret,value['title'],originalformat, farm,server,my_idset)

end
puts "chargement des informations terminées"
puts "#{table_picture_of.size}  photos lues"


File.open("#{path}/url.yaml",'w') do |out|
   table_picture_of.each do |une_photo|
      out.write(une_photo.to_s)
   end
end

puts "traitement terminé"






