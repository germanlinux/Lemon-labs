# coding: utf8
import sys
try:
    file = sys.argv[1]
except:
    file = "corailza.csv"
with open(file,'r', encoding = 'Windows-1252') as f:
     tab = f.readlines()
doublon = set()     
for ligne in tab:
     tligne = ligne.split(';')
     if len(tligne) > 10 and tligne[1].casefold() != 'projet' and  tligne[1].casefold() != '':
        #print(tligne[1],'=', tligne[12])
        application = tligne[1].strip()
        moe = tligne[12].strip()
        if moe :
            print(application,'*', moe)
            nom = application+'*' + moe
            doublon.add(nom)
print(doublon)
import sqlite3 as sq
connex = sq.connect(r"c:\Users\egerman01\cartosi2b.bd") 
curseur = connex.cursor()
for item in doublon:
    tab = item.split('*')
    curseur.execute("INSERT INTO applications (nom, moe, hote ) VALUES (?, ?, ?)", (tab[0], tab[1], 1)) 

connex.commit()   
connex.close()        