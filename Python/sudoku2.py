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

import copy
import argparse
import pickle
from collections import Counter
list_totale =[]
try:
    with  open('mypicklefile', 'rb') as pers:
        list_totale = pickle.load(pers)
#print(list_totale)
except:
    pass
    

class Carre():
    @staticmethod
    def Localise(i,j):
        adresse = {}
        if i < 3:
            adresse = {0, 1 ,2 }
        elif i < 6:
            adresse = {3, 4 ,5 } 
        else:
            adresse = {6, 7 ,8 }   
        if j < 3 :
            return adresse.intersection({0, 3, 6})
        if j < 6 :
            return adresse.intersection({1, 4, 7})
        return  adresse.intersection({2, 5, 8})  


class Grille:
    def __init__(self, pgrille):
        self.grille = list(pgrille) 
        self.etat = 0

    def get_ligne(self, nb):
        return self.grille[nb]

    def get_colonne(self, nb):
        col =[]    
        for i in range(9):    
            col.append(self.grille[i][nb])    
        return col 

    def  get_carre(self, nb):
        col =[]   
        
        if nb in [0,1,2] :
            for i in range(3): 
                col +=  self.get_ligne(i)[0+(3*nb) :3 + (3*nb) ]
        if nb in [3,4,5] :
            for i in range(3,6): 
                col +=  self.get_ligne(i)[0+(3*(nb-3)) :3 + (3*(nb-3))] 
        if nb in [6,7,8] :
            for i in range(6,9): 
                col +=  self.get_ligne(i)[0+(3*(nb-6)) :3 + (3*(nb-6))]      
        return col

    def get_set_ligne(self, nb):
        return(set(self.get_ligne(nb)) - {0}) 

    def get_set_colonne(self, nb):
        return(set(self.get_colonne(nb))- {0} ) 

    def get_set_carre(self, nb):
        return(set(self.get_carre(nb)) - {0} )

    def affiche(self):
        for i in range(9):
            if i % 3 == 0:
                print(' ') 
            for j in range(9) :
                if j %3 == 0:
                    print(' ',end ='') 
                print(self.grille[i][j],end='')
            print(' ') 

        
from collections.abc import MutableSequence

class Grilles(MutableSequence):
    def __init__(self, pgrille):
        self.grille =  [pgrille] 
        super().__init__()

    def __getitem__(self, i):
        return self.grille[i]

    def __len__(self):
        return len(self.grille)

    def  __setitem__(self,i, valeur):
        self.grille[i] = valeur

    def __delitem__(self, index):
        del self.grille[index]

    def insert(self, index, value):
        self.grille.insert(index, value)


Grilles.register(list)


class Resolve:
    def __init__(self, histo, etat):
        self.grille_depart = copy.deepcopy(histo[etat])
        self.univers_possible ={}

    def coup_simple(self):
        '''on balaye la ligne et la colonne puis le cube'''
        cpcoup = 0
        #
        for i in range(9):
            for j in range(9):
                if self.grille_depart.grille[i][j] == 0: 
                    possible = set(range(1,10))
                    possible = possible - self.grille_depart.get_set_ligne(i)
                    possible = possible - set(self.grille_depart.get_set_colonne(j))
                    ab = Carre.Localise(i,j)
                    cube= ab.pop()
                    possible = possible -  set(self.grille_depart.get_set_carre(cube))
                   
                    self.univers_possible[(cube,i,j)] = possible    
                    if len(possible) == 1:
                        nb = possible.pop()
                        print(f"Ligne : {i+1} Colonne : {j+1}: mettre : {nb}")
                        cpcoup +=1
                        self.majlignecolonne(i, j,nb, cube )
        print('coup simple:', cpcoup)  
        return(cpcoup)

    def _helper_search(self, cube, nb):
        for item, valeur in self.univers_possible.items():
            if item[0] == cube :
                if nb in valeur:
                    return (item[1], item[2]) 
        return None            
                    
    def _helper_reduction(self, cube,compteur):
        cube = cube
        lst_ajouer = []
        for nb, quant in compteur.items():
            if quant == 1 :
                l,c =self. _helper_search(cube, nb) 
                lst_ajouer.append((cube, l, c, nb) )
        return lst_ajouer       

    def combo(self):
        a = b = 0
        a  =self.coup_simple()
        if a == 0:
            b = self.reduction_carre()
        if a == 0 and b == 0: 
            return False
        return True
              
    def reduction_carre(self):
        ''' on travaille sur le cube'''
        reduc = {}
        listajouer =[]
        for i, messet in self.univers_possible.items():
            cle = i[0]
            if cle in reduc:
                reduc[cle].append(list(messet))
            else:
                reduc[cle] = [list(messet)]
        for i in reduc:
            if len(reduc[i]) > 0 :
                compt = Counter()
                for lst in reduc[i]:
                    compt.update(lst)
                a = self._helper_reduction(i,compt)
                if len(a) > 0:
                    listajouer.extend([*a])
      
        for  item in listajouer:
            print(f"Ligne : {item[1]+1} Colonne : {item[2]+1}: mettre : {item[3]}")
            self.majlignecolonne(item[1],item[2], item[3], item[0])
        print('coup par reduction:',len(listajouer))  
        print('-------------------------------------------------')
        return(len(listajouer)) 

    def majlignecolonne(self, i, j , nb, cube ):
        self.grille_depart.grille[i][j] = nb
         
    def etat_suivant(self):
        return self.grille_depart

                     
parser = argparse.ArgumentParser(description='Resolveur de sudoku en mode algorithmique')
parser.add_argument('--grille','-g',  metavar='facile|moyen|expert',choices=('facile', 'moyen', 'expert'),
                    default= 'facile',
                    help='le type de grille à résoudre: facile - moyen - expert')

args = parser.parse_args()
#print(args) 
magrille = vars()['entree_' + args.grille]          

magrille = list_totale[-1][1]

magrille = ([[8, 6, 0, 9, 5, 7, 3, 2, 1], [1, 9, 5, 4, 2, 3, 7, 6, 8], [7, 3, 4, 6, 1, 0, 5, 9, 0],
 [4, 7, 1, 2, 3, 8, 0, 5, 6], [9, 8, 6, 1, 4, 5, 2, 3, 7], [3, 5, 2, 7, 6, 9, 1, 8, 4],
 [5, 1, 8, 3, 9, 4, 6, 7, 2], [0, 2, 7, 5, 0, 1, 8, 4, 3], [6, 4, 3, 8, 7, 2, 9, 1, 5]
])
grille = Grille(magrille)
histogrille = Grilles(grille)
histogrille[0].affiche()
encours = True
cp = 0
while encours ==True:
    cp +=1
    moteur = Resolve(histogrille,-1)
    encours = moteur.combo()    
    histogrille.append(moteur.etat_suivant())
    histogrille[-1].affiche()
    print(histogrille[-1].grille)
print(f"resolu en {cp} cycles")
