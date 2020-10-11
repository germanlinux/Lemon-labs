import random
from collections import Counter as Counter
class De:
    def __init__(self, nb_de_face=6):
        self.face = list(range(1, nb_de_face+1))
    
    def triche_sur(self, face):
        self.face.append(face)   

    def roule(self):
        face = random.choice(self.face)
        return(face)

    def affiche(self):
        proba= round(1/ len(self.face)* 100,2)
        c =  Counter(self.face)
        for face in c:   
            print(face, proba * c[face]   )            

if __name__ == '__main__' :
    mon_de = De()
    mon_de.affiche()
    mon_de.triche_sur(2)
    mon_de.affiche()
    


      