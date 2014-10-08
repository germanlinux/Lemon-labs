require 'json'
require 'mongo'
include Mongo
r_ext = /(.*)\.(\w+)/
#@connect = MongoClient.new("localhost",27017) 
@connect = MongoClient.new("10.153.91.159", 27017) 
@db = @connect.db('khq')
## recherche appl 
appli   = @db['OPC'].group(:key => 'appli',:cond => {type: 'STEP'},
                      :initial => {ordre:[], step:[]},
                      :reduce => "function(cur,result) {result.ordre.push(cur.rang);result.step.push(cur.label)}" 
    ).to_a
 puts "eric" 
 appli.each do |une_chaine|
  @lessuites = []
  hash_nom_rang ={}
  tmp_tab_rang = une_chaine['ordre'] 
  tmp_tab_rang.each_with_index do |data, i|
      hash_nom_rang[data] = i
  end      
  tmp_tab_rang.sort!
  tmp_tab_rang.each do |ordre|
      next if ordre=~ /ENC|TOP/
      index= hash_nom_rang[ordre]
      jcl_h = une_chaine['step'][index] 

## recherche jcl =
      rjcl =@db['JCL'].find({:programme => jcl_h}).to_a
       jcl_h += '*' if rjcl.size != 1 
      @lessuites << jcl_h
# puts ordre

 end   
 puts @lessuites.inspect
  puts 'eric'
@db['OPC'].update({'programme' =>  une_chaine['appli']  }, {"$set" => {'enchainement' => @lessuites}})    
end

