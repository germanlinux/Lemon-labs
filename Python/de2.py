import random
class De:
    def __init__(self, nb_de_face=6):
        self.face = set(range(1, nb_de_face+1))

    def roule(self):
        face = random.choice(list(self.face))
        return(face)

    def affiche(self):
        proba= round(1/ len(self.face)* 100,2)
        for face in self.face:   
            print(face, proba)
    
                

if __name__ == '__main__' :
    mon_de = De()
    mon_de.affiche()


      