cp = 1 
loop do 
$stdout.puts "boucle num #{cp}"
sleep(1) 
if cp.remainder(10) == 0  then
    $stderr.puts "erreur num #{cp}"
end 
cp+=1
end
