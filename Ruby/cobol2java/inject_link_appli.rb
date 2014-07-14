require 'json'
require 'mongo'
include Mongo


def combinaison(tab)
    if tab.size == 2 
        return [[tab[0], tab[1] ]]
    else 
      a = tab.shift
      tmp = [] 
      tab.each do |b|
        tmp << [a, b] 
      end
      return  tmp  + combinaison(tab)
    end 
 end


hf = {}

@connect = MongoClient.new("localhost",27017) 
@db = @connect.db('paye2')
@fetch = @db['entites'].group(
  :key => ['nom'], 
  :initial => {appli:[]},
  :reduce => "function(obj,res){ if (res.appli.indexOf(obj['appli']) < 0 ) {  res.appli.push(obj['appli']); }  } " ,
  :cond =>  { :_type  => 'fetch'},
  ).to_a

#puts @fetch.size

@fetch.each do |f|
  if f['appli'].size > 1 
     tab_appli = f['appli'].sort
     puts tab_appli.inspect
     result = combinaison(tab_appli)
     puts result.inspect
     result.each do |t| 
      tx = {:appl1 => t[0], :appl2 => t[1] , :_type => 'a_b' }
      
      puts tx
      res = @db['liaisons'].insert(tx)
     end    
  end
end

     
