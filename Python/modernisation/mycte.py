import psycopg2
from datetime  import date

class Ycte:
        def __init__(self,dateref):
              self.lignes={}
              self.dateref = dateref
        def add_ligne(self,ligne):
            clex = ligne[0]+ligne[1]
            #print(clex)
            if clex in self.lignes:
                dateexist = self.lignes[clex].dtabval
                if self.dateref > dateexist:
                   self.lignes[clex] = LigneYcte(ligne)
            else:
                   self.lignes[clex] = LigneYcte(ligne)
        def charge_from_BDD(self):
           conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
           cur = conn.cursor()
           cur.execute("SELECT * FROM ycte ORDER BY ccptind,scpttyp,DTABVAL;")
           for record in cur:
             self.add_ligne(record)
           conn.close
        def get_syctclass(self,code):
           return self.lignes[code].syctcass

class LigneYcte:
  def __init__(self,row):
        self.ccptind     =row[0]
        self.scpttyp     =row[1]
        self.dtabval     =row[2]
        self.syctcass    =row[3]


