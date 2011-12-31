import zipfile
import os
import re
import shutil
import sys
name_of_file= sys.argv[1]
file = zipfile.ZipFile(name_of_file, "r")

# list filenames
for name in file.namelist():
    print name


print

os.mkdir('my_tmp')

file.extractall('my_tmp')
ofi = open('my_tmp/content.xml','r')
t= ofi.read()
#print t
ofi.close()

# regexp
#regex = re.compile('xlink:href=\"http://ulyssecadres.appli.impots/')
regex = re.compile('xlink:href=\"file:///C:/Documents%20and%20Settings/egerman-cp/Bureau/')
resultat = regex.findall(t)
print len(resultat)
z= regex.sub('xlink:href=\"ftp://ftp.bercy.cp/Bureau_3D/OPERA_CDG/',t)
#print z
ofs= open('my_tmp/content.xml','w')
ofs.write(z) 
ofs.close()
zfo = zipfile.ZipFile('nouveau.ods', mode='w') 
for name in file.namelist():
    print name
    zfo.write('my_tmp/' + name,arcname =name)

zfo.close()

shutil.rmtree('my_tmp')  
