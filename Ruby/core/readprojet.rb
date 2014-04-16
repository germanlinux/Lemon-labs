$LOAD_PATH << './'
require 'utildate.rb'
require 'json'

def formate_int(chaine)
    if !chaine then 
          chaine = "0"
     end
    return chaine.to_i      
end

filecontent = ARGV.pop
core = File.readlines(filecontent)
core.each_with_index do |ligne,i|
    ligne.chomp! 
    next if i  == 0
    next if i  == 1
    table = ligne.split(';')
    t = Hash.new 
    t[:projet] = table[0]
    t[:domaine] =  table[5]
    if t[:domaine]=~ /Domaine/ then 
         t[:section] = 'DEP'
         else
         t[:section] = 'DOM'
     end    
          
    t[:date] =  table[12]
    if @chaine_date == nil then 
        @chaine_date   = Util_date.new(t[:date])
    end
    t[:semaine] =  @chaine_date.semaine
    t[:Vc] =  formate_int table[13]
    t[:Vr] =  formate_int table[14]
    t[:Vp] = formate_int  table[15]
    t[:VTotal] = formate_int  table[16]
    t[:Pc] =  formate_int table[24]
    t[:Pr] =  formate_int table[25]
    t[:Pp] =  formate_int table[26]
    t[:PTotal] = formate_int  table[27]
    t[:Rc] = formate_int  table[35]
    t[:Rr] = formate_int  table[36]
    t[:Rp] =  formate_int table[37]
    t[:RTotal] = formate_int  table[38]
    puts t.to_json  if t[:date]    
end
