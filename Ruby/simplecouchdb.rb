#!/usr/bin/ruby
require 'rubygems'
require "getopt/std"
require 'couchdb'
require 'uri'
require 'json' 

opt = Getopt::Std.getopts("f:r:m:")

if opt["f"] then 
	puts "file.js: #{opt["f"]}"
	file=opt["f"] 
#  else 
#     puts "-f (file js) option is required, format -f myjson.js"
end  
if opt["r"] then 
	puts "ressource couchdb: #{opt["r"]}"
	res =opt["r"]
else 
	puts "-r (ressource couchdb ) option is required , format -r http://couchdbserver:port/foobar"

end
if opt["m"] then 
	puts "method http : #{opt["m"]}"
else 
	puts "-m (method http ) option is required , format -m GET|POST|PUT|AUTO"

end
### 
uri= URI.parse(res)
host= uri.host
port= uri.port
path = uri.path
cible= CouchDB::Server.new(host,port) 
tableau =path.split('/') 
if !file and tableau.length > 2 then
	file= tableau[-1]+ '.js'
end  
if opt["m"] == 'GET'  then 
	if !file then
		puts  "! error : file must be specified"  
		exit 
	end 
	load  =   cible.get(path)
       
        if load.code == "200" then 
              puts "#{file} OK" 
             File.open(file, 'w') do |f|
	     f.puts load.body
	     end
        else 
          puts "ERROR: #{file}"   
        end 
else 
   if opt["m"] == 'AUTO' then 
#  up inital rev 
        	if !file then
		puts  "! error : file must be specified"  
		exit 
	end 

        load  =   cible.get(path)
	 document= JSON.parse(load.body)
         myrev= document['_rev'] 
    mytab=  File.readlines(file)
    js= JSON(mytab[0]) 
    oldrev= js['_rev']  
   if oldrev != myrev then 
       js['_rev'] = myrev  
       sortie= JSON(js).to_str
       mytab[0]= sortie
    #rewrite file 
      File.open(file, 'w') do |f|
		f.puts sortie
	end

   end
# send file too couchdb 
   load  =   cible.put(path,mytab[0])
   response= JSON.parse(load.body)
    if response["ok"] == true then 
          puts "OK: #{response['rev']}" 
    else 
          puts "ERROR" 
    end
    
end
end
