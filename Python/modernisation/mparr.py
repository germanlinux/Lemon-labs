import psycopg2
from datetime  import date

class Parr:
        def __init__(self,dateref):
              self.lignes={}
              self.dateref = dateref
        def add_ligne(self,ligne):
            clex = ligne[0]
            #print(clex)
            if clex in self.lignes:
                dateexist = self.lignes[clex].dtabval
                if self.dateref > dateexist:
                   self.lignes[clex] = LigneParr(ligne)
            else:
                   self.lignes[clex] = LigneParr(ligne)
        def charge_from_BDD(self):
           conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
           cur = conn.cursor()
           cur.execute("SELECT * FROM parr ORDER BY cbopcont,DTABVAL;")
           for record in cur:
             self.add_ligne(record)
           conn.close
        def recherche(self,code,champ):
            lg = self.lignes[code]
            if champ =='SPARCPAR':
               return(lg.cparcpar+lg.nparcpar)
            elif champ =='SPARIPDT':
               return(lg.cparipdt+lg.nparipdt)
            elif champ =='SPARCGFP':
               return(lg.cparcgfp+lg.nparcgfp)
            elif champ =='SPARLIFP':
               return(lg.cparlifp+lg.nparlifp)
            elif champ =='SPARADT':
               return(lg.cparadt+lg.nparadt)
            else:
               raise RuntimeError("zone non prevue {}".format(champ))

class LigneParr:
  def __init__(self,row):
        self.cbopcont     =row[0]
        self.dtabval      =row[1]
        self.cparcgf      =row[2]
        self.nparcgfp     =row[3]
        self.cparlifp     =row[4]
        self.nparlifp    = row[5]
        self.cparcpar     =row[6]
        self.nparcpar     =row[7]
        self.nparspe1     =row[8]
        self.nparspe2     =row[9]
        self.cparipfp     =row[10]
        self.nparipfp     =row[11]
        self.cparipdt     =row[12]
        self.nparipdt     =row[13]
        self.cparipcd     =row[14]
        self.nparipcd     = row[15]
        self.cparadfp     =row[16]
        self.nparadfp     =row[17]
        self.cparapfp     =row[18]
        self.nparapfp     =row[19]
        self.cparadt      =row[20]
        self.nparadt      =row[21]
        self.cparacdc     =row[22]
        self.nparacdc     =row[23]


