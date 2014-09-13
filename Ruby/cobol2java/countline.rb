jcl =0
total =0
path = ARGV.shift
Dir.glob(path).each do |filename| 
 # t = Pathname.new(filename)
 #filename_t = t.basename
 #t_onlyname = filename_t.to_s.match r_ext
 #if t_onlyname
 #onlyname = t_onlyname[1]
 puts filename
    jcl+=1
      f= File.open(filename)    
      content = File.readlines(f) 
      total+=content.size
end
puts "#{total} ligne de jcl"
puts " pour #{jcl} jcl"
