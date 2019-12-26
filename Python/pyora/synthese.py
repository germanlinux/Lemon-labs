import sys
filevol  = sys.argv[1]
with open(filevol, 'r') as f:
    lignes = f.readlines()
filecol  = sys.argv[2]
with open(filecol, 'r') as f:
    lignescol = f.readlines()

dict_table={}
for ligne in lignescol:
    ligne = ligne[:-1]
    ligne = ligne.replace('\"', '')
    t = ligne.split(',')
    dict_table[t[0]] = t[3]
for ligne in lignes: 
    ligne= ligne[:-1]
    t_ligne = ligne.split(';')
    print(f"{t_ligne[0]};{t_ligne[1]};{dict_table[t_ligne[0]]}")

