##  cas primaire
require 'json'
def cas_general (filename, owner, node)
    ch ={} 
    ch[:node] =[]
    ch[:owner] = owner
    owner =nil
    ch_ent = {}
    owner ||= node.attr('name')
    owner ||= node.attr('cobolrecordname') 

    node.keys.each do |t|
        ch_ent[t.to_sym] = ch[t.to_sym] = node.attr(t)  if !node.attr(t).empty? 

    end
    ch_ent[:name] =  ch[:name] = node.attr('cobolrecordname') if !ch[:name]  
    if node.children.size > 0  then
              ch_ent[:nature] = ch[:nature] = 'groupe'
              node.children.each do |n|  
                ch[:node] << cas_general(filename,owner,n)
              end
              else
              ch_ent[:nature] =ch[:nature] = 'simple'  
              ch.delete(:node)   
    end   
    ch_ent[:filename] = filename  
    puts filename
    ch_ent[:size] =ch_ent[:size].to_i if ch_ent.has_key?(:size)
    ch_ent[:decimal] =ch_ent[:decimal].to_i if ch_ent.has_key?(:decimal)
    ch_ent[:occurs] =ch_ent[:occurs].to_i if ch_ent.has_key?(:occurs)
    ch_ent.keys.each do |t| 
       ch_ent[t] = false  if ch_ent[t] == 'false'
       ch_ent[t] = true  if ch_ent[t] == 'true'
    end   
    ts =ch_ent.to_json
    puts ts

  return ch
end

###

require 'nokogiri' 
Dir.glob("copybooks/*.xml").each do |filename| 
 f= File.open(filename)
 doc = Nokogiri::Slop (f)
 f.close
 copy =  doc.document.html.body.children.children[0]
### le premier niveau est traite particuliairement
 ch = {}
 ch[:node]=[]
 ch[:node] <<  cas_general(filename, 'root',copy)
end 
