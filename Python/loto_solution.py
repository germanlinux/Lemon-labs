import random
class Dispositif_tirage:
    def __init__(self, nb_de_boule):
        self.boule = set(range(1, nb_de_boule+1))
        self.nb_tirage = 0
        self.boule_enleve = set()
        self.historique = []

    def tirage(self):
        self.nb_tirage+=1
        possible = self.boule - self.boule_enleve
        boule = random.choice(list(possible))
        self.boule_enleve.add(boule)
        self.historique.append(boule)
        print(boule)
        return(boule)
class Grille:
    def __init__(self, nom_joureur, nb_de_case, nb_total):
        self.joueur = nom_joureur
        self.nb_de_case = nb_de_case
        self.nb_total = nb_total
        self.cases =set()

    def genere(self):
        while len(self.cases) < self.nb_de_case:
             numero  = random.choice(range(1,self.nb_total))
             self.cases.add(numero)

    def emmarge(self,nb): 
        self.cases = self.cases - {nb}
        return(len(self.cases))
            
class Partie:
    def __init__(self, tirages , *grilles):
        self.tirages  = tirages
        self.grilles = list(grilles)

    def un_tour (self):
        tirage = self.tirages.tirage()
        for grille in self.grilles:
            a = grille.emmarge(tirage)
            if a==0 :
              print('BINGO pour ', grille.joueur)   
              return(False)
        return(True)      
#
# programme principal 
#
import argparse

parser = argparse.ArgumentParser(description='simulateur de loto')
parser.add_argument('--nombre','-n', help = "nombre total de boule" , type=int , default= 20,)
parser.add_argument('--joueur','-j', help = "nombre de joueur" , type=int , default= 2,)
parser.add_argument('--grille','-g', help = "dimension de la grille" , type=int , default= 5,)


args = parser.parse_args()
#print(args) 


urne = Dispositif_tirage(args.nombre)
nb_joueur = args.joueur
grille = args.grille
liste_joueur = []
for i in range(1 ,nb_joueur+1):
   tmp_grille= Grille(str(i), grille,args.nombre)
   tmp_grille.genere()  
   liste_joueur.append(tmp_grille)

partie = Partie(urne, *liste_joueur)
stop = True
while stop:
   stop = partie.un_tour()


''' situation de depart

on souhaite:
- enrichir les options de la ligne de commande
- refactoriser l'instanciation des grilles des joueurs




python  loto_solution.py --help
usage: loto_solution.py [-h] [--nombre NOMBRE] [--joueur JOUEUR]
                        [--grille GRILLE]

simulateur de loto

optional arguments:
  -h, --help            show this help message and exit
  --nombre NOMBRE, -n NOMBRE
                        nombre total de boule
  --joueur JOUEUR, -j JOUEUR
                        nombre de joueur
  --grille GRILLE, -g GRILLE
                        dimension de la grille
'''
