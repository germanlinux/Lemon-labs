import sys
import re
flog = sys.argv[1]
haship ={}
flone = sys.argv[2]
with open(flone) as  initial: 
    for line in initial:
      line = line[:-1]
      haship[line] = 1
with open(flog) as infile:
    for line in infile:
       aa=re.match(r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}",line)
       if aa:
         ip = aa.group()
         print(ip)
         if ip not in haship: 
             haship[ip] =1
for ip in haship:
     print(ip)
print(len(haship))

