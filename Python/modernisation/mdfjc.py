import psycopg2
from datetime  import date
dfjc_champs = ('DFINJCLI','DFININTA','DFINJCRF','DFINJCTG','DDEBEURO','DTABVAL')
dfjc_dico={}
dfjc_dico['DFINJCLI'] = {'type': 'date', 'int' : 'date', 'ext': 'R:8'  }
dfjc_dico['DFININTA'] = {'type': 'date', 'int' : 'date', 'ext': 'R:8'  }
dfjc_dico['DFINJCRF'] = {'type': 'date', 'int' : 'date', 'ext': 'R:8'  }
dfjc_dico['DFINJCTG'] = {'type': 'date', 'int' : 'date', 'ext': 'R:8'}
dfjc_dico['DDEBEURO'] = {'type': 'date', 'int' : 'date', 'ext': 'R:8'  }
dfjc_dico['DTABVAL'] =  {'type': 'date', 'int' : 'date', 'ext': 'R:8'  }
#print(repr(pcta_dico))
class Dfjc:
#        def __init__(self,dateref):
#             self.lignes={}
#             self.dateref = dateref
        def __init__(self):
            conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
            cur = conn.cursor()
            cur.execute("SELECT * FROM dfjc;")
            for ligne in cur:
                self.DFINJCLI = ligne[0]
                self.dfinjcli = ligne[0]
                self.DFININTA = ligne[1]
                self.dfininta = ligne[1]
                self.DFINJCRF = ligne[2]
                self.dfinjcrf = ligne[2]
                self.DFINJCTG = ligne[3]
                self.dfinjctg = ligne[3]
                self.DDEBEURO = ligne[4]
                self.ddebeuro = ligne[4]
                self.DTABVAL = ligne[5]
                self.dtabval = ligne[5]
            conn.close
        def C402323(self,dreftrai):
            """compare le mois de traitement injecte avec le mois de la date butoir JC de la dfjc"""
            if dreftrai.month == self.dfinjcli.month:
                   return True
            else:
                   return False
        def  MA92323(self):
            """se ramene au dernier jour de l annee precedente"""
            self._008DFINA =  date(self.dfinjcli.year-1,12,31)
            return  self._008DFINA
        def estenjourneecomplementaireBool(self,datetrt):
            """ vrai si date de traitement dreftrai est inf ou egale a la fin journee complementaire"""
            return datetrt <= self.dfinjcli
        def get_datecompabilisation(self,dtr):
            if self.estenjourneecomplementaireBool(dtr):
               return self.MA92323()
            else:
                return dtr



