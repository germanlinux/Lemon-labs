head = require('./../header.js')
puts = console.log

headers =  
         'host' : 'localhost:8080'
         'foo' : 'bar'
         'cookie': 'lemonode=123f56'

headers2 =  
         'host' : 'localhost'
         'foo' : 'bar'


test="eclatement entete host port 1" 
puts "test " + test
HP = head.getHostPort(headers )
if  HP['host'] == 'localhost'  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP['host']} <=> 'localhost' "
puts "--------------------------------------------------------------------"

if  HP['port'] == '8080'  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP['port']} <=> 8080 "
puts "--------------------------------------------------------------------"

test="eclatement entete host port 2" 
puts "test " + test
HP = head.getHostPort(headers2 )
if  HP['host'] == 'localhost'  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP['host']} <=> 'localhost' "
puts "--------------------------------------------------------------------"

if  HP['port'] == 80  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP['port']} <=> 80 "
puts "--------------------------------------------------------------------"


HP= head.cloneHeaders(headers2,'replace:8080')  
test="clone header" 
puts "test " + test
if  HP['host'] == 'replace:8080'  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP['host']} <=> 'replace' "
puts "--------------------------------------------------------------------"

test="recuperation cookie dans l entete" 
puts "test " + test
HP = head.getCookie(headers,'lemonode' )
if  HP == '123f56'  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP} <=> '123f56' "
puts "--------------------------------------------------------------------"

test="absence cookie dans l entete" 
puts "test " + test
HP = head.getCookie(headers2,'lemonode' )
if  HP != '123f56'  
  puts "#{test} :OK" 
else 
  puts "#{test} :FAILED !!!!! => #{HP} <=> '123f56' "
puts "--------------------------------------------------------------------"

