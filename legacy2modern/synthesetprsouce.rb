 file = ARGV.shift
 f = File.open(file)
 regfile = /PROGRAM\((.+?)\)/
 content = File.readlines(f)
 content.each do |ligne|
 ligne.chomp!

 #    tscan = ligne.match regfile
 #    puts tscan[1]  if tscan

 if File.exist?("SOURCES khq/COBOL/#{ligne}.COB") 
    puts "#{ligne};1"
 else
    puts "#{ligne};0"
 end
end

