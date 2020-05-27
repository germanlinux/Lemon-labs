import sys
filepro  = sys.argv[1]
fileper  = sys.argv[2]

with open(filepro, 'r') as fpro:
    lignes = fpro.readlines()
lignes = lignes[1:]
dic_pro = {}
for ligne in lignes:
    t_ligne = ligne.split(',')
    if len(t_ligne) > 1:
        dic_pro[t_ligne[0]] = t_ligne[1]+ ' # ' + t_ligne[2]
with open(fileper, 'r') as fper:
    lignes = fper.readlines()
lignes = lignes[1:]
dic_per = {}
for ligne in lignes:
    t_ligne = ligne.split(',')
    if len(t_ligne) > 1:
        dic_per[t_ligne[0]] = t_ligne[1]+ ' # ' + t_ligne[2]
print("comparaison pro / pers")
for cle, value in dic_pro.items():
    if cle in dic_per:
        if dic_pro[cle] != dic_per[cle]:
            print(f"Discordance: {cle}-{ dic_pro[cle]}  <===> {cle}-{dic_per[cle]}")
    else: 
        print(f"Dans pro uniquement:  {cle}-{dic_pro[cle]}" )
for cle, value in dic_per.items():
    if cle in dic_pro:
        pass
    else: 
        print(f"Dans pers uniquement: {cle}-{dic_per[cle]}" )
