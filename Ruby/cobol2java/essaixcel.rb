file = ARGV.shift
nb_header = ARGV.shift || 0 
content= File.readlines(file)
content.each_with_index do |p,cp|
   p.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
   p.encode!('UTF-8', 'UTF-16', :invalid => :replace)
 @tab = p.split("\t")
 puts @tab.size
 puts @tab.inspect
 puts cp 
 
end
