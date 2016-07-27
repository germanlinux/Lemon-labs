import psycopg2
import copy
from datetime  import date

class Psql:
        def __init__(self,dateref):
              self.lignes={}
              self.dateref = dateref
        def add_ligne(self,ligne):
            clex = ligne[0]+ligne[1]+ ligne[2] +ligne[3]+ ligne[4]
            #print(clex)
            if clex in self.lignes:
                dateainserer = ligne[5]
                if self.dateref > dateainserer:
                   self.lignes[clex] = LignePsql(ligne)
            else:
                   self.lignes[clex] = LignePsql(ligne)
        def charge_from_BDD(self):
           conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
           cur = conn.cursor()
           cur.execute("SELECT * FROM psql  ORDER BY ccrolop, ctcli, ccroanoc, nctanuti, nctalgns ,dtabval;")
           for record in cur:
             self.add_ligne(record)
           conn.close
        def cherche(self,code):
            return self.lignes[code]
class LignePsql:
  def __init__(self,row):
        self.ccrolop  =row[0]
        self.ctcli    =row[1]
        self.ccroanoc =row[2]
        self.nctanuti =row[3]
        self.nctalgns =row[4]
        self.dtabval  =row[5]
        self.lsqlstd1 =row[6]
        self.lsqlcom1 =row[7]
        self.lsqlcom2 =row[8]
        self.lsqlcom3 =row[9]
        self.csqlvar1 =row[10]
        self.csqlvar2 =row[11]
        self.csqlvar3 =row[12]
        self.csqlvar4 =row[13]
        self.variables = self.tableau_zoneCro()
        self.ligne90 = self.lsqlstd1 + self.lsqlcom1 +self.lsqlcom2 + self.lsqlcom3
        self.etoile()
        self.emplacement()
  def tableau_zoneCro(self):
        tab =[]
        if self.csqlvar1 != '        ':
           tab.append(self.csqlvar1)
        if self.csqlvar2 != '        ':
           tab.append(self.csqlvar2)
        if self.csqlvar3 != '        ':
           tab.append(self.csqlvar3)
        if self.csqlvar4 != '        ':
           tab.append(self.csqlvar4)
        return tab
  def etoile(self):
       self.lsqlstd1_n =self.lsqlstd1.count('*')
       self.lsqlcom1_n =self.lsqlcom1.count('*')
       self.lsqlcom2_n =self.lsqlcom2.count('*')
       self.lsqlcom3_n =self.lsqlcom3.count('*')
       self.ligne90_n  =self.ligne90.count('*')
  def emplacement(self):
       self._tab_emplacement=[]
       for idx, val in enumerate(self.ligne90):
           if val  == '*':
               self._tab_emplacement.append(idx)
  def formate_date6(self,dat):
        strdate = dat[4:6] + "/" + dat[2:4] + "/" + dat[0:2]
        return strdate
  def formate_montant(self,montant):
        lgt = len(montant)
        nentier=float(montant)/10000
        ent = "   {:10.2f}".format(nentier)
        strm = ent.ljust(lgt,' ')
        return strm
  def remplace(self,dictvar):
       _tabv =copy.copy(self.variables)
       ligne90 = self.lsqlstd1 + self.lsqlcom1 +self.lsqlcom2 + self.lsqlcom3
       cpetoile= ligne90.count('*')
       #tmp1 =  self.lsqlstd1
       i =0
       while i < cpetoile:
         empla = self._tab_emplacement[i]
         crepl = _tabv.pop(0) #1
         repl = dictvar[crepl]
         if crepl == 'DFACTRAN':
             repl = self.formate_date6(repl)
         if crepl == 'MFACCOMP':
             repl = self.formate_montant(repl)

         lgrep = len(repl)
         ligne90 =ligne90[0:empla] +repl + ligne90[empla + lgrep:]
         i +=1
       ligne90=ligne90[0:90]
       tmp1 = ligne90[0:15]
       tmp2 = ligne90[15:30]
       tmp3 = ligne90[30:60]
       tmp4 = ligne90[60:90]
       """
       gfinal = len(tmp1)
       while i < self.lsqlstd1_n:
           ix =tmp1.index('*')
           crepl = _tabv.pop(0) #1
           repl = dictvar[crepl]
           lgrep = len(repl)
           tmp1 =tmp1[0:ix] +repl + tmp1[ix+lgrep:]
           i+=1
       lgtotal = len(tmp1)
       tmp1=tmp1[0:lgfinal]
       tmp2 =  self.lsqlcom1
       lgfinal = len(tmp2)
       i =0
       while i < self.lsqlcom1_n:
           ix =tmp2.index('*')
           crepl = _tabv.pop(0) #2
           repl = dictvar[crepl]
           lgrep = len(repl)
           tmp2 =tmp2[0:ix] +repl + tmp2[ix+lgrep:]
           i+=1
       tmp2=tmp2[0:lgfinal]
       tmp3 =  self.lsqlcom2
       lgfinal = len(tmp3)
       i =0
       while i < self.lsqlcom2_n:
           ix =tmp3.index('*')
           crepl = _tabv.pop(0)  #3
           repl = dictvar[crepl]
           lgrep = len(repl)
           tmp3 =tmp3[0:ix] +repl + tmp3[ix+lgrep:]
           i+=1
       tmp3=tmp3[0:lgfinal]
       tmp4 =  self.lsqlcom3
       lgfinal = len(tmp4)
       i =0
       while i < self.lsqlcom3_n:
           ix =tmp4.index('*')
           crepl = _tabv.pop(0)  #4
           repl = dictvar[crepl]
           lgrep = len(repl)
           tmp4 =tmp4[0:ix] +repl + tmp4[ix+lgrep:]
           i+=1
       tmp4=tmp4[0:lgfinal]
       """
       return (tmp1,tmp2,tmp3,tmp4)


