entree_facile = ([9, 0, 6, 4, 0, 5, 0, 8, 0],
                 [0, 7, 2, 0, 0, 0, 0, 4, 1],
                 [3, 4, 0, 0, 0, 2, 0, 0, 0],
                 [0, 0, 4, 1, 6, 0, 3, 0, 0],
                 [7, 0, 1, 0, 4, 0, 9, 0, 2],
                 [0, 0, 5, 0, 3, 7, 4, 0, 0],
                 [0, 0, 0, 7, 0, 0, 0, 2, 9],
                 [8, 2, 0, 0, 0, 0, 1, 7, 0],
                 [0, 5, 0, 9, 0, 6, 8, 0, 4])

entree_moyen =  ([0, 0, 0, 0, 0, 0, 9, 1, 8],
                 [9, 8, 4, 0, 7, 0, 0, 0, 0],
                 [0, 2, 0, 3, 9, 0, 0, 0, 0],
                 [3, 0, 0, 0, 8, 7, 0, 9, 6],
                 [6, 0, 5, 0, 0, 0, 4, 0, 0],
                 [8, 0, 0, 0, 3, 6, 0, 5, 1],
                 [0, 1, 0, 2, 6, 0, 0, 0, 0],
                 [4, 3, 8, 0, 1, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0, 1, 4, 9],)

entree_expert =  ([7, 1, 0, 0, 0, 0, 0, 3, 0],
                 [0, 0, 0, 8, 0, 9, 0, 0, 1],
                 [0, 0, 0, 0, 0, 0, 7, 0, 5],
                 [0, 0, 4, 0, 8, 3, 0, 0, 0],
                 [0, 0, 6, 0, 0, 0, 0, 1, 2],
                 [0, 0, 9, 0, 5, 2, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0, 4, 0, 6],
                 [0, 0, 0, 2, 0, 5, 0, 0, 8],
                 [3, 2, 0, 0, 0, 0, 0, 5, 0])




'''
continuation
'''








'''
debut du programme
'''

grille = Grille(entree_facile)
histogrille = Grilles(grille)
histogrille[0].affiche()
a = True
cp = 0
while a ==True:
    cp +=1
    moteur = Resolve(histogrille,-1)
    a = moteur.combo()    
    histogrille.append(moteur.etat_suivant())
    histogrille[-1].affiche()
print(f"resolu en {cp} coups")




''' objectifs : prise en charge des options 

python sudoku2.py  --help
usage: sudoku2.py [-h] [--grille facile|moyen|expert]

Resolveur de sudoku en mode algorithmique

optional arguments:
  -h, --help            show this help message and exit
  --grille facile|moyen|expert, -g facile|moyen|expert
                        le type de grille à résoudre: facile - moyen - expert


'''

                        