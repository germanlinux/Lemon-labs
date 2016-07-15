import psycopg2
from datetime  import date
pcta_champs = ('CCROLOP', 'CTCLI', 'CCROANOC', 'NCTANUTI', 'NCTALGNS',\
'DTABVAL', 'CCTASNSE', 'CRGPTYPE', 'CCTADVAL', 'CCTAMAFI', 'LCTATARU', 'LCTARESU',\
'CCTAECRM', 'NCTAJOUV', 'CSQLCLOP', 'CSQLTYP' , 'CSQLANO' , 'NSQLNUTI', 'NSQLLGNS',\
'CCTAEXOC', 'CCTAALGO', 'CCTAREFN', 'CCTACLOP', 'CCTATYP' , 'CCTAANOC', 'NCTANNUT', 'NCTANLGN')
#print(repr(pcta_champs))
pcta_dico = {}
pcta_dico['CCROLOP'] = {'type': 'num', 'int' : 'integer', 'ext': '3:Z'  }
pcta_dico['CTCLI'] = {'type': 'string', 'int' : 'string:2', 'ext': 'string:2'  }
pcta_dico['CCROANOC'] = {'type': 'num', 'int' : 'integer', 'ext': '1:N'  }
pcta_dico['NCTANUTI'] = {'type': 'string', 'int' : 'string:4', 'ext': 'string:4'}
pcta_dico['NCTALGNS'] = {'type': 'num', 'int' : 'integer', 'ext': '2:Z'  }
pcta_dico['DTABVAL'] = {'type': 'date', 'int' : 'date', 'ext': 'R:8'  }
pcta_dico['CCTASNSE'] = {'type': 'string', 'int' : 'string:1', 'ext': 'string:1'}
pcta_dico['CRGPTYPE'] = {'type': 'string', 'int' : 'string:1', 'ext': 'string:1'}
pcta_dico['CCTADVAL'] = {'type': 'string', 'int' : 'string:1', 'ext': 'string:1'}
pcta_dico['CCTAMAFI'] = {'type': 'string', 'int' : 'string:8', 'ext': 'string:8'}
pcta_dico['LCTATARU'] = {'type': 'string', 'int' : 'string:8', 'ext': 'string:8'}
pcta_dico['LCTARESU'] = {'type': 'string', 'int' : 'string:8', 'ext': 'string:8'}
pcta_dico['CCTAECRM'] = {'type': 'string', 'int' : 'string:1', 'ext': 'string:1'}
pcta_dico['NCTAJOUV'] = {'type': 'num', 'int' : 'integer', 'ext': '2:N'  }
pcta_dico['CSQLCLOP'] = {'type': 'num', 'int' : 'integer', 'ext': '3:Z'  }
pcta_dico['CSQLTYP'] = {'type': 'string', 'int' : 'string:2', 'ext': 'string:2'  }
pcta_dico['CSQLANO'] = {'type': 'num', 'int' : 'integer', 'ext': '1:N'  }
pcta_dico['NSQLNUTI'] = {'type': 'string', 'int' : 'string:4', 'ext': 'string:4'}
pcta_dico['NSQLLGNS'] = {'type': 'num', 'int' : 'integer', 'ext': '2:Z'  }
pcta_dico['CCTAEXOC'] = {'type': 'string', 'int' : 'string:1', 'ext': 'string:1'}
pcta_dico['CCTAALGO'] = {'type': 'string', 'int' : 'string:4', 'ext': 'string:4'}
pcta_dico['CCTAREFN'] = {'type': 'string', 'int' : 'string:2', 'ext': 'string:2'}
pcta_dico['CCTACLOP'] = {'type': 'num', 'int' : 'integer', 'ext': '3:Z'  }
pcta_dico['CCTATYP'] = {'type': 'string', 'int' : 'string:2', 'ext': 'string:2'}
pcta_dico['CCTAANOC'] = {'type': 'num', 'int' : 'integer', 'ext': '1:Z'  }
pcta_dico['NCTANNUT'] = {'type': 'string', 'int' : 'string:4', 'ext': 'string:4'}
pcta_dico['NCTANLGN'] = {'type': 'num', 'int' : 'integer', 'ext': '2:Z'  }
#print(repr(pcta_dico)) 
class Pcta:
        def __init__(self,dateref):
              self.lignes={}
              self.dateref = dateref
        def add_ligne(self,ligne):
            clex = ligne[0] + ligne[1] + ligne[2] + ligne[3] + ligne[4]
            print(clex)  	    
            if clex in self.lignes:
                dateexist = self.lignes[clex].dtabval
                if self.dateref > dateexist:
                   self.lignes[clex] = LignePCTA(ligne)
            else:
                   self.lignes[clex] = LignePCTA(ligne)
        def charge_from_BDD(self):
           conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
           cur = conn.cursor()
           cur.execute("SELECT * FROM pcta ORDER BY  CCROLOP ,CTCLI ,CCROANOC ,NCTANUTI ,NCTALGNS ,DTABVAL;")
           for record in cur:
             self.add_ligne(record)
           conn.close

class LignePCTA: 
  def __init__(self,row):
        self.CCROLOP = row[0]
        self.CTCLI = row[1]
        self.CCROANOC =row[2]
        self.NCTANUTI =row[3]
        self.NCTALGNS =row[4]
        self.DTABVAL  =row[5]
        self.CCTASNSE =row[6]
        self.CRGPTYPE =row[7]
        self.CCTADVAL =row[8]
        self.CCTAMAFI =row[9]
        self.LCTATARU =row[10]
        self.LCTARESU =row[11]
        self.CCTAECRM =row[12]
        self.NCTAJOUV =row[13]
        self.CSQLCLOP =row[14]
        self.CSQLTYP  =row[15]
        self.CSQLANO  =row[16]
        self.NSQLNUTI =row[17]
        self.NSQLLGNS =row[18]
        self.CCTAEXOC =row[19]
        self.CCTAALGO =row[20]
        self.CCTAREFN =row[21]
        self.CCTACLOP =row[22]
        self.CCTATYP  =row[23]
        self.CCTAANOC =row[24]
        self.NCTANNUT =row[25]
        self.NCTANLGN =row[26]
        self.ccrolop= row[0]
        self.ctcli= row[1]
        self.ccroanoc =row[2]
        self.nctanuti =row[3]
        self.nctalgns =row[4]
        self.dtabval  =row[5]
        self.cctasnse =row[6]
        self.crgptype =row[7]
        self.cctadval =row[8]
        self.cctamafi =row[9]
        self.lctataru =row[10]
        self.lctaresu =row[11]
        self.cctaecrm =row[12]
        self.nctajouv =row[13]
        self.csqlclop =row[14]
        self.csqltyp  =row[15]
        self.csqlano  =row[16]
        self.nsqlnuti =row[17]
        self.nsqllgns =row[18]
        self.cctaexoc =row[19]
        self.cctaalgo =row[20]
        self.cctarefn =row[21]
        self.cctaclop =row[22]
        self.cctatyp  =row[23]
        self.cctaanoc =row[24]
        self.nctannut =row[25]
        self.nctanlgn =row[26]
class SchemaComptable:
       def __init__(self,pcta):
          self.matrice = {} 
          keys = sorted(pcta.lignes)
          for item in keys:
              cle_tronquee = item[0:6]
              tableau =[]
              if cle_tronquee in self.matrice:
                 tableau = self.matrice[cle_tronquee]
              tableau.append(pcta.lignes[item])
              self.matrice[cle_tronquee] = tableau
       def recherche_operation(self,operation):
          ligne =''
          if operation in self.matrice:
             ligne = self.matrice[operation]
          else:
             operationbanal = operation[0:3] +"99" + operation[5:7]  
             if operationbanal in self.matrice:
                ligne = self.matrice[operationbanal]
             else:
                print("operation erreur {}".format(operation))
                exit()
          if ligne[0].cctaclop != '000': 
             operation=ligne[0].cctaclop + ligne[0].cctatyp + ligne[0].cctaanoc
             ligne = self.matrice[operation]                	  
          return ligne
  
dateref = date.today()
pcta = Pcta(dateref) 
pcta.charge_from_BDD()
print( len(pcta.lignes))
print('094DT0999902', pcta.lignes['094DT0999902'].dtabval)
schema = SchemaComptable(pcta)
print("nombre de ligne du schema (tableau) pour 094DT0"),(len(schema.matrice['094DT0']))
print("premier element du tableau pour 094DT0",schema.matrice['094DT0'][0].NCTALGNS,schema.matrice['094DT0'][0].CCTASNSE)
print("deuxieme  element du tableau pour 094DT0",schema.matrice['094DT0'][1].NCTALGNS,schema.matrice['094DT0'][1].CCTASNSE)

# recherche poste pcta dans la table.
maligne= schema.recherche_operation('094DT0')
print( "recherche pour 094DT0")
print( maligne[0].CCROLOP + maligne[0].CTCLI + maligne[0].CCROANOC)
maligne= schema.recherche_operation('064DT0')
print("recherche pour 064DT0")
print( maligne[0].CCROLOP + maligne[0].CTCLI + maligne[0].CCROANOC)
maligne= schema.recherche_operation('104DT0')
print("recherche pour 104DT0")
print( maligne[0].CCROLOP + maligne[0].CTCLI + maligne[0].CCROANOC)
#maligne= schema.recherche_operation('06AFT0')
#print("recherche pour 06AFT0")
#print(maligne[0].CCROLOP + maligne[0].CTCLI + maligne[0].CCROANOC)
#print("eg")
cp  = 0
cp1 = 0
cp2 = 0
cp3 = 0
cp4 = 0
for key in schema.matrice:
   if len(schema.matrice[key]) == 1:
        print(key)
        cp1+=1
   if len(schema.matrice[key]) == 2:
          cp2+=1 
   if len(schema.matrice[key]) == 3:
          cp3+=1
   if len(schema.matrice[key]) == 4:  #teste
          # print(key)
          cp4+=1

print(cp1,cp2, cp3,cp4)
#
print(cp1+ cp2 + cp3 + cp4)
print(len(schema.matrice))
