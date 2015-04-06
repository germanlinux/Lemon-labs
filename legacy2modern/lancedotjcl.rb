fileJCL = ARGV.shift
f = File.open(fileJCL)
content = File.readlines(f)
content.each  do |i|
    i.chomp!
    puts i
	ligne =  "ruby scanjcl.rb SOURCES-khq/MVS/#{i}.JCL dot > #{i}.dot"
    `#{ligne}` 	
    ligne = "ruby scanjclsuite.rb #{i}.dot"
    `#{ligne}`	
 end
