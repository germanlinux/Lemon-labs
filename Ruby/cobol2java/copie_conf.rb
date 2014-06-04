Dir.glob("*/").each do |filename| 
#  c est un réperoire *
puts filename    
 Dir.glob("#{filename}*xml").each do |filenameconf|
   `cp #{filenameconf}  /home/german/local/tmp` 
puts  "copy de  #{filenameconf}"  
 end
end

 
