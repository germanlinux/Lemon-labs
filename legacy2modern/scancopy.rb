regnom = /\/.+\/(.+?).COB/
recopy  = /\ COPY +(.+?)[\.| ]/  
h_copy = {}
file = ARGV.shift
f = File.open(file)
content1 = File.readlines(f)
content1.each do |l|
             next if l.match /DISPLAY/
             next if l.match '\*'
            tmap = l.match recopy
             if tmap  
                h_copy[tmap[1]] = 1
              end
end
h_copy.keys.each do |k| 
    puts k 
end
