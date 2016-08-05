from datetime import date
class Cro:
    def __init__(self,crobase):
     self.id = crobase[0]
     self.CCROLOP = crobase[1]
     self.CTCLI =    crobase[2]
     self.CCROANOC = crobase[3]
     self.POSTE_   = crobase[4]
     self.CCPTIND   = crobase[5]
     self.COMPTE_  = crobase[6]
     self.SCPTTYP  = crobase[7]
     self.CCRODENO = crobase[8]
     self.DCRODENO = crobase[9]
     self.NCRODENO = crobase[10]
     self.CBOPNOTA = crobase[11]
     self.CCRODENI_1 = crobase[12]
     self.DCRODENI_1 = crobase[13]
     self.NCRODENI_1 = crobase[14]
     self.DCROOPE  = crobase[15]
     self.DCROVAL  = crobase[16]
     self.DCROREF  = crobase[17]
     self.NCROOPER  = crobase[18]
     self.numdep    = crobase[19]
     self.NCROREF =  crobase[20]
     self.CCRONOTI_1 = crobase[21]
     self.CBOPCONT = crobase[22]
     self.MCROOPE  = crobase[23]
     self.LCROECRF = crobase [24]
     self.LCROECRF_Sauve = crobase [24]
     self.lcrobana = crobase[25]
     self.lcroban2 = crobase[26]
     self.lfacnomd = crobase[27]
     self.dfactran = crobase[28]
     self.nporcart = crobase[29]
     self.ncrocpte = crobase[30]
     self.lcrolib1 = crobase[31]
     self.sfac1001 = crobase[32]
     self.lcrodorm = crobase[33]
     self.ncropie1 = crobase[34]
     self.lheclibe = crobase[35]
     self.mfaccomp = crobase[36]
     self.dfacrdab = crobase[37]
     self.typlibcr  = crobase[38]
     self.dbrmrecp  = crobase[39]
     self.nbrmordr  = crobase[40]
     self.ccrosche  =crobase[41]
     self.hfacrdab = crobase[42]
     self.dcrodene = crobase[43]
     self.ncroposd = crobase[44]
     self.cboprgpt = crobase[45]

     self.ecritures=[]
    def isCB(self):
        if self.typlibcr=='CB':
           return True
        else:
           return False
    def isdanslaJC(self):
         #TODO
         return False
    def get_lzvsecr1(self):
        return self.LCROECRF_Sauve[0:15]
    def get_lzvsecr2(self):
        return self.LCROECRF_Sauve[15:30]
    def ajusteCro_ano(self):
     """emule le M752323"""
     niveau = int(self.CCROANOC)
     if not niveau <  3:
          niveau -=3
          self.CCROANOC= str(niveau)
     return  self.CCROANOC
    def notageBool(self):
     if  self.CBOPNOTA > 0:
         return  True
     else:
         return False
    def get_ncroarr(self):
         return  self.POSTE_[0]
    def ecritureExtourneBool(self):
     """emule la C412323"""
     if  self.NCROREF  > 0 and self.DCROREF is not None:
         return  True
     else:
         return False
    def cle_pcta(self):
         return(self.CCROLOP+self.CTCLI+self.CCROANOC)
    def get_compte(self):
         return(self.POSTE_+self.CCPTIND+self.COMPTE_)
    def compte_clientBOOL(self):
         if   self.CCPTIND+self.COMPTE_ == '00000000':
             return False
         else:
             return True
    def isPrelVirBool(self):
        if self.typlibcr =='VP' and self.dbrmrecp != '00000000' and self.nbrmordr != '0000':
           return True
        else:
           return False

    def permuteZonelibelle(self):
        self.LCROECRF = self.get_lzvsecr2()
        self.LCROECRF.ljust(15,' ')
    def confectionNotageBool(self):
     """emule la C252323"""
     if self.CCRONOTI_1 == 'I' and self.CCRODENI_1 =='9999' and self.DCRODENI_1 is not None:
        return True
     else:
        return False
    def cle_ycte(self):
        return(self.CCPTIND + self.SCPTTYP)
    def infocpte(self):
     print("Cro à traiter: operation:{} sur compte {} du departement:{}".format(self.cle_pcta(),self.get_compte(),self.numdep))
     print("nb d ecriture comptable à generer:{}   reference PCTA: {} type de compte:{}".format(self.nbl,self.clefinale,self.cle_ycte()))
    def add_ecr(self,pseudo):
     self.ecritures.append(pseudo)
    def add_infos(self,lg,clefinale):
      self.nbl = lg
      self.clefinale  = clefinale
    def get_valeurPsql(self,tableau):
       tmphash={}
       for item in tableau:
           if item =='LCROBAN2' :
              tmphash[item] = self.lcroban2
           if item =='LCROLIB2' :
              tmphash[item] = self.lcrolib1
           if item =='LFACNOMD' :
              tmphash[item] = self.lfacnomd
           if item =='NPORCART' :
              tmphash[item] = self.nporcart
           if item =='NCROCPTE' :
              tmphash[item] = self.ncrocpte
           if item =='LCROECRF' :
              tmphash[item] = self.LCROECRF
           if item =='LCROLIB1' :
              tmphash[item] = self.lcrolib1
           if item =='SFAC1001' :
              tmphash[item] = self.sfac1001
           if item =='DFACTRAN' :
              tmphash[item] = self.dfactran
           if item =='LCROBANA' :
              tmphash[item] = self.lcrobana
           if item =='LCRODORM' :
              tmphash[item] = self.lcrodorm
           if item =='NCROPIE1' :
              tmphash[item] = self.ncropie1
           if item =='LHECLIBE' :
              tmphash[item] = self.lheclibe
           if item =='MFACCOMP' :
              tmphash[item] = self.mfaccomp
           if item =='DFACRDAB' :
              tmphash[item] = self.dfacrdab
       return tmphash
class StockageCro:
    def __init__(self):
        self.stockage=[]
    def add(self,item):
        self.stockage.append(item)
    def reset(self):
        self.stockage=[]


