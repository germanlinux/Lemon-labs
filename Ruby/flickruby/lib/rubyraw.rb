require 'rubygems'
require 'flickraw'
require 'yaml'
require 'set_p'

### load yaml ###
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
puts res.inspect
#puts res.size

# Pour chaque set
tab_of_sets = Array.new
res.each do |un_set|
    tab_of_sets << Set.new(un_set['title'],un_set['id'],un_set['secret'],un_set['photos'])     
end 
Set.catalogue(tab_of_sets)


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
        Set.photos(tab_of_photo)
     end

# creation de la liste des sets et des photos


