import psycopg2
from datetime  import date

class Cint:
        def __init__(self,dateref):
              self.lignes={}
              self.dateref = dateref
        def add_ligne(self,ligne):
            clex = ligne[0]+ligne[1]
            #print(clex)
            if clex in self.lignes:
                dateexist = self.lignes[clex].dtabval
                if self.dateref > dateexist:
                   self.lignes[clex] = LigneCint(ligne)
            else:
                   self.lignes[clex] = LigneCint(ligne)
        def charge_from_BDD(self):
           conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
           cur = conn.cursor()
           cur.execute("SELECT * FROM cint ORDER BY ccincass, ncincte ,dtabval;")
           for record in cur:
             self.add_ligne(record)
           conn.close
        def get_CCINMAJB(self,code):
            t = code.ljust(9)
            return self.lignes[t].ccinmajb
        def iscleexisteBool(self,code):
            if code in self.lignes:
               return True
            else:
               return False

class LigneCint:
  def __init__(self,row):
        self.ccincass     =row[0]
        self.ncincte    =row[1]
        self.dtabval     =row[2]
        self.ccinmajb    =row[3]


