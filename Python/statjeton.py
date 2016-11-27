import csv
import sys
import re
import datetime
file = sys.argv[1]
###
###
###
###
###  ce programme permet de retracer la consomation des jetons a partir d un fichier exporte
###  depuis la console du serveur de licence bluage
###  le programme attend 3 parametes:
###  -le nom du fichier en entree: le fichier doit etre au format CSV
###  -le nombre total de licence (pour calculer la moyenne)
###  -un label a ajouter au premier libelle de colonne
###
###  un script shell  jeton.sh permet de lancer le programme sur des fichiers identifiés.
###


quot = sys.argv[2]  or 1
label = sys.argv[3]  or ''

class Periode:
    def __init__(self):
     self.jours={}
     self.joursn={}
     self.joursr={}
     self.joursm={}
     self.sessions = ()
    def add(self, s):
     cled = s.datedeb.strftime("%Y/%m/%d")
     self.jours[cled] = 1
     clef = s.datefin.strftime("%Y/%m/%d")
     self.jours[clef] = 1
     if s.types =='N':
        if cled in self.joursn:
          self.joursn[cled].append(s.ip)
        else:
          self.joursn[cled] = [s.ip,]
     if s.types =='R':
        if cled in self.joursr:
          self.joursr[cled].append(s.ip)
        else:
          self.joursr[cled] = [s.ip,]
        if clef in self.joursr:
          self.joursr[clef].append(s.ip)
        else:
          self.joursr[clef] = [s.ip,]
     if s.types =='M':
        if cled in self.joursm:
          self.joursm[cled].append(s.ip)
        else:
          self.joursm[cled] = [s.ip,]
        if clef in self.joursm:
          self.joursm[clef].append(s.ip)
        else:
          self.joursm[clef] = [s.ip,]
        if s.jours > 2:
          _d = s.datedeb
          _d = _d + datetime.timedelta(days=1)
          while _d < s.datefin:
             # print('eg')
#              _d = _d.day +1
              cleinter = _d.strftime("%Y/%m/%d")
              if cleinter in self.joursm:
               self.joursm[cleinter].append(s.ip)
              else:
               self.joursm[cleinter] = [s.ip]
              self.jours[cleinter]= 1
              _d = _d + datetime.timedelta(days=1)
              #print('eg')
    def flat(self):
      for k in self.joursn:
         _s = set(self.joursn[k])
         self.joursn[k] = _s
      for k in self.joursr:
         _s = set(self.joursr[k])
         self.joursr[k] = _s
      for k in self.joursm:
         _s = set(self.joursm[k])
         self.joursm[k] = _s
    def total(self,cle):
      totalp=[]
      totalp1=[]
      totalp2=[]
      chaine =""
      if cle in self.joursn:
         chaine +=str(len(self.joursn[cle])) +';'
         totalp = list(self.joursn[cle])
      else:
         chaine +="0;"
      if cle in self.joursr:
         chaine +=str(len(self.joursr[cle])) +';'
         totalp1 = list(self.joursr[cle])
      else:
         chaine +="0;"
      if cle in self.joursm:
         chaine +=str(len(self.joursm[cle])) +';'
         totalp2 = list(self.joursm[cle])
      else:
         chaine +="0;"
      totals2 = totalp + totalp1 + totalp2
      _t = set(totals2)
      _t2 = len(totalp)  + len(totalp1) + len(totalp2)
      chaine += str(_t2) + ';' + str(len(_t))
      chaine +=';' + str(round(len(_t) / int(quot) *100,))
      return chaine
class Session:
    def __init__(self, util, ip, datedeb, datefin, duration , types,jour ):
     self.util = util
     self.ip= ip
     self.datedeb = datedeb
     self.datefin = datefin
     self.duration = duration
     self.types =  types
     self.jours = jour


with open(file, 'r',encoding='iso-8859-2') as csvfile:
   reader = csv.reader(csvfile, delimiter=';')
   hashdate ={}
   periode = Periode()
   for row in reader:
     #print(row)
# datetime.datetime.strptime(' 15:26:17 14-11-2016'," %H:%M:%S %d-%m-%Y")
     m =  re.search('\d\d:',  row[2])
     if m :
        datetdeb  = datetime.datetime.strptime(row[2], " %H:%M:%S %d-%m-%Y")
        datetfin  = datetime.datetime.strptime(row[4], " %H:%M:%S %d-%m-%Y")
        duree = (datetfin - datetdeb)
        if datetdeb.day == datetfin.day:
             typesession = 'N'
             dur =  duree.seconds/3600
        if datetdeb.day != datetfin.day:
            if duree.days < 1:
             typesession = 'R'
             dur =  duree.seconds/3600
            else:
             typesession = 'M'
             dur =  duree.seconds/3600 + duree.days * 24
        s = Session(row[0], row[1], datetdeb, datetfin, dur , typesession,duree.days)
        periode.add(s)
       # print( dur ,typesession)
#for k in periode.jours:
#     print(k)
periode.flat()
#for k in periode.joursn:
#    print("{} : {}".format(k,len(periode.joursn[k]) ))
#print("robot")
#for k in periode.joursr:
#    print("{} : {}".format(k,len(periode.joursr[k]) ))
#print("Mixte")
#for k in periode.joursm:
#    print("{} : {}".format(k,len(periode.joursm[k]) ))
lsitj = sorted(periode.joursn)
deb= lsitj[0]
dated = datetime.datetime.strptime(deb, "%Y/%m/%d")
fin = lsitj[-1]
datef =datetime.datetime.strptime(fin, "%Y/%m/%d")
print("'{}:Date';'Journee';'Nuit';'Prolongee';'Total';'Ponderation';'Pour cent ({})'".format(label,quot))

_dx = dated
while _dx <= datef:
  _dxstr = _dx.strftime("%Y/%m/%d")
  if _dxstr in periode.jours:
     print("{};{}".format(_dxstr,periode.total(_dxstr)))
  else:
      print("{};0;0;0;0;0;0".format(_dxstr))
  _dx = _dx + datetime.timedelta(days=1)
