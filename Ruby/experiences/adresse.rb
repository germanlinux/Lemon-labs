#ARGF.each_line do |e|
file = ARGV.shift
content =File.readlines(file)
un = {}
r1 = /'(.+)'/
content.each do |e|
e.chomp!
tab = e.split(',')
next if tab[-2] == ' NULL'
next if tab[-1].match('NULL')
 #puts tab.inspect
t = tab[-2].match r1
debut = t[1]
t = tab[-1].match r1
fin = t[1]
puts debut,fin
end
