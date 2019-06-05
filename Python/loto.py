import random
class Dispositif_tirage:
    def __init__(self, nb_de_boule):
        self.boule = set(range(1, nb_de_boule))
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
urne = Dispositif_tirage(20)
grille1 = Grille('A', 5,20)
grille1.genere()
grille2 = Grille('B' ,  5,20)
grille2.genere()
partie = Partie(urne, grille1, grille2)
stop = True
while stop:
   stop = partie.un_tour()


