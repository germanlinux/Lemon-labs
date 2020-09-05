'''
python decompte.py lipsum1.txt
[('i', 213), ('e', 211), ('u', 183)]
python decompte.py lipsum2.txt
[('i', 268), ('e', 267), ('u', 239)]
python decompte.py lipsum3.txt
[('e', 304), ('i', 296), ('a', 243)]
python decompte.py lipsum4.txt
fichier inconnu
'''


import sys
from collections import Counter as Counter
try:
    with open(sys.argv[1], 'r') as f:
        contenu = f.readlines()
except :
    print('fichier inconnu')
else:   
    chaine = ''.join(contenu)
    compteur = Counter(chaine)
    del compteur[" "]
    print(compteur.most_common(3))


        
