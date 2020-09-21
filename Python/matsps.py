with open("matsps.csv", 'r')  as f:
    lignes  = f.readlines()

colonnes = (5,6,7,8,15,16,17,25)
for ligne in lignes:
    ligne = ligne[:-1]
    tab = ligne.split(';')
    if len(tab) > 24:
        chaine =''
        for index in colonnes:
            if index != 25:
               chaine += tab[index] + ';'
            else: 
                if len(tab[index]) == 1 and tab[index][0] == 'x' :
                  chaine +='x'
                else:
                  chaine += 'n'     
        print(chaine)
            


