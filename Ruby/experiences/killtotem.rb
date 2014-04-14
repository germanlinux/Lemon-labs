#!/usr/bin/ruby
# ce programme tue le lecteur media player: a utiliser en cas de blocage
output = `ps ax|grep totem`
output.split("\n").each do |line|
r1 = /^\s(\d+)/
if (line =~ /\d\d\stotem/ ) then 
   pid  = line.match r1
    p = pid[1]
    k = `kill #{p}` 
end

end