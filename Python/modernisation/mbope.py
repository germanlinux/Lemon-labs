import psycopg2
from datetime  import date

class Bope:
        def __init__(self,dateref):
              self.lignes={}
              self.dateref = dateref
        def add_ligne(self,ligne):
            clex = ligne[0]+ligne[1] +ligne[2]
            #print(clex)
            if clex in self.lignes:
                dateexist = self.lignes[clex].dtabval
                if self.dateref > dateexist:
                   self.lignes[clex] = LigneBope(ligne)
            else:
                   self.lignes[clex] = LigneBope(ligne)
        def charge_from_BDD(self):
           conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
           cur = conn.cursor()
           cur.execute("SELECT * FROM bope ORDER BY ccrolop, ccptind,scpttyp,DTABVAL;")
           for record in cur:
             self.add_ligne(record)
           conn.close
        def get_cbopcjc(self,code,type):
          if code+type in self.lignes:
            return self.lignes[code+type].cbopcjc
          else:
            type='99999'
            return self.lignes[code+type].cbopcjc

class LigneBope:
  def __init__(self,row):
        self.ccrolop     =row[0]
        self.ccptind     =row[1]
        self.scpttyp     =row[2]
        self.dtabval     =row[3]
        self.cbopcjc     =row[4]
        self.cbopcont    =row[5]


